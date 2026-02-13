import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/shift_building/shift.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_absen_controller/shift/shift_hrd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class DetailShiftHrdView extends GetView<ShiftHrdController> {
  final Shifts? data;
  const DetailShiftHrdView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.isLoading.value = true;

      await Future.delayed(const Duration(seconds: 1));

      if (data != null) {
        forms.fill(data!.toJson());
      }

      controller.isLoading.value = false;
    });

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Shift Detail',
      ).appBar,
      body: Obx(() {
        bool isLoading = controller.isLoading.value;

        if (isLoading) {
          return Center(child: CustomLoading());
        }
        return Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Expanded(
                child: LzListView(
                  gap: 20,
                  children: [
                    LzForm.input(
                      enabled: false,
                      label: 'Nama shift',
                      model: controller.forms.key('shift_name'),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: LzForm.input(
                            enabled: false,
                            label: 'Waktu Masuk',
                            model: controller.forms.key('time_in'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: LzForm.input(
                            enabled: false,
                            label: 'Waktu Pulang',
                            model: controller.forms.key('time_out'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
