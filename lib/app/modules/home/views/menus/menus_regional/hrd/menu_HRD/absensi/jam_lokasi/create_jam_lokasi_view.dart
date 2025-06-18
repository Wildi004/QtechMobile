import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/shift_building/shift_building.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_absen_controller/jam_lokasi/create_jam_lokasi_controller.dart';

class CreateJamLokasiView extends GetView<CreateJamLokasiController> {
  final ShiftBuilding? data;
  const CreateJamLokasiView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateJamLokasiController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Buat Shift dan Building",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 91, 122),
      ),
      body: LzListView(
        gap: 25,
        children: [
          LzForm.input(
              hint: ' ', label: 'Nama Lokasi', model: forms.key('name')),
          LzForm.input(
              hint: ' ', label: 'Shift', model: forms.key('shift_name')),
          LzForm.input(hint: ' ', label: 'Alamat', model: forms.key('address')),
          Row(
            children: [
              Expanded(
                  child: LzForm.input(
                label: 'Jam Masuk',
                model: forms.key('time_in'),
              )),
              Expanded(
                  child: LzForm.input(
                      label: 'Jam pulang', model: forms.key('time_out'))),
            ],
          ).gap(10),
          LzForm.input(hint: ' ', label: 'Radius', model: forms.key('radius')),
          LzForm.input(
              hint: ' ', label: 'Map', model: forms.key('latitude_longtitude')),
          LzButton(
            text: data == null ? 'Submit' : 'Update',
            onTap: () {
              controller.onSubmit(data?.id);
            },
          ).margin(all: 20),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
