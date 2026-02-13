import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tetap.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/setting_karyawan_tetap_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class StatusUserView extends GetView<SettingKaryawanTetapController> {
  const StatusUserView({super.key, this.data});
  final KaryawanTetap? data;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SettingKaryawanTetapController>()) {
      Get.lazyPut(() => SettingKaryawanTetapController());
    }
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.getDetailUser(data!.id!);
    }

    return Scaffold(
      appBar: CustomAppbar(title: 'Status User').appBar,
      backgroundColor: Colors.white,
      body: LzListView(
        children: [
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    LzImage(
                      data!.image ?? 'null',
                      size: 100,
                    ),
                    const SizedBox(height: 15),
                    LzForm.select(
                      label: 'Pilih Status Aktif',
                      style: OptionPickerStyle(withSearch: true),
                      hint: 'Aktif / Tidak Aktif',
                      model: forms.key('is_active'),
                      onTap: () async {
                        final data =
                            await controller.getStatusAktif().overlay();

                        controller.forms
                            .set('is_active')
                            .options(data.labelValue('name', 'id'));
                      },
                    ),
                    LzButton(
                      text: data == null ? 'Submit' : 'Update',
                      onTap: () {
                        controller.onSubmit(data?.id);
                      },
                    ).margin(all: 20),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
