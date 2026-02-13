import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/job_desk.dart';
import 'package:qrm_dev/app/modules/job_desk/controllers/create_job_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/image_picker.dart';

class CreateJobView extends GetView<CreateJobController> {
  const CreateJobView({super.key, this.data});
  final JobDesk? data;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateJobController());
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Job Desc',
        actions: [
          IconButton(
              onPressed: () {
                controller.onSubmit(data?.id);
              },
              icon: Icon(Hi.tick03))
        ],
      ).appBar,
      body: LzListView(
        gap: 25,
        children: [
          LzForm.select(
              label: 'Pilih Jabatan',
              hint: 'Silakan pilih Jabatan',
              style: OptionPickerStyle(withSearch: true),
              model: forms.key('role_id'),
              onTap: controller.onSelectRole),
          LzForm.input(
              hint: 'Upload file',
              label: 'Upload file',
              model: forms.key('image'),
              suffixIcon: Hi.file01,
              onTap: () {
                Pickers.image(then: (file) {
                  if (file != null) {
                    forms.set('image', file.path);
                    controller.fileName.value = file.path;
                    controller.file = File(file.path);
                  }
                });
              }),
          Obx(() => controller.fileName.value.isEmpty
              ? const None()
              : Column(
                  children: [
                    LzImage(controller.file, size: 100),
                  ],
                ).start)
        ],
      ),
    );
  }
}
