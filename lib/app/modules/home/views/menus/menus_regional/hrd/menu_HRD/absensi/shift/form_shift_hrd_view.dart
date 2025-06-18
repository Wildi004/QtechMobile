import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/shift_building/shift.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_absen_controller/shift/form_shift_hrd_controller.dart';

class FormShiftHrdView extends GetView<FormShiftHrdController> {
  final Shifts? data;

  const FormShiftHrdView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormShiftHrdController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      title: const Text('Form Shift'),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LzForm.input(
                hint: 'Nama Shift',
                label: 'Nama Shift',
                model: controller.forms.key('shift_name'),
              ),
              Row(
                children: [
                  Expanded(
                      child: LzForm.input(
                    hint: 'Waktu Masuk',
                    label: 'time_in',
                    model: controller.forms.key('time_in'),
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: LzForm.input(
                      hint: 'Waktu Pulang',
                      label: 'time_out',
                      model: controller.forms.key('time_out'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              LzButton(
                text: data == null ? 'Submit' : 'Update',
                onTap: () {
                  controller.onSubmit(data?.shiftId);
                },
              ).margin(all: 20),
            ],
          );
        },
      ),
    );
  }
}
