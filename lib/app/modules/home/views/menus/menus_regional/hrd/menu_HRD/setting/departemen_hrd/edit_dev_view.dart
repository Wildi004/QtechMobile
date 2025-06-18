import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/departemen.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_setting_controller/setting_dev_controller/edit_dev_controller.dart';

class EditDevView extends GetView<EditDevController> {
  const EditDevView({super.key, this.data});
  final Departemen? data;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EditDevController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Edit Dev",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 91, 122),
      ),
      body: LzListView(children: [
        LzForm.input(
            label: 'Edit Departemen',
            hint: 'Masukan Nama.',
            model: forms.key('departemen')),
      ]),
      bottomNavigationBar: LzButton(
        text: data == null ? 'Submit' : 'Update',
        onTap: () {
          controller.onSubmit(data?.id);
        },
      ).margin(all: 20),
    );
  }
}
