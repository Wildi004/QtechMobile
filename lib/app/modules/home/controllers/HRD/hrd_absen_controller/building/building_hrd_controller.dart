import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/shift_building/building.dart';

class BuildingHrdController extends GetxController with Apis {
  final forms =
      LzForm.make(['name', 'address', 'latitude_longtitude', 'radius']);
  RxString searchQuery = "".obs;
  RxBool isLoading = true.obs;
  var isExpanded = false.obs;

  List<Building> listBuilding = [];
  RxList<Building> building = <Building>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Rxn<LatLng> buildingPosition = Rxn<LatLng>();

  /// Untuk loading state

  /// Semua data building (list)

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.building.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listBuilding = Building.fromJsonList(res.data);
      building.value = listBuilding;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void setDetailData(Building? data) {
    if (data != null) {
      forms.fill(data.toJson());

      final latLngString = data.latitudeLongtitude ?? '';
      final parts = latLngString.split(',');
      final latitude =
          parts.length == 2 ? double.tryParse(parts[0].trim()) : null;
      final longitude =
          parts.length == 2 ? double.tryParse(parts[1].trim()) : null;

      if (latitude != null && longitude != null) {
        buildingPosition.value = LatLng(latitude, longitude);
      } else {
        buildingPosition.value = null;
      }
    } else {
      buildingPosition.value = null;
    }
  }

  Future delete(int id) async {
    try {
      final res = await api.building.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listBuilding.removeWhere((e) => e.buildingId == id);

      isLoading.refresh();

      Get.snackbar('Berhasil', res.message ?? '');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();

    for (var data in listBuilding) {
      logg('Deskripsi: ${data.buildingId}');
    }

    building.value = listBuilding
        .where((data) =>
            data.name?.toLowerCase().contains(searchQuery.value) ?? false)
        .toList();
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

  void insertData(Building data) {
    listBuilding.insert(0, data);
    isLoading.refresh();
  }

  void updateData(Building data, int id) {
    try {
      int index = listBuilding.indexWhere((e) => e.buildingId == id);
      if (index >= 0) {
        listBuilding[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listBuilding.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.building.getData(query);
      final data = Building.fromJsonList(res.data);
      listBuilding.addAll(data);
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
