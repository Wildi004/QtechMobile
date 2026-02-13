import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/user.dart';
import 'package:qrm_dev/app/data/services/image_file_token.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

import '../controllers/form_profile_controller.dart';

class FormProfileView extends GetView<FormProfileController> {
  final User? data;

  const FormProfileView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormProfileController());
    final forms = controller.forms;
    final ImageFileToken imageController = Get.put(ImageFileToken());
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Data Diri',
        actions: [
          IconButton(
              onPressed: () {
                controller.onSubmit();
              },
              icon: Icon(Hi.tick03))
        ],
      ).appBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LzListView(
          onRefresh: () => controller.getUserData(),
          autoCache: true,
          children: [
            Column(
              children: [
                Obx(() {
                  final bytes = imageController.imageBytes.value;

                  return bytes != null
                      ? Image.memory(
                          bytes,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[300],
                          child: const Icon(Icons.person),
                        );
                }),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: controller.pickImage,
                  child: Text("Edit Foto",
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
                ),
              ],
            ),
            LzForm.input(
                label: 'ID Karyawan',
                hint: 'Inputkan id karyawan',
                model: forms.key('id'),
                enabled: false),
            LzForm.input(
                label: 'email',
                hint: 'Inputkan Email',
                model: forms.key('email'),
                enabled: false),
            LzForm.input(
                label: 'NIK',
                hint: 'Inputkan email',
                model: forms.key('no_ktp'),
                enabled: false),
            LzForm.input(
              label: 'Nama Lengkap',
              hint: 'Inputkan Nama_lengkap',
              model: forms.key('name'),
            ),
            LzForm.input(
                label: 'Nomor Telepon',
                hint: 'Inputkan Nomor Telepon',
                model: forms.key('no_telp'),
                maxLength: 13,
                keyboard: Tit.number),
            LzForm.input(
              label: 'Alamat',
              maxLength: 255,
              hint: 'Inputkan Alamat',
              model: forms.key('alamat_ktp'),
            ),
            Row(
              children: [
                Expanded(
                    child: LzForm.input(
                        label: 'Tempat Lahir',
                        hint: 'Tempat lahir',
                        model: forms.key('tempat_lahir'))),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: LzForm.input(
                    label: 'Tanggal Lahir',
                    hint: 'Tanggal lahir',
                    model: forms.key('tgl_lahir'),
                    suffixIcon: Hi.calendar02,
                    onTap: () {
                      LzPicker.date(context,
                          minDate: DateTime(1900),
                          initDate: forms.get('tgl_lahir').toDate(),
                          onSelect: (date) {
                        forms.set('tgl_lahir', date.format());
                      });
                    },
                  ),
                ),
              ],
            )..gap(10),
            Row(
              children: [
                Expanded(
                  child: LzForm.select(
                    label: 'Agama',
                    style: OptionPickerStyle(withSearch: true),
                    hint: 'Pilih agama',
                    model: controller.forms.key('agama'),
                    onTap: () async {
                      final data = await controller.getAgama().overlay();
                      controller.forms
                          .set('agama')
                          .options(data.labelValue('name'));
                    },
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: LzForm.radio(
                        label: 'Gender',
                        options: ['Laki-Laki', 'Perempuan'],
                        model: forms.key('gender'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
