import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/shift_building/shift_building.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class ShiftBuildingController extends GetxController with Apis {
  final forms = LzForm.make([
    "shift_name",
    "time_in",
    "time_out",
    "name",
    "address",
    "latitude_longtitude",
    "radius",
  ]);
  File? file;
  RxString fileName = ''.obs;
  List<ShiftBuilding> shiftBuilding = [];

  Rxn<ShiftBuilding> rxKar = Rxn<ShiftBuilding>();
  RxList<ShiftBuilding> shift = <ShiftBuilding>[].obs;
  RxBool isLoading = true.obs;

  void updateData(ShiftBuilding data, int id) {
    try {
      int index = shiftBuilding.indexWhere((e) => e.id == id);
      if (index >= 0) {
        shiftBuilding[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
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
}
