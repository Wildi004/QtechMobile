import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/rbp_rb/rbp_rb.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/validasi%20rbp%20rb/create_validasi_rbp_rb_controller.dart';

class CreateValidasiRbpRbView extends GetView<CreateValidasiRbpRbController> {
  final RbpRb? data;
  const CreateValidasiRbpRbView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateValidasiRbpRbController());

    if (data != null) {
      controller.data = data;
    }

    return AlertDialog(
      backgroundColor: Color(0xFFF1F1F1),
      contentPadding: const EdgeInsets.all(20),
      title: const Text(
        'Validasi RBP RB',
        style: TextStyle(fontWeight: Fw.bold),
      ),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LzForm.select(
                label: 'Kesimpulan Validasi',
                style: OptionPickerStyle(withSearch: true),
                hint: 'Pilih Kesimpulan Validasi',
                model: controller.forms.key('status_validasi'),
                onTap: () async {
                  final data = await controller.getFinal().overlay();
                  controller.forms
                      .set('status_validasi')
                      .options(data.labelValue('name', 'id'));
                },
              ),
              SizedBox(height: 20),
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
