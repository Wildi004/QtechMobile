import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/company_profile.dart';
import 'package:qrm_dev/app/modules/company_profile/controllers/struktur%20perusahaan%20controller/struktur_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/image_picker.dart';

class StrukturView extends GetView<StrukturController> {
  final CompanyProfile? data;

  const StrukturView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => StrukturController());
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Struktur Perusahaan',
        actions: [
          IconButton(onPressed: controller.onSubmit, icon: Icon(Hi.tick03))
        ],
      ).appBar,
      body: Obx(() {
        if (controller.isLoading.value) {
          return CustomLoading();
        }
        return LzListView(
          gap: 20,
          children: [
            Text(
              'Struktur Organisai Perusahaan',
              style: CustomTextStyle.title(),
            ),
            LzForm.input(
                hint: 'Pilih Struktur Organisai',
                label: 'Struktur Organisai',
                model: forms.key('struktur_organisasi'),
                suffixIcon: Hi.image01,
                onTap: () {
                  Pickers.image(then: (file) {
                    if (file != null) {
                      forms.set('struktur_organisasi', file.path);
                      controller.fileName.value = file.path;
                      controller.file = File(file.path);
                    }
                  });
                }),
            Obx(() {
              final bytes = controller.imageC.imageBytes.value;
              return bytes != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.memory(
                        bytes,
                        width: 150,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    )
                  : CustomLoading();
            }),
            Obx(() => controller.fileName.value.isEmpty
                ? const None()
                : Column(
                    children: [
                      LzImage(controller.file, size: 100),
                    ],
                  ).start)
          ],
        );
      }),
    );
  }
}
