import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/shift_building/building.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_absen_controller/building/form_building_hrd_controller.dart';

class FormHrdView extends GetView<FormBuildingHrdController> {
  final Building? data;
  const FormHrdView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormBuildingHrdController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Form",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 91, 122),
      ),
      body: LzListView(
        gap: 25,
        children: [
          LzForm.input(
              hint: 'Inputkan nama  ',
              label: 'Nama  ',
              model: forms.key('name')),
          LzForm.input(
              hint: 'Inputkan address  ',
              label: 'address  ',
              model: forms.key('address')),
          LzForm.input(
              hint: 'Inputkan latitude  ',
              label: 'latitude  ',
              model: forms.key('latitude')),
          LzForm.input(
              hint: 'Inputkan longtitude  ',
              label: 'longtitude  ',
              model: forms.key('longtitude')),
          LzForm.input(
              hint: 'Inputkan radius  ',
              label: 'radius  ',
              model: forms.key('radius')),
        ],
      ),
      bottomNavigationBar: LzButton(
        text: data == null ? 'Submit' : 'Update',
        onTap: () {
          controller.onSubmit(data?.buildingId);
        },
      ).margin(all: 20),
    );
  }
}
