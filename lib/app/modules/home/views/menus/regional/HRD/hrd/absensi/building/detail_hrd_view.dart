import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/shift_building/building.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_absen_controller/building/building_hrd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class DetailHrdView extends GetView<BuildingHrdController> {
  final Building? data;
  const DetailHrdView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    controller.setDetailData(data);

    final forms = controller.forms;

    return Scaffold(
      appBar: CustomAppbar(title: 'Building Detail').appBar,
      body: Padding(
        padding: const EdgeInsets.all(16),
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
                    label: 'Alamat',
                    model: forms.key('address'),
                  ),
                  Intrinsic(
                    gap: 10,
                    children: [
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
                ],
              ),
            ),
            Obx(() {
              final position = controller.buildingPosition.value;

              if (position != null) {
                return SizedBox(
                  height: 250,
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: position,
                      initialZoom: 16.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://api.maptiler.com/maps/basic/256/{z}/{x}/{y}.png?key=HvTLJYJCAeyfnf1yvmiE',
                        userAgentPackageName: 'com.example.qtech',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 80,
                            height: 80,
                            point: position,
                            child: const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Koordinat tidak valid.',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
