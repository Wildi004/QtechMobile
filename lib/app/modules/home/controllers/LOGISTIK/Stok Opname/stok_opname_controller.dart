import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/opname_id.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/stok_opname/stok_opname.dart';

class StokOpnameController extends GetxController with Apis {
  final forms = LzForm.make([
    'id',
    'jenis_material',
  ]);

  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;
  RxList<OpnameId> detailDatas = <OpnameId>[].obs;
  RxBool isDetailLoading = false.obs;

  List<StokOpname> listData = [];
  RxList<StokOpname> datas = <StokOpname>[].obs;
  int page = 1, total = 0;

  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      final query = {'limit': 15};

      page = 1;
      isLoading.value = true;
      final res = await api.stokOpname.getData(query);
      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = StokOpname.fromJsonList(res.data);
      datas.value = listData;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future getDetail(int id) async {
    try {
      isDetailLoading.value = true;
      detailDatas.clear();

      final res = await api.stokOpname.getDataDetail(id);
      final body = res.body;

      logg("RAW DETAIL RESPONSE ===> $body");

      if (body is Map && body['material'] is List) {
        logg("MASUK KE LIST MATERIAL, length: ${body['material'].length}");
        detailDatas.value = (body['material'] as List)
            .map((e) => OpnameId.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } else if (body is List) {
        logg("MASUK KE LIST ROOT, length: ${body.length}");
        detailDatas.value = body
            .map((e) => OpnameId.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } else if (body is Map) {
        logg("MASUK KE SINGLE MAP");
        detailDatas.value = [
          OpnameId.fromJson(Map<String, dynamic>.from(body))
        ];
      } else {
        logg("RESPON TIDAK SESUAI");
      }

      logg("DETAIL DATAS LENGTH ===> ${detailDatas.length}");
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isDetailLoading.value = false;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    datas.value = listData
        .where((datas) =>
            datas.jenisMaterial?.toLowerCase().contains(searchQuery.value) ??
            false)
        .toList();
  }

  Future onPageInit() async {
    try {
      await getData();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateData(StokOpname data, int id) {
    try {
      final controller = Get.find<StokOpnameController>();
      int index = controller.datas.indexWhere((e) => e.id == id);

      logg('test');

      logg('--- index: $index');

      if (index != -1) {
        controller.datas[index] = data;
        controller.datas.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void insertData(StokOpname data) {
    listData.insert(0, data);
    isLoading.refresh();
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
          await api.stokOpname.deleteData(id).ui.loading('Menghapus...');
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
      final res = await api.stokOpname.getData(query);
      final data = StokOpname.fromJsonList(res.data);
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
}
