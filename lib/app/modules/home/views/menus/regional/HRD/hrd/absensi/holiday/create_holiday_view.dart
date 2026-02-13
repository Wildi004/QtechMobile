import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/holiday.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_absen_controller/holiday/create_holiday_controller.dart';

class CreateHolidayView extends GetView<CreateHolidayController> {
  final Holiday? data;

  const CreateHolidayView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateHolidayController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      title: const Text(
        'Form Holiday',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LzForm.input(
              hint: 'Nama Libur Nasional',
              label: 'Nama Libur Nasional',
              model: forms.key('description')),
          LzForm.input(
              label: 'Tanggal Libur',
              model: forms.key('holiday_date'),
              suffixIcon: Hi.calendar02,
              onTap: () {
                LzPicker.date(context,
                    initDate: forms.get('holiday_date').toDate(),
                    onSelect: (date) {
                  forms.set('holiday_date', date.format());
                });
              }),
          LzButton(
            text: data == null ? 'Submit' : 'Update',
            onTap: () {
              controller.onSubmit(data?.holidayId);
            },
          ).margin(all: 20),
        ],
      ),
    );
  }
}
