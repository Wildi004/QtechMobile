import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/rbp_rb/rbp_rb.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/validasi%20rbp%20rj/create_validasi_rbp_rj_controller.dart';

class CreateValidasiRbpRjView extends GetView<CreateValidasiRbpRjController> {
  final RbpRb? data;
  const CreateValidasiRbpRjView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateValidasiRbpRjController());

    if (data != null) {
      controller.data = data;
    }

    return AlertDialog(
      backgroundColor: Color(0xFFF1F1F1),
      contentPadding: const EdgeInsets.all(20),
      title: const Text(
        'Validasi RBP RJ',
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
