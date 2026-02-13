import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_absen_controller/building/form_building_hrd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class SelectLocationView extends GetView<FormBuildingHrdController> {
  const SelectLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    const userAgent = 'com.example.qtech';
    logg('DEBUG: userAgentPackageName => $userAgent');

    return Scaffold(
      appBar: CustomAppbar(title: 'Pilih Lokasi di Peta').appBar,
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(-8.6500, 115.2167),
          initialZoom: 13.0,
          onTap: (tapPosition, point) {
            controller.setLatLng(point);

            final edge = LatLng(point.latitude + 0.001, point.longitude);
            controller.calculateRadius(point, edge);

            Get.back();
          },
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.maptiler.com/maps/streets/256/{z}/{x}/{y}.png?key=HvTLJYJCAeyfnf1yvmiE',
            userAgentPackageName: 'com.example.qtech',
          ),
          Obx(() {
            final selected =
                controller.selectedLatLng.value ?? LatLng(-8.6500, 115.2167);
            return MarkerLayer(
              markers: [
                Marker(
                  width: 80,
                  height: 80,
                  point: selected,
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
