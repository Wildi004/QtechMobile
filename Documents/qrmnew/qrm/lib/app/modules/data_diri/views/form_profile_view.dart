import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';

import '../controllers/form_profile_controller.dart';

class FormProfileView extends GetView<FormProfileController> {
  const FormProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormProfileController());
    final forms = controller.forms;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Data Diri",
            style: TextStyle(color: Colors.white, fontWeight: Fw.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 6, 91, 122),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LzListView(
            onRefresh: () => controller.getUserData(),

            autoCache: true, // set true, jika inputannya ada banyak
            children: [
              Column(
                children: [
                  Obx(() {
                    final user = controller.user.value;

                    return LzImage(
                      user?.image,
                      size: 100,
                    );
                  }),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: controller.pickImage,
                    child: Text("Edit Foto"),
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
              ),
              LzForm.input(
                label: 'Alamat',
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
                          hint: 'Tgl lahir',
                          model: forms.key('tgl_lahir'))),
                ],
              )..gap(10),
              Row(
                children: [
                  Expanded(
                      child: LzForm.input(
                          label: 'Agama',
                          hint: 'Agama',
                          model: forms.key('agama'))),
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
        bottomNavigationBar: LzButton(
          text: 'Simpan',
          onTap: () {
            Get.defaultDialog(
              title: 'Konfirmasi',
              titleStyle: TextStyle(fontWeight: Fw.bold),
              middleText: 'Apakah Anda yakin ingin menyimpan perubahan?',
              middleTextStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.018,
              ),
              textConfirm: 'Ya',
              buttonColor: Colors.blue,
              textCancel: 'Batal',
              confirmTextColor: Colors.white,
              onConfirm: () {
                Get.back(); // Tutup dialog
                controller.onSubmit(); // Jalankan fungsi simpan
              },
            );
          },
        ).margin(blr: 30));
  }
}
