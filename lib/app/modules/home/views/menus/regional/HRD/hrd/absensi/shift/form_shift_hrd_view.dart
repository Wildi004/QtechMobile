import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/shift_building/shift.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_absen_controller/shift/form_shift_hrd_controller.dart';

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
      title: const Text(
        'Form Shift',
        style: TextStyle(fontWeight: Fw.bold),
      ),
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
                    label: 'Waktu Masuk',
                    hint: 'Pilih waktu',
                    readOnly: true,
                    model: controller.forms.key('time_in'),
                    suffixIcon: Icons.access_time,
                    onTap: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (pickedTime != null) {
                        final now = DateTime.now();
                        final dt = DateTime(now.year, now.month, now.day,
                            pickedTime.hour, pickedTime.minute);
                        final formatted = DateFormat('HH:mm:ss').format(dt);

                        controller.forms.set('time_in', formatted);
                      }
                    },
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: LzForm.input(
                    label: 'Waktu Pulang',
                    hint: 'Pilih waktu',
                    readOnly: true,
                    model: controller.forms.key('time_out'),
                    suffixIcon: Icons.access_time,
                    onTap: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (pickedTime != null) {
                        final now = DateTime.now();
                        final dt = DateTime(now.year, now.month, now.day,
                            pickedTime.hour, pickedTime.minute);
                        final formatted = DateFormat('HH:mm:ss')
                            .format(dt); // Format 00:00:00

                        controller.forms.set('time_out', formatted);
                      }
                    },
                  )),
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
