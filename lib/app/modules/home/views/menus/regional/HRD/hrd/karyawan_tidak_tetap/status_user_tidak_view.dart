import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tidak.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/karyawan_tidak_tetap_controller/edit_status_ktt_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class StatusUserTidakView extends GetView<EditStatusKttController> {
  const StatusUserTidakView({super.key, this.data});
  final KaryawanTidak? data;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<EditStatusKttController>()) {
      Get.lazyPut(() => EditStatusKttController());
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
                      data!.foto ?? 'null',
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
