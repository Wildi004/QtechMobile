import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/kategori_aset.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Setting%20Logistik/form_kategori_aset_controller.dart';

class FormKategoriAsetView extends GetView<FormKategoriAsetController> {
  final KategoriAset? data;

  const FormKategoriAsetView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormKategoriAsetController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      title: const Text('Form'),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LzForm.input(
                hint: 'Kategori',
                label: 'Kategori',
                model: controller.forms.key('nama_kategori'),
              ),
              const SizedBox(height: 20),
              LzButton(
                text: data == null ? 'Submit' : 'Update',
                onTap: () {
                  controller.onSubmit(data?.id);
                },
              ).margin(all: 20),
            ],
          );
        },
      ),
    );
  }
}
