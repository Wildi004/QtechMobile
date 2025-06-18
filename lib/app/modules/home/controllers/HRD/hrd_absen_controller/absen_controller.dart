import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/shift_building/shift_building.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class AbsenController extends GetxController with Apis {
  final forms = LzForm.make([
    "shift_name",
    "time_in",
    "time_out",
    "name",
    "address",
    "latitude_longtitude",
    "radius",
  ]);
  var tabIndex = 0.obs;
  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;

  var isExpanded = false.obs;
  List<ShiftBuilding> buldList = [];
  Rxn<ShiftBuilding> rxBuild = Rxn<ShiftBuilding>();
  RxList<ShiftBuilding> buildr = <ShiftBuilding>[].obs;

  int page = 1;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getBuilding() async {
    try {
      isLoading.value = true;
      final res = await api.shiftBuilding.getData(query);

      buldList = ShiftBuilding.fromJsonList(res.data);

      if (res.data.isNotEmpty) {
        rxBuild.value = ShiftBuilding.fromJson(res.data[0]);
      }

      // Tambahkan ini agar data tampil di view
      buildr.value = buldList;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void updateData(ShiftBuilding data, int id) {
    try {
      int index = buldList.indexWhere((e) => e.id == id);
      if (index >= 0) {
        buldList[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    buildr.value = buldList
        .where((data) =>
            data.building?.name?.toLowerCase().contains(searchQuery.value) ??
            false)
        .toList();
  }

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*']);

      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;

        if (id == null) {
          final res = await api.shiftBuilding
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
          }
        } else {
          final res = await api.shiftBuilding
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future delete(int id) async {
    try {
      final res =
          await api.shiftBuilding.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      buldList.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Toast.success('Data berhasil dihapus');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future onPageInit() async {
    try {
      await getBuilding();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    getBuilding();
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }
}
