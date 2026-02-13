import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pengajuan_logistik/detail.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pengajuan_logistik/pengajuan_logistik.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/ptj_logistik/detail_ptj.dart';

class CreatePtjRegLogistikController extends GetxController with Apis {
  DetailPtjLogistik? created;
  RxBool isLoading = true.obs;

  final forms = LzForm.make(['no_ptj', 'tgl_ptj', 'dep_name', 'type']);

  RxList<FormManager> formPengajuan = RxList([]);
  RxList<String> types = RxList([]);

  CreatePtjRegLogistikController(this.type);
  final String type;

  RxInt grandTotal = 0.obs;

  List<PengajuanLogistik> dataPengajuan = [];
  List<DetailPengajuanLogistik> dataPengajuanDetails = [];
  List<DetailPtjLogistik> dataPtj = [];

  RxString fileName = ''.obs;
  XFile? fileImage;
  File? file;

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await createPengajuan(type: type);
      ();
      await getPengajuanDetails();
      addPengajuam();
    });
  }

  Future<void> createPengajuan({required String type}) async {
    try {
      isLoading.value = true;
      final res = await api.ptjGlobal.createPtjLogistik(type: type);
      forms.fill(res.data ?? {});
      created = DetailPtjLogistik.fromJson(res.data ?? {});
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void addPengajuam() {
    final form = LzForm.make([
      'type',
      'tgl_ptj',
      'item_id',
      'proyek_item_id',
      'tgl_beli',
      'detail_pengajuan_id',
      'nama_barang',
      'qty',
      'harga_satuan',
      'image',
      'total'
    ]);
    formPengajuan.insert(0, form);
  }

  Future<void> getPengajuanDetails() async {
    if (dataPengajuanDetails.isEmpty) {
      final res = await api.pengajuanGlobal.getLogistikDetail().ui.loading();
      dataPengajuanDetails = DetailPengajuanLogistik.fromJsonList(res.data);
    }
  }

  void setUnit(String value, int index) {
    final item = dataPengajuanDetails.firstWhere(
      (e) => e.namaBarang == value,
      orElse: () => DetailPengajuanLogistik(),
    );

    if (item.totalHarga != null) {
      formPengajuan[index].set(
        'harga_satuan',
        item.totalHarga.currency(separator: ',', prefix: ''),
      );
    }

    countTotal(index);
  }

  void countTotal(int index) {
    int unit = (formPengajuan[index].get('harga_satuan') ?? '').numeric;
    int qty = (formPengajuan[index].get('qty') ?? '').numeric;

    int total = unit * qty;
    formPengajuan[index]
        .set('total', total.currency(separator: ',', prefix: ''));

    grandTotal.value = formPengajuan
        .map((e) => (e.get('total') ?? '0').numeric)
        .reduce((a, b) => a + b);
  }

  Future<void> onSubmit() async {
    try {
      if (created == null) {
        return Toast.show('Gagal');
      }

      if (fileImage == null) {
        return Toast.show('File image dan ttd harus diisi');
      }

      final namaBarangs =
          formPengajuan.map((e) => e.get('nama_barang') ?? '').toList();
      final tgls = formPengajuan.map((e) => e.get('tgl_beli') ?? '').toList();
      final qtys =
          formPengajuan.map((e) => (e.get('qty') ?? '0').numeric).toList();

      final hargas = formPengajuan
          .map((e) => (e.get('harga_satuan') ?? '0').numeric)
          .toList();

      final itemIds =
          formPengajuan.map((e) => e.get('item_id')).whereType<int>().toList();

      final proyekItemIds = formPengajuan
          .map((e) => e.get('proyek_item_id'))
          .whereType<int>()
          .toList();
      final detailPengajuanIds = formPengajuan
          .map((e) => e.get('detail_pengajuan_id'))
          .whereType<int>()
          .toList();
      final pengajuanDetailIds = formPengajuan.map((form) {
        final namaItem = form.get('nama_barang');
        final matched = dataPengajuanDetails.firstWhere(
          (d) => d.namaBarang == namaItem,
          orElse: () => DetailPengajuanLogistik(),
        );
        return matched.id ?? 0;
      }).toList();

      final imageFile = await api.toFile(fileImage!.path);

      final payload = {
        'no_ptj': created!.noPtj,
        'item_id[]': itemIds,
        'proyek_item_id[]': proyekItemIds,
        'detail_pengajuan_id[]': detailPengajuanIds,
        'nama_barang[]': namaBarangs,
        'tgl_beli[]': tgls,
        'qty[]': qtys,
        'harga_satuan[]': hargas,
        'pengajuan_detail_id': pengajuanDetailIds,
        'image[]': imageFile
      };

      final res = await api.ptjGlobal
          .updatePtjLogistik(payload, created!.noHide!)
          .ui
          .loading('Memproses...');

      if (res.status) {
        Get.back(result: res.data);
        Get.back();

        logg('STATUS: ${res.status}');
        logg('RES: ${res.data}');
        Get.snackbar('Berhasil', res.message ?? '');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
