import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/alat_proyek.dart';

class CreateInvDelPoPpnController extends GetxController with Apis {
  RxInt currentPage = 0.obs;

  final forms = LzForm.make([
    'no_invoice',
    'tgl_inv',
    'image',
    'suplier_id',
    'cara_pembayaran',
    'term_from',
    'term_to',
    'catatan',
    'no_delivery',
    'received_date',
    'ppn',
    'subtotal',
    'total_tax',
    'grand_total',
  ]);

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) async {});

    isLoading.value = false;
  }

  void onSelectPo(String id) async {
    logg('[ON_SELECT_PO] id terpilih: $id');

    // Ambil data detail delivery langsung dari API
    final res = await api.delPoPpn.getDataNoHide(id);
    if (!res.status) {
      Toast.show('Gagal ambil data delivery');
      return;
    }

    final selected = res.data; // Data delivery lengkap
    selectedPo = selected;

    // Isi received_date otomatis
    final receivedDate = selected['received_date'] ?? '';
    if (receivedDate.isNotEmpty) {
      forms.set('received_date', receivedDate);
    }

    // Kosongkan formDetail lama
    formDetail.clear();

    // Isi ulang dengan data dari API delivery
    final details = List<Map<String, dynamic>>.from(selected['detail'] ?? []);
    for (var d in details) {
      final form = LzForm.make([
        'kode_material',
        'nama_barang',
        'qty',
        'harga_satuan',
        'total',
      ]);

      form.set('kode_material', d['kode_material'] ?? '');
      form.set('nama_barang', d['nama_barang'] ?? '');
      form.set('qty', d['qty']?.toString() ?? '0');
      form.set('harga_satuan', d['harga_satuan']?.toString() ?? '0');
      form.set('total', d['total']?.toString() ?? '0');

      formDetail.add(form);
    }

    logg('[ON_SELECT_PO] formDetail diisi dari API: ${formDetail.length}');
  }

  final formatRupiah = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  void hitungTotal(int index) {
    final form = formDetail[index];
    final qty = double.tryParse(form.get('qty') ?? '0') ?? 0;

    // Bersihkan nilai harga dari format Rp dan titik
    final hargaStr = form.get('harga_satuan') ?? '0';
    final hargaClean = hargaStr.replaceAll(RegExp(r'[^0-9]'), '');
    final harga = double.tryParse(hargaClean) ?? 0;

    final total = qty * harga;

    // Simpan total dalam format rupiah
    form.set('total', formatRupiah.format(total));

    logg(
        '[HITUNG_TOTAL] index: $index | qty: $qty | harga: $harga | total: $total');

    updateSubtotal();
  }

  void updateSubtotal() {
    double subtotal = 0;

    // Hitung subtotal dari semua barang
    for (var form in formDetail) {
      final totalString = form.get('total') ?? '0';
      final totalClean = totalString.replaceAll(RegExp(r'[^0-9]'), '');
      final total = double.tryParse(totalClean) ?? 0;
      subtotal += total;
    }

    // Bersihkan nilai PPN dari format apa pun (kalau user ketik 10.000 misalnya)
    final taxPercentStr = forms.get('ppn') ?? '0';
    final taxPercentClean = taxPercentStr.replaceAll(RegExp(r'[^0-9]'), '');
    final taxPercent = double.tryParse(taxPercentClean) ?? 0;

    // Hitung pajak dan grand total
    final tax = subtotal * taxPercent / 100;
    final grandTotal = subtotal + tax;

    // Simpan hasil dalam format rupiah
    forms.set('subtotal', formatRupiah.format(subtotal));
    forms.set('total_tax', formatRupiah.format(tax));
    forms.set('grand_total', formatRupiah.format(grandTotal));

    logg('[SUBTOTAL] $subtotal | [TAX] $tax | [GRAND TOTAL] $grandTotal');
  }

  void onTaxChanged(String val) {
    updateSubtotal();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  RxBool isLoading = true.obs;

  RxList<FormManager> formPo = RxList([]);
  RxList<int> cards = <int>[].obs;

  List<String?> satuans = [];

  Rxn<AlatProyek> aset = Rxn<AlatProyek>();
  RxString caraPembayaran = ''.obs;

  final pemb = [
    {'name': 'Normal'},
    {'name': 'Backup Cek'},
  ];

  Future<List<Map>> getPemb() async {
    return pemb;
  }

  int parseNumber(dynamic value) {
    if (value == null) return 0;
    final cleaned = value.toString().replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleaned) ?? 0;
  }

  Map<String, dynamic> selectedPo = {};

  RxString fileName = ''.obs;
  XFile? fileImage;
  File? file;
  Future onSubmit([int? id]) async {
    try {
      // ✅ Validasi dasar

      if (caraPembayaran.value == 'Termin') {
        final termFrom = forms.get('term_from');
        final termTo = forms.get('term_to');

        if (termFrom!.isEmpty || termTo!.isEmpty) {
          Get.snackbar('Error',
              'Tanggal "Term From" dan "Term To" wajib diisi untuk pembayaran Termin!');
          return;
        }
      } else {
        // 🟢 Jika bukan Termin, isi otomatis agar tidak null di server
        final tglInv = forms.get('tgl_inv');
        forms.set('term_from', tglInv);
        forms.set('term_to', tglInv);
      }

      // ✅ Pastikan ada detail barang

      // 🧱 Bangun payload
      final payload = {
        ...forms.value,
        'suplier_id': sup.firstWhere(
          (e) => e['nama_perusahaan'] == forms.get('suplier_id'),
          orElse: () => {'id': null},
        )['id'],
      };

      // 🔁 Detail barang
      for (int i = 0; i < formDetail.length; i++) {
        final form = formDetail[i];
        final kode = form.get('kode_material') ?? '';
        final nama = form.get('nama_barang') ?? '';

        logg('Nama di payload [${i + 1}]: "$nama"');

        payload['kode_material[$i]'] = kode.trim();
        payload['nama_barang[$i]'] = nama.trim();
        payload['qty[$i]'] = form.get('qty') ?? '0';
        payload['harga_satuan[$i]'] = form.get('harga_satuan') ?? '0';
      }

      // 📎 File
      if (file != null) {
        payload['image'] = await api.toFile(file!.path);
      }

      final res =
          await api.invDelPoPpn.createData(payload).ui.loading('Memproses...');

      if (res.status) {
        Get.back(result: res.data);
        Get.snackbar('Berhasil', res.message ?? '');
      } else {
        Toast.show(res.message ?? 'Gagal mengirim data');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxList<FormManager> supId = RxList<FormManager>();
  List<Map<String, dynamic>> sup = [];

  Future openSupp() async {
    final query = {'limit': 'all'};

    try {
      if (sup.isEmpty) {
        final res = await api.supplier.getData(query).ui.loading();
        sup = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      forms.set('suplier_id', '').options(
            sup
                .where((e) => e['nama_perusahaan'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['nama_perusahaan'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
      logg('== Suplier terpilih: ${forms.get('suplier_id')}');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  List<Map<String, dynamic>> po = [];

  Future openInv() async {
    final query = {'limit': 'all'};
    try {
      if (po.isEmpty) {
        final res = await api.delPoPpn.getData(query).ui.loading();
        po = List<Map<String, dynamic>>.from(res.data ?? []);
        logg('[OPEN_PO] jumlah data PO: ${po.length}');
      }

      forms.set('no_delivery', '').options(
            po
                .where((e) => e['no_delivery'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['no_delivery'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxList<FormManager> formDetail = <FormManager>[].obs;
}

void debugCompareNama(String namaPayload, String namaDelivery) {
  final diff = [];
  for (int i = 0; i < namaPayload.length || i < namaDelivery.length; i++) {
    final c1 = i < namaPayload.length ? namaPayload[i] : '_';
    final c2 = i < namaDelivery.length ? namaDelivery[i] : '_';
    if (c1 != c2) {
      diff.add('Pos $i: "$c1" != "$c2"');
    }
  }
  logg('[PERBANDINGAN KARAKTER] ${diff.join(', ')}');
}
