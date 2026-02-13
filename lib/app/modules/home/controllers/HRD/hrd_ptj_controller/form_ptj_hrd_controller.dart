import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/ptj_hrd/detail_ptj.dart';
import 'package:qrm_dev/app/data/models/pengajuan%20global/pengajuan%20sudah%20validasi/pengajuan_sudah_validasi/detail.dart';
import 'package:qrm_dev/app/data/models/pengajuan%20global/pengajuan%20sudah%20validasi/pengajuan_sudah_validasi/pengajuan_sudah_validasi.dart';

class FormPtjHrdController extends GetxController with Apis {
  DetailPtj? created;
  RxBool isLoading = true.obs;
  RxBool isSubmitted = false.obs;

  final forms = LzForm.make([
    'no_ptj',
    'tgl_ptj',
    'dep_name',
    'type',
    'proyek_item_id',
  ]);

  RxList<FormManager> formPengajuan = RxList([]);
  RxList<String> types = RxList([]);

  FormPtjHrdController(this.type);
  final String type;

  RxInt grandTotal = 0.obs;

  List<PengajuanSudahValidasi> dataPengajuan = [];
  List<DetailValidasi> dataPengajuanDetails = [];
  List<DetailPtj> dataPtj = [];

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
      final res = await api.ptjGlobal.createPengajuanHrd(type: type);
      forms.fill(res.data ?? {});
      created = DetailPtj.fromJson(res.data ?? {});
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

  Future<void> deletePtj(String noHide) async {
    try {
      await api.ptjGlobal.deleteDataPtjHrd(noHide);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future<void> getPengajuanDetails() async {
    if (dataPengajuanDetails.isEmpty) {
      final res =
          await api.pengajuanGlobal.getDataHrdDetail(limit: "all").ui.loading();
      dataPengajuanDetails = DetailValidasi.fromJsonList(res.data);
    }
  }

  void setUnit(String value, int index) {
    final item = dataPengajuanDetails.firstWhere(
      (e) => e.namaBarang == value,
      orElse: () => DetailValidasi(),
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

      // final detailPengajuanIds = formPengajuan
      //     .map((e) => e.get('detail_pengajuan_id'))
      //     .whereType<int>()
      //     .toList();
      final pengajuanDetailIds = formPengajuan.map((form) {
        final namaItem = form.get('nama_barang');
        final matched = dataPengajuanDetails.firstWhere(
          (d) => d.namaBarang == namaItem,
          orElse: () => DetailValidasi(),
        );
        return matched.id ?? 0;
      }).toList();

      final imageFile = await api.toFile(fileImage!.path);

      final proyekItemIds = formPengajuan
          .map((e) => e.get('proyek_item_id'))
          .whereType<int>()
          .toList();

      final payload = {
        'no_ptj': created!.noPtj,
        'item_id[]': itemIds,
        'detail_pengajuan_id[]': pengajuanDetailIds,
        'nama_barang[]': namaBarangs,
        'tgl_beli[]': tgls,
        'qty[]': qtys,
        'harga_satuan[]': hargas,
        'proyek_item_id[]': proyekItemIds,
        'image[]': imageFile
      };
      final res = await api.ptjGlobal
          .updateDataPtjHrd(payload, created!.noHide!)
          .ui
          .loading('Memproses...');

      if (res.status) {
        isSubmitted.value = true;

        Get.back(result: res.data);
        Get.back();

        logg('STATUS: ${res.status}');
        logg('RES: ${res.data}', limit: 99999);
        Get.snackbar('Berhasil', res.message ?? '');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxList<FormManager> proyekId = RxList<FormManager>();
  List<Map<String, dynamic>> proyek = [];

  Future getProyek(int? id) async {
    final res = await api.dataProyek.getDataBarat();
    proyek = List<Map<String, dynamic>>.from(res.data ?? []);

    final option = proyek.firstWhere((e) => e['id'] == id, orElse: () => {});

    if (option['id'] != null) {
      forms.set('proyek_item_id', option['uraian_pekerjaan']);
      forms.set('proyek_item_id',
          Option(option['uraian_pekerjaan'], value: option['id']));
    }
  }

  void setProyekItemName() {
    for (var form in formPengajuan) {
      final proyekItemId = form.get('proyek_item_id');
      if (proyekItemId != null) {
        final proyekData = proyek.firstWhere(
          (e) => e['id'].toString() == proyekItemId.toString(),
          orElse: () => {},
        );
        if (proyekData.isNotEmpty) {
          form.set('proyek_item_name', proyekData['uraian_pekerjaan'] ?? '-');
        } else {
          form.set('proyek_item_name', '-');
        }
      }
    }
  }

  Future openProyek() async {
    try {
      if (proyek.isEmpty) {
        final res = await api.dataProyek.getDataBarat().ui.loading();
        proyek = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      final opts = proyek
          .where((e) => e['uraian_pekerjaan'] != null && e['id'] != null)
          .map((e) => {
                'label': '${e['kode_proyek']} || ${e['uraian_pekerjaan']}',
                'value': e['id'],
              })
          .toList();

      if (opts.isEmpty) {
        return;
      }

      forms.set('proyek_item_id', '').options(opts);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
