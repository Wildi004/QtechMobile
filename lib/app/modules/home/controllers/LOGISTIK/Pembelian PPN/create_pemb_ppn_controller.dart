import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/alat_proyek.dart';

class CreatePembPpnController extends GetxController with Apis {
  final pageController = PageController();
  RxInt currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      addPo();
    });

    isLoading.value = false;
  }

  final forms = LzForm.make([
    'no_pembelian', //
    'shipment', //
    'tgl_beli', //
    'no_invoice', //
    'cara_pembayaran', //
    'jenis_pembayaran', //
    'term_from', //
    'term_to', //
    'suplier_id', //
    'diskon_ttl', //
    'ppn', //
    'biaya_kirim', //
    'total_harga', //
    'dpp_pembelian', //
    'ppn_total', //
    'total_pembelian', //
  ]);
  RxBool isLoading = true.obs;
  final rupiah = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  RxList<FormManager> formPo = RxList([]);
  RxList<int> cards = <int>[].obs;
  List cat = [];

  void addPo() {
    final form = LzForm.make([
      'kode_material',
      'nama_barang',
      'qty',
      'satuan_id',
      'harga_satuan',
      'diskon',
      'total_harga',
    ]);

    formPo.insert(0, form);
    final newId = (cards.isEmpty ? 0 : (cards.first + 1));
    cards.insert(0, newId);

    satsId.insert(0, null);
  }

  void removePo(int index) {
    formPo.removeAt(index);
    cards.removeAt(index);
    satsId.removeAt(index);
  }

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

  Future onSubmit([int? id]) async {
    try {
      logg('🔍 [onSubmit] Proses submit dimulai... id: $id');

      // buat daftar required awal
      final requiredFields = [
        'no_pembelian',
        'shipment',
        'tgl_beli',
        'no_invoice',
        'cara_pembayaran',
        'jenis_pembayaran',
        'suplier_id',
      ];

      // kalau pilih termin → tambahkan field tambahan
      if (forms.get('cara_pembayaran')?.toString().toLowerCase() == 'termin') {
        requiredFields.addAll(['term_from', 'term_to']);
      }

      // validasi header
      final head = forms.validate(required: requiredFields);
      logg('📝 [onSubmit] Hasil validasi header: ${head.ok} - ${head.value}');

      if (!head.ok) {
        Get.snackbar('Error', 'Form utama belum lengkap!');
        return;
      }

      // pastikan field angka ada default value
      forms.set('diskon_ttl', forms.get('diskon_ttl') ?? '0');
      forms.set('ppn', forms.get('ppn') ?? '0');
      forms.set('biaya_kirim', forms.get('biaya_kirim') ?? '0');

      // validasi detail form
      for (var f in formPo) {
        final det = f.validate(required: [
          'kode_material',
          'nama_barang',
          'qty',
          'satuan_id',
          'harga_satuan',
          'diskon',
        ]);

        if (!det.ok) {
          final missingFields = [
            'kode_material',
            'nama_barang',
            'qty',
            'satuan_id',
            'harga_satuan',
            'diskon',
          ]
              .where(
                  (key) => f.get(key) == null || f.get(key).toString().isEmpty)
              .toList();

          logg('❌ Detail belum lengkap, field kosong: $missingFields');
          Get.snackbar('Error', 'Detail PO belum lengkap! ($missingFields)');
          return;
        }

        logg('✅ Detail valid: ${det.value}');
      }

      final payload = {
        ...forms.value,
        'suplier_id': sup.firstWhere(
          (e) => e['nama_perusahaan'] == forms.get('suplier_id'),
          orElse: () => {'id': null},
        )['id'],

        // ini semua harus array dengan jumlah sama
        'kode_material': formPo.map((e) => e.get('kode_material')).toList(),

        'nama_barang': formPo.map((e) => e.get('nama_barang') ?? '').toList(),

        'satuan_id': satsId,
        'harga_satuan': formPo
            .map((e) =>
                (e.get('harga_satuan') ?? '0').toString().numeric.toString())
            .toList(),

        'qty': formPo
            .map((e) => (e.get('qty') ?? '0').toString().numeric.toString())
            .toList(),

        'diskon': formPo
            .map((e) => (e.get('diskon') ?? '0').toString().numeric.toString())
            .toList(),
      };

      final res =
          await api.pembPpn.createData(payload).ui.loading('Memproses...');

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

  final shipment = [
    {'name': 'Pick Up'},
    {'name': 'Delivery'},
  ];
  Future<List<Map>> getShipment() async {
    return shipment;
  }

  RxList<FormManager> supId = RxList<FormManager>();
  List<Map<String, dynamic>> sup = [];

  RxList<FormManager> satId = RxList<FormManager>();
  List<Map<String, dynamic>> sat = [];

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

  Future openSat(int index) async {
    final query = {'limit': 'all'};

    try {
      if (sat.isEmpty) {
        final res = await api.satuanLogistik.getData(query).ui.loading();
        sat = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      formPo[index].set('satuan_id', '').options(
            sat
                .where((e) => e['satuan'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['satuan'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxList<FormManager> stokId = RxList<FormManager>();
  List<Map<String, dynamic>> stok = [];
  Future openStok(int index) async {
    final query = {'limit': 'all'};

    try {
      if (stok.isEmpty) {
        final res = await api.stokMaterial.getData(query).ui.loading();
        stok = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      final opts = stok
          .where((e) => e['kode_material'] != null && e['id'] != null)
          .map((e) => {
                'label': '${e['kode_material']}',
                'value': e['id'],
              })
          .toList();

      if (opts.isEmpty) {
        return;
      }

      formPo[index].set('kode_material', '').options(opts);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future getBarang(int index, dynamic id) async {
    try {
      final intId = int.tryParse(id.toString()) ?? -1;

      final data = stok.firstWhere(
        (e) => e['id'] == intId,
        orElse: () => {},
      );

      if (data.isEmpty) {
        return Toast.show('Data tidak ditemukan');
      }

      formPo[index]
          .set('nama_barang', Option(data['nama_material_name'] ?? ''))
          .enable();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void hitungTotal() {
    double dpp = 0.0;

    // Hitung total harga per item
    for (var form in formPo) {
      double qty = double.tryParse(form.get('qty').toString()) ?? 0;
      double harga = double.tryParse(form
              .get('harga_satuan')
              .toString()
              .replaceAll('.', '')
              .replaceAll(',', '')) ??
          0;
      double diskon = double.tryParse(form.get('diskon').toString()) ?? 0;

      double total = qty * harga * (1 - (diskon / 100));
      form.set('total_harga', total.toStringAsFixed(0));

      dpp += total;
    }

    // ambil inputan user
    double diskonTotal =
        double.tryParse(forms.get('diskon_ttl').toString()) ?? 0;
    double ppnPersen = double.tryParse(forms.get('ppn').toString()) ?? 0;
    double biayaKirim =
        double.tryParse(forms.get('biaya_kirim').toString()) ?? 0;

    // Hitung PPN
    double ppnTotal = (dpp - diskonTotal) * (ppnPersen / 100);

    // Hitung Total Pembelian
    double totalPembelian = (dpp - diskonTotal) + ppnTotal + biayaKirim;

    // Set hasil ke form utama
    forms.set('dpp_pembelian', dpp.toStringAsFixed(0));
    forms.set('ppn_total', ppnTotal.toStringAsFixed(0));
    forms.set('total_pembelian', totalPembelian.toStringAsFixed(0));
  }

  List<String?> satsId = [];

  void openSelecKat(int index) {
    try {
      satsId[index] = formPo[index].extra('satuan_id');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
