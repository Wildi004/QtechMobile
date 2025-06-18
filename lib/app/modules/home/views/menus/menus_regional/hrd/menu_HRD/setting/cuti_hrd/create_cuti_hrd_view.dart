import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_setting_controller/setting_cuti/create_set_cuti_controller.dart';

class CreateCutiHrdView extends GetView<CreateSetCutiController> {
  const CreateCutiHrdView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateSetCutiController());

    return AlertDialog(
      title: const Text('Form Cuti'),
      content: Obx(() {
        final members = controller.members;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LzForm.input(
              label: 'Jumlah Cuti',
              hint: 'Masukkan jumlah cuti',
              model: controller.forms.key('jml_cuti'),
            ),
            const SizedBox(height: 15),
            ...members.generate((data, i) => LzForm.select(
                  label: 'Pilih Peserta',
                  hint: 'Klik untuk memilih peserta',
                  model: data.key('user_id'),
                  onTap: () => controller.openUser(i),
                )),
          ],
        );
      }),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () => controller.onSubmit(),
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
