// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/services/storage/auth.dart';
import 'package:qrm/app/modules/password/controllers/password_controller.dart';

class PasswordView extends GetView<PasswordController> {
  const PasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PasswordController());
    final forms = controller.forms;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Password',
              style: TextStyle(color: Colors.white, fontWeight: Fw.bold)),
          backgroundColor: Colors.blue[800],
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Colors.blue[800],
              ),
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.04,
              ),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureBuilder(
                    future: Auth.user(),
                    builder: (context, snap) {
                      final user = snap.data;
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          user?.name ?? '',
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.025,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                  FutureBuilder(
                    future: Auth.user(),
                    builder: (context, snap) {
                      final user = snap.data;
                      return Text(
                        user?.role ?? '',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.014,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LzListView(
                  autoCache: true,
                  children: [
                    Column(
                      mainAxisAlignment: Maa.start,
                      crossAxisAlignment: Caa.start,
                      children: [
                        Text(
                          'Silahkan masukan password Q-Tech lama anda',
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.017,
                          ),
                        ),
                        LzForm.input(
                          hint: 'Inputkan password lama',
                          model: forms.key('current_password'),
                          suffix: Obscure(),
                        ),
                        30.height,
                        Center(
                          child: Container(
                            height: 3,
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    30.height,
                    LzForm.input(
                      label: 'Masukan Password baru Q-Tech anda',
                      hint: 'Inputkan password baru',
                      model: forms.key('new_password'),
                    ),
                    LzForm.input(
                      label: 'Konfirmasi password baru Q-Tech anda',
                      hint: 'Inputkan konfirmasi password',
                      model: forms.key('new_password_confirmation'),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
