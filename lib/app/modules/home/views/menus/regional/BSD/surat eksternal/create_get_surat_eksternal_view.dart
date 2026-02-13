import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/Surat%20Eksternal/create_surat_eksternal_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/icon_action_widget.dart';

class CreateGetSuratEksternalView
    extends GetView<CreateSuratEksternalController> {
  const CreateGetSuratEksternalView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateSuratEksternalController());

    final forms = controller.forms;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Form Surat Eksternal',
        actions: [
          IconAction(Hi.tick04, onTap: () {
            controller.onSubmit();
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
                  LzForm.input(
                      label: 'No. Surat',
                      enabled: false,
                      maxLines: 2,
                      model: forms.key('data')),
                  LzForm.input(
                    label: 'Tgl. Surat',
                    hint: 'Format: YYYY-MM-DD',
                    model: forms.key('tgl'),
                    suffixIcon: Hi.calendar02,
                    onTap: () {
                      LzPicker.date(context,
                          minDate: DateTime(1900),
                          initDate: forms.get('tgl').toDate(),
                          onSelect: (date) {
                        forms.set('tgl', date.format());
                      });
                    },
                  ),
                  LzForm.input(
                      label: 'keperluan',
                      hint: 'Keperluan Surat Eksternal',
                      maxLines: 9,
                      model: forms.key('keperluan')),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
