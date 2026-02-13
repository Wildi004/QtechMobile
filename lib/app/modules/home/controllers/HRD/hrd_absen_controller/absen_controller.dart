import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/shift_building/shift_building.dart';

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

  // Future getBuilding() async {
  //   try {
  //     isLoading.value = true;
  //     final res = await api.shiftBuilding.getData(query);

  //     buldList = ShiftBuilding.fromJsonList(res.data);

  //     if (res.data.isNotEmpty) {
  //       rxBuild.value = ShiftBuilding.fromJson(res.data[0]);
  //     }

  //     // Tambahkan ini agar data tampil di view
  //     buildr.value = buldList;
  //   } catch (e, s) {
  //     Errors.check(e, s);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

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
}
