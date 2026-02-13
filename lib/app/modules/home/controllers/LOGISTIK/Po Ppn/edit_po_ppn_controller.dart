import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Bindings;
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/alat_proyek.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/po_ppn/detail.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/po_ppn/po_ppn.dart';

class EditPoPpnController extends GetxController with Apis {
  RxInt currentPage = 0.obs;
  RxBool isLoading = true.obs;
  PoPpn? data;
  PoPpn details = PoPpn();
  RxList<DetailPpn> cards = RxList([]);
  RxList<FormManager> formData = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();
  PoPpn? details1;

  Future getDetails(PoPpn? data) async {
    try {
      String? nohide = data?.noHide;
      final res = await api.poPpn.getDataNoHide(nohide);
      details = PoPpn.fromJson(res.data ?? {});
      cards.value = (details.detail ?? []).cast<DetailPpn>();

      formPo.value = cards.map((e) {
        final form = LzForm.make([
          'nama_barang',
          'qty',
          'satuan_id',
          'unit_price',
          'diskon',
          'amount'
        ]);

        form.fill({
          'nama_barang': e.namaBarang ?? '',
          'qty': e.qty?.toString() ?? '0',
          'satuan_id': e.satuanId?.toString() ?? '',
          'unit_price': e.unitPrice?.toString() ?? '0',
          'diskon': e.diskon?.toString() ?? '0',
        });

        return form;
      }).toList();

      satuans = cards.map((e) => e.satuanId?.toString()).toList();

      // 🟢 Tambahkan ini supaya list seimbang panjangnya
      card.value = List.generate(cards.length, (i) => i);
      cat = List.generate(cards.length, (i) => null);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future getDetailData(String? nohide) async {
    try {
      Bindings.onRendered(() async {
        Toast.overlay('Loading...', onCancel: () {});

        if (details1 == null) {
          final res = await api.poPpn.getDataNoHide(nohide);
          details1 = PoPpn.fromJson(res.data ?? {});
        }

        forms.fill(details1!.toJson());

        forms.set(
          'suplier_id',
          Option(details1!.suplierName ?? '-', value: details1!.suplierId),
        );

        await getSupp(details1!.suplierId);

        Toast.dismiss();
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (formPo.isEmpty) addPo();
    });

    isLoading.value = false;
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

  final rupiah = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  RxList<FormManager> formPo = RxList([]);
  RxList<int> card = <int>[].obs;
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

    // tambahkan ID baru
    final newId = (card.isEmpty ? 0 : (card.first + 1));
    card.insert(0, newId);

    // tambahkan data default di list lain
    satuans.insert(0, null);
    cat.insert(0, null);
  }

  void removePo(int index) {
    logg('removePo index $index');
    logg('formPo length: ${formPo.length}');
    logg('card length: ${card.length}');
    logg('cat length: ${cat.length}');
    logg('satuans length: ${satuans.length}');

    formPo.removeAt(index);
    card.removeAt(index);
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
      final dataForm = Map<String, dynamic>.from(forms.value);
      final itemId = cards.map((e) => e.id).where((id) => id != null).toList();

      if (dataForm['cara_pembayaran'].toString().toLowerCase() == 'cash') {
        dataForm.remove('term_from');
        dataForm.remove('term_to');
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
      logg('catatan');
      final payload = {
        ...dataForm,
        'catatan': (dataForm['catatan'] ?? '-').toString().isEmpty
            ? '-'
            : dataForm['catatan'].toString(),
        'suplier_id': (forms.extra('suplier_id') is Option)
            ? int.tryParse(
                (forms.extra('suplier_id') as Option).value.toString())
            : int.tryParse(forms.extra('suplier_id')?.toString() ?? '0'),
        'item_id': itemId,
        'satuan_id': satuans,
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

      logg(payload);
      logg('suplier_id: ${forms.get('suplier_id')}');
      logg('satuan_id: ${formPo.map((e) => e.get('satuan_id')).toList()}');

      final res = await api.poPpn
          .updateData(payload, data!.noHide!)
          .ui
          .loading('Memproses...');
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

  List<Map<String, dynamic>> sups = [];

  Future getSupp(int? id) async {
    final query = {'limit': 'all'};

    final res = await api.supplier.getData(query);
    sups = List<Map<String, dynamic>>.from(res.data ?? []);

    final option = sups.firstWhere((e) => e['id'] == id, orElse: () => {});

    if (option['id'] != null) {
      // ✅ hanya satu kali set, dengan Option
      forms.set(
        'suplier_id',
        Option(option['nama_perusahaan'], value: option['id']),
      );
    }
  }
}
