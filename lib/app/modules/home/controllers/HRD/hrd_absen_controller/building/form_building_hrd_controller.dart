import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/shift_building/building.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class FormBuildingHrdController extends GetxController with Apis {
  final forms = LzForm.make(['name', 'address']);

  final latitudeLongitudeController = TextEditingController();
  final radiusController = TextEditingController();

  File? file;
  RxString fileName = ''.obs;
  Rxn<Building> building = Rxn<Building>();

  Rxn<LatLng> selectedLatLng = Rxn<LatLng>();

  void setLatLng(LatLng position) {
    selectedLatLng.value = position;
    latitudeLongitudeController.text =
        '${position.latitude}, ${position.longitude}';
  }

  void setRadius(double meter) {
    radiusController.text = meter.round().toString();
  }

  void calculateRadius(LatLng center, LatLng edge) {
    final Distance distance = Distance();
    final meter = distance.as(LengthUnit.Meter, center, edge);
    setRadius(meter);
  }

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*']);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['latitude_longtitude'] = latitudeLongitudeController.text;
        payload['radius'] = int.tryParse(radiusController.text) ?? 0;
        payload['user_id'] = auth.id;

        if (id == null) {
          final res = await api.building
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        } else {
          final res = await api.building
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
