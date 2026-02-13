import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Surat%20Jalan%20Logistik/surat%20jalan%20internal/create_surat_jalan_internal_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/icon_action_widget.dart';

class CreateSuratJalanInternalView
    extends GetView<CreateSuratJalanInternalController> {
  const CreateSuratJalanInternalView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateSuratJalanInternalController());

    final forms = controller.forms;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Form Surat Jalan Internal',
        actions: [
          IconAction(Hi.tick04, onTap: () {
            // controller.onSubmit();
          }),
        ],
      ).appBar,
      body: Obx(() {
        bool loading = controller.isLoading.value;

        if (loading) {
          return CustomLoading();
        }

        return Column(
          children: [
            Container(
              padding: Ei.all(20),
              decoration: BoxDecoration(border: Br.only(['b'])),
              child: Column(
                spacing: 25,
                children: [
                  LzForm.select(
                    hint: 'No Pengajuan',
                    label: 'No Pengajuan',
                    onTap: () => controller.openMaterial(),
                    style: OptionPickerStyle(withSearch: true),
                    model: forms.key('no_pengajuan'),
                  ),
                ],
              ),
            ),
            // dynamic list
          ],
        );
      }),
    );
  }
}
