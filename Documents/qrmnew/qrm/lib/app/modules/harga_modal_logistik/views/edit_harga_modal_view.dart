import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/modal_logistik.dart';
import 'package:qrm/app/modules/harga_modal_logistik/controllers/edit_harga_modal_controller.dart';

class EditHargaModalView extends GetView<EditHargaModalController> {
  final ModalLogistik? data;
  const EditHargaModalView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EditHargaModalController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Harga Modal",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 91, 122),
      ),
      body: LzListView(
        gap: 25,
        children: [
          LzForm.input(
            hint: 'Inputkan Kode Material',
            label: 'Kode Material',
            model: forms.key('kode_material'),
          ),
        ],
      ),
      bottomNavigationBar: LzButton(
        text: data == null ? 'Submit' : 'Update',
        onTap: () {
          controller.onSubmit(data?.id);
          // logg(controller.onSubmit());
        },
      ).margin(all: 20),
    );
  }
}
