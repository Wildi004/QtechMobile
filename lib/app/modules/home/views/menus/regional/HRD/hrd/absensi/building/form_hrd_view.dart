import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/shift_building/building.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_absen_controller/building/form_building_hrd_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_absen_controller/building/map/map_building_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class FormHrdView extends GetView<FormBuildingHrdController> {
  final Building? data;
  const FormHrdView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormBuildingHrdController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.latitudeLongitudeController.text =
          data!.latitudeLongtitude ?? '';
      controller.radiusController.text = data!.radius?.toString() ?? '';
    }

    return Scaffold(
      appBar: CustomAppbar(
        actions: [
          IconButton(
            onPressed: () {
              controller.onSubmit(data?.buildingId);
            },
            icon: Icon(Hi.tick04),
          )
        ],
        title: 'Form Building',
      ).appBar,
      body: LzListView(
        gap: 25,
        children: [
          LzForm.input(
            hint: 'Inputkan nama',
            label: 'Nama',
            model: forms.key('name'),
          ),
          LzForm.input(
            hint: 'Inputkan alamat',
            label: 'Alamat',
            model: forms.key('address'),
          ),

          /// Latitude & Longitude
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Latitude & Longitude', style: TextStyle()),
              SizedBox(height: 8),
              TextFormField(
                controller: controller.latitudeLongitudeController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Latitude, Longitude',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),

          /// Radius
          TextFormField(
            controller: controller.radiusController,
            decoration: const InputDecoration(
              labelText: 'Radius',
              hintText: 'Radius (meter)',
              border: OutlineInputBorder(),
            ),
          ),

          ElevatedButton.icon(
            onPressed: () {
              Get.to(() => const SelectLocationView());
            },
            icon: Icon(Icons.map),
            label: Text('Pilih Lokasi di Peta'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }
}
