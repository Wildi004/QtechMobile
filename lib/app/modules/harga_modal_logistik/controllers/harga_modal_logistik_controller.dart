import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/modal_logistik.dart';

class HargaModalLogistikController extends GetxController with Apis {
  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;

  List<ModalLogistik> listHargaModal = [];
  RxList<ModalLogistik> rxHargaModal = <ModalLogistik>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final forms = LzForm.make([
    'id',
    'kode_material',
    'nama',
    'tgl_input',
    'tgl_berlaku',
    'qty',
    'satuan',
    'harga_satuan',
    'harga_diskon',
    'ppn',
    'total_ppn',
    'sub_total',
    'ongkir',
    'harga_modal',
    'lokasi',
    'user_id',
    'supplier',
    'keterangan',
    'user_name',
    'supplier_name',
  ]);

  Future getLogistik() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.modalLogistik.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listHargaModal = ModalLogistik.fromJsonList(res.data);
      // final logis = ModalLogistik.fromJson(res.data);
      rxHargaModal.value = listHargaModal;

      logg('data satuan logistik $listHargaModal');
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteData(int id) async {
    try {
      final res =
          await api.modalLogistik.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listHargaModal.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Toast.success('Data berhasil dihapus');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    rxHargaModal.value = listHargaModal
        .where((logistik) =>
            logistik.kodeMaterial?.toLowerCase().contains(searchQuery.value) ??
            false)
        .toList();
  }

  Future onPageInit() async {
    try {
      await getLogistik();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getLogistik();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void insertData(ModalLogistik data) {
    listHargaModal.insert(0, data);
    isLoading.refresh();
  }

  void updateData(ModalLogistik data, int id) {
    try {
      int index = listHargaModal.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listHargaModal[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listHargaModal.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.modalLogistik.getData(query);
      final data = ModalLogistik.fromJsonList(res.data);
      listHargaModal.addAll(data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      Utils.timer(() {
        isPaginate.value = false;
        isLoading.refresh();
      }, 1.s);
    }
  }
}
