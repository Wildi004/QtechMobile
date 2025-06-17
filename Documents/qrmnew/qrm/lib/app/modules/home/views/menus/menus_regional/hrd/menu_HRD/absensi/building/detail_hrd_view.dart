import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/shift_building/building.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_absen_controller/building/building_hrd_controller.dart';

class DetailHrdView extends GetView<BuildingHrdController> {
  final Building? data;
  const DetailHrdView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Building Detail',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: ['4CA1AF'.hex, '808080'.hex],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: LzListView(
                gap: 20,
                children: [
                  LzForm.input(
                    enabled: false,
                    label: 'Name',
                    model: forms.key('name'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Almanat',
                    model: forms.key('address'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Latitude',
                    model: forms.key('latitude_longtitude'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Radius Absensi',
                    model: forms.key('radius'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
