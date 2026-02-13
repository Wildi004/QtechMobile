import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/alat_proyek.dart';

class CreatePoPpnLogistikController extends GetxController with Apis {
  final pageController = PageController();
  RxInt currentPage = 0.obs;

  RxBool showLeftArrow = false.obs;
  RxBool showRightArrow = false.obs;

  Timer? _idleTimer;

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      addPo();
    });

    isLoading.value = false;
  }

  @override
  void onClose() {
    _idleTimer?.cancel();
    super.onClose();
  }

  final forms = LzForm.make([
    'no_po',
    'tgl_po',
    'delivery_date',
    'cara_pembayaran',
    'catatan',
    'term_from',
    'term_to',
    'jenis_pembayaran',
    'shipment',
    'suplier_id',
    'lokasi_pengiriman',
    'tax',
    'freight_cost',
    'dp',
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

  List<String?> satuans = [];

  void addPo() {
    final form = LzForm.make([
      'nama_barang',
      'satuan_id',
      'unit_price',
      'qty',
      'diskon',
      'amount',
    ]);

    formPo.insert(0, form);
    final newId = (cards.isEmpty ? 0 : (cards.first + 1));
    cards.insert(0, newId);
    satuans.insert(0, null);

    cat.insert(0, null);
  }

  void removePo(int index) {
    formPo.removeAt(index);
    cards.removeAt(index);
    cat.removeAt(index);
    satuans.removeAt(index);

    hitungTotal();
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

  RxDouble subTotal = 0.0.obs;
  RxDouble taxValue = 0.0.obs;
  RxDouble freightCostValue = 0.0.obs;
  RxDouble grandTotal = 0.0.obs;
  RxDouble jmlDp = 0.0.obs;

  void hitungTotal() {
    double total = 0;

    for (var f in formPo) {
      int qty = int.tryParse(
              f.get('qty')?.toString().replaceAll(RegExp(r'[^0-9]'), '') ??
                  '0') ??
          0;

      double harga = double.tryParse(f
                  .get('unit_price')
                  ?.toString()
                  .replaceAll(RegExp(r'[^0-9]'), '') ??
              '0') ??
          0;

      double subtotal = qty * harga;

      double diskonPersen = double.tryParse(
              f.get('diskon')?.toString().replaceAll(RegExp(r'[^0-9]'), '') ??
                  '0') ??
          0;

      double diskon = subtotal * (diskonPersen / 100);

      double amount = subtotal - diskon;
      if (amount < 0) amount = 0;

      total += amount;

      f.set('amount', rupiah.format(amount));
    }

    subTotal.value = total;

    double tax = double.tryParse(forms.get('tax') ?? '0') ?? 0;
    taxValue.value = (total * tax / 100);

    double freight = double.tryParse(forms.get('freight_cost') ?? '0') ?? 0;
    freightCostValue.value = freight;

    // grand total
    grandTotal.value = subTotal.value + taxValue.value + freightCostValue.value;

    // DP
    double dp = double.tryParse(forms.get('dp') ?? '0') ?? 0;
    jmlDp.value = (grandTotal.value * dp / 100);
  }

  void onChange(int index, String type) {
    if (type == 'priority') {
      cat[index] = formPo[index].extra('kategori_rab');
    }
  }

  Future onSubmit([int? id]) async {
    try {
      final head = forms.validate(required: [
        'no_po',
        'tgl_po',
        'delivery_date',
        'cara_pembayaran',
        'jenis_pembayaran',
        'shipment',
        'suplier_id',
        'lokasi_pengiriman',
      ]);
      if (!head.ok) {
        Get.snackbar('Error', 'Form utama belum lengkap!');
        return;
      }

      for (var f in formPo) {
        f.validate(required: [
          'nama_barang',
          'satuan_id',
          'unit_price',
          'qty',
          'diskon',
        ]);
      }

      final payload = {
        ...forms.value,
        'satuan_id': satuans,
        'suplier_id': sup.firstWhere(
          (e) => e['nama_perusahaan'] == forms.get('suplier_id'),
          orElse: () => {'id': null},
        )['id'],
        'nama_barang': formPo.map((e) => e.get('nama_barang') ?? '').toList(),
        'unit_price': formPo
            .map((e) =>
                (e.get('unit_price') ?? '0').toString().numeric.toString())
            .toList(),
        'qty': formPo
            .map((e) => (e.get('qty') ?? '0').toString().numeric.toString())
            .toList(),
        'diskon': formPo
            .map((e) => (e.get('diskon') ?? '0').toString().numeric.toString())
            .toList(),
      };
      logg('suplier_id: ${forms.get('suplier_id')}');
      logg('satuan_id: ${formPo.map((e) => e.get('satuan_id')).toList()}');

      final res =
          await api.poPpn.createData(payload).ui.loading('Memproses...');
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

  void onSelectSatuan(int index) {
    try {
      satuans[index] = formPo[index].extra('satuan_id');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
