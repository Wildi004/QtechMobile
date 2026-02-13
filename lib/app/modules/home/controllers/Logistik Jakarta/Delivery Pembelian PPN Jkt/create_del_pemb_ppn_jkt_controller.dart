import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_pemb_ppn/del_pemb_ppn.dart';

class CreateDelPembPpnJktController extends GetxController with Apis {
  DelPembPpn? created;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'no_pembelian',
    'no_delivery',
    'kode_material',
    'shipment_date',
    'received_date',
    'lokasi_pengiriman',
    'penerima',
    'ekspedisi',
    'harga_ekspedisi',
  ]);

  @override
  void onInit() {
    createPemb();
    super.onInit();
  }

  Future<void> createPemb() async {
    try {
      isLoading.value = true;
      final res = await api.delPembPpn.createDataJkt();
      forms.fill(res.data ?? {});
      created = DelPembPpn.fromJson(res.data ?? {});
      logg('[CREATE] createPengajuan response: ${res.data}');
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  RxList<FormManager> formDetail = <FormManager>[].obs;

  List<Map<String, dynamic>> pemb = [];
  List<Map<String, dynamic>> sat = [];

  Future openPemb() async {
    final query = {'limit': 'all'};
    try {
      if (pemb.isEmpty) {
        final res = await api.pembPpn.getDataJkt(query).ui.loading();
        pemb = List<Map<String, dynamic>>.from(res.data ?? []);
        logg('[pembelian] jumlah data pembelian: ${pemb.length}');
      }

      forms.set('no_pembelian', '').options(
            pemb
                .where((e) => e['no_pembelian'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['no_pembelian'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void onSelectPemb(String id) {
    logg('[onSelectPemb] id terpilih: $id');
    final selected = pemb.firstWhere(
      (e) => e['id'].toString() == id,
      orElse: () => <String, dynamic>{},
    );

    if (selected.isEmpty) {
      logg('[onSelectPemb] PO tidak ditemukan');
      return;
    }

    final details = List<Map<String, dynamic>>.from(selected['detail'] ?? []);
    logg('[onSelectPemb] Jumlah detail PO: ${details.length}');
    logg('[onSelectPemb] Data detail: $details');

    formDetail.clear();
    for (var d in details) {
      final form = LzForm.make([
        'item_id',
        'nama_barang',
        'jumlah_keluar',
        'berat_satuan',
        'qty',
        'total',
        'kode_material'
      ]);

      form.set('item_id', d['id']?.toString() ?? '');
      form.set('nama_barang', d['nama_barang'] ?? '');
      form.set('qty', d['qty']?.toString() ?? '0');
      form.set('jumlah_keluar', d['jumlah_keluar']?.toString() ?? '0');
      form.set('berat_satuan', d['berat_satuan']?.toString() ?? '0');
      form.set('kode_material', d['kode_material'] ?? '');
      formDetail.add(form);
    }

    logg('[ON_SELECT_PO] formDetail count: ${formDetail.length}');
  }

  Future openKodeMat(int index) async {
    try {
      if (sat.isEmpty) {
        final res = await api.stokMaterial.getData().ui.loading();
        sat = List<Map<String, dynamic>>.from(res.data ?? []);
        logg('[OPEN_KODE_MAT] jumlah material: ${sat.length}');
      }

      if (sat.isEmpty) {
        Toast.warning('Data material masih kosong');
        return;
      }

      formDetail[index].set('kode_material', '').options(
            sat
                .where((e) => e['kode_material'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['kode_material'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future<void> onSubmit() async {
    try {
      if (created == null) {
        return Toast.show('Tidak dapat diproses.');
      }

      final itemIds = formDetail
          .map((form) {
            final id = form.get('item_id');
            return id is int ? id : null;
          })
          .whereType<int>()
          .toList();

      final namaBarangs = formDetail
          .map((e) => e.get('nama_barang')?.toString() ?? '')
          .toList();

      final kodeMaterials = formDetail
          .map((e) => e.get('kode_material')?.toString() ?? '')
          .toList();

      final qtys =
          formDetail.map((e) => e.get('qty')?.toString() ?? '0').toList();

      final beratSatuans = formDetail
          .map((e) => e.get('berat_satuan')?.toString() ?? '0')
          .toList();

      final jumlahKeluars = formDetail
          .map((e) => e.get('jumlah_keluar')?.toString() ?? '0')
          .toList();

      final payload = {
        'no_delivery': created!.noDelivery,
        "no_pembelian": forms.get('no_pembelian') ?? '',
        'item_id': itemIds,
        "shipment_date": forms.get('shipment_date') ?? '',
        "received_date": forms.get('received_date') ?? '',
        "lokasi_pengiriman": forms.get('lokasi_pengiriman') ?? '',
        "penerima": forms.get('penerima') ?? '',
        "ekspedisi": forms.get('ekspedisi') ?? '',
        "harga_ekspedisi":
            num.tryParse(forms.get('harga_ekspedisi')?.toString() ?? '0') ?? 0,
        "nama_barang": namaBarangs,
        "kode_material": kodeMaterials,
        "qty": qtys,
        "berat_satuan": beratSatuans,
        "jumlah_keluar": jumlahKeluars,
      };

      logg('[PAYLOAD] $payload');

      final res = await api.delPembPpn
          .updateDataJkt(payload, created!.noHide!)
          .ui
          .loading('Memproses...');

      logg('[RESPONSE] ${res.data}');

      if (res.status) {
        Get.back(result: res.data);
        Get.snackbar('Berhasil', res.message ?? '');
      } else {
        Get.snackbar('Gagal', res.message.toString());
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void hitungTotal(int index) {
    try {
      final form = formDetail[index];

      final jumlah = double.tryParse(form.get('jumlah_keluar') ?? '0') ?? 0;
      final berat = double.tryParse(form.get('berat_satuan') ?? '0') ?? 0;
      final total = jumlah * berat;

      // Format ke dalam bentuk Rupiah
      final formatter = NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
        decimalDigits: 0,
      );

      final totalFormatted = formatter.format(total);

      form.set('total', totalFormatted);
      logg(
          '[HITUNG_TOTAL] index: $index | jumlah: $jumlah | berat: $berat | total: $totalFormatted');
    } catch (e) {
      logg('[HITUNG_TOTAL_ERROR] $e');
    }
  }
}

/**
 * import 'dart:async';
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
    final caraBayar = forms.get('cara_pembayaran') ?? '';
    final tglInv = forms.get('tgl_inv') ?? '';

    // Validasi termin
    if (caraBayar == 'Termin') {
      final termFrom = forms.get('term_from');
      final termTo = forms.get('term_to');
      if (termFrom!.isEmpty || termTo!.isEmpty) {
        Get.snackbar('Error', 'Tanggal "Term From" dan "Term To" wajib diisi!');
        return;
      }
    } else {
      forms.set('term_from', tglInv);
      forms.set('term_to', tglInv);
    }

    // Validasi field wajib
    final noInvoice = forms.get('no_invoice')?.trim() ?? '';
    final noDelivery = forms.get('no_delivery')?.trim() ?? '';
    final receivedDate = forms.get('received_date')?.trim() ?? '';
    final suplierId = sup.firstWhere(
      (e) => e['nama_perusahaan'] == forms.get('suplier_id'),
      orElse: () => {'id': null},
    )['id'];

    if (noInvoice.isEmpty ||
        tglInv.isEmpty ||
        caraBayar.isEmpty ||
        noDelivery.isEmpty ||
        receivedDate.isEmpty ||
        suplierId == null) {
      Get.snackbar('Error', 'Semua field wajib diisi!');
      return;
    }

    if (selectedPo['detail'] == null || selectedPo['detail'].isEmpty) {
      Get.snackbar('Error', 'Detail barang tidak ada di data delivery!');
      return;
    }

    // Gunakan data detail persis dari API, jangan ambil dari form user
    final detailPayload = List<Map<String, dynamic>>.from(selectedPo['detail']).map((d) {
      return {
        "kode_material": d['kode_material'],
        "nama_barang": d['nama_barang'],
        "qty": d['qty'],
        "harga_satuan": d['harga_satuan'],
        // "total" jangan dikirim
      };
    }).toList();

    final payload = {
      "no_invoice": noInvoice,
      "tgl_inv": tglInv,
      "cara_pembayaran": caraBayar,
      "suplier_id": suplierId,
      "no_delivery": noDelivery,
      "received_date": receivedDate,
      "term_from": forms.get('term_from')?.trim(),
      "term_to": forms.get('term_to')?.trim(),
      "catatan": forms.get('catatan')?.trim(),
      "ppn": forms.get('ppn')?.trim(),
      "subtotal": forms.get('subtotal')?.trim(),
      "total_tax": forms.get('total_tax')?.trim(),
      "grand_total": forms.get('grand_total')?.trim(),
      "detail": detailPayload,
    };

    if (file != null) {
      payload['image'] = await api.toFile(file!.path);
    }

    final res = await api.invDelPoPpn.createData(payload).ui.loading('Memproses...');

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
    // final query = {'limit': 'all'};

    try {
      if (sup.isEmpty) {
        final res = await api.supplier.getData().ui.loading();
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

 */
