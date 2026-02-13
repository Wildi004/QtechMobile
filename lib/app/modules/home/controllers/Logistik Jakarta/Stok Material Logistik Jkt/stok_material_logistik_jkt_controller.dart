import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/stok_material.dart';

class StokMaterialLogistikJktController extends GetxController with Apis {
  final forms = LzForm.make([
    'id',
    'kode_material',
    'kode_str',
    'jenispekerjaan_id',
    'jenismaterial_id',
    'namamaterial_id',
    'suplier_id',
    'brand',
    'qty',
    'harga_beli',
    'ongkir',
    'harga_modal',
    'total_modal',
    'created_at',
    'jenis_pekerjaan_name',
    'jenis_material_name',
    'nama_material_name',
    'created_by_name',
  ]);

  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;

  List<StokMaterial> listData = [];
  RxList<StokMaterial> data = <StokMaterial>[].obs;
  int page = 1, total = 0;

  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.stokMaterial.getDataJkt(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = StokMaterial.fromJsonList(res.data);
      data.value = listData;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    data.value = listData
        .where((datas) =>
            datas.namaMaterialName?.toLowerCase().contains(searchQuery.value) ??
            false)
        .toList();
  }

  void insertData(StokMaterial data) {
    listData.insert(0, data);
    isLoading.refresh();
  }

  void updateData(StokMaterial data, int id) {
    int index = listData.indexWhere((e) => e.id == id);
    if (index >= 0) {
      listData[index] = data;
      isLoading.refresh();
    }
  }

  Future onPageInit() async {
    try {
      await getData();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  Future deleteData(int id) async {
    try {
      final res =
          await api.stokMaterial.deleteDataJkt(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listData.removeWhere((e) => e.id == id);
      isLoading.refresh();
      Get.snackbar('Berhasil', res.message ?? '');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listData.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.stokMaterial.getDataJkt(query);
      final data = StokMaterial.fromJsonList(res.data);
      listData.addAll(data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      Utils.timer(() {
        isPaginate.value = false;
        isLoading.refresh();
      }, 1.s);
    }
  }

  void openFileWithTokenAndShowViewer(String imgUrl) {}
}
