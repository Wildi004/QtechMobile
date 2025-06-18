import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/job_desk.dart';
import 'package:qrm/app/modules/job_desk/controllers/update_job_controller.dart';
import 'package:qrm/app/widgets/image_picker.dart';

class UpdateJobView extends GetView<UpdateJobController> {
  const UpdateJobView({super.key, this.data});
  final JobDesk? data;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => UpdateJobController());
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Job Desc",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 91, 122),
      ),
      body: LzListView(
        children: [
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
      bottomNavigationBar: LzButton(
        text: data == null ? 'Submit' : 'Update',
        onTap: () {
          controller.onSubmit(data?.id);
        },
      ).margin(all: 20),
    );
  }
}
