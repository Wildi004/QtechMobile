// ignore_for_file: use_build_context_synchronously

import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/login/controllers/finger_print_controller.dart';
import 'package:qrm_dev/app/modules/login/views/widget%20login/login_face.dart';
import 'package:qrm_dev/app/modules/login/views/widget%20login/login_form_modal.dart';
import 'package:qrm_dev/app/modules/login/views/widget%20login/lupa_password.dart';
import 'package:qrm_dev/app/routes/app_pages.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
          ),
          child: Center(
            child: LzListView(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollLimit: const [50, 50],
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: Maa.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "PT. QINAR RAYA MANDIRI",
                        style: GoogleFonts.rowdies().copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.black,
                          fontWeight: Fw.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: LzImage(
                          "pngnew.png",
                          size: MediaQuery.of(context).size.width * 1,
                        ),
                      ),
                      Text(
                        'LOGIN',
                        style: GoogleFonts.notoSerif().copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.08,
                          fontWeight: Fw.bold,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Tombol Fingerprint
                          LzButton(
                            icon: Icons.fingerprint,
                            onTap: () async {
                              final fpController =
                                  Get.put(FingerprintController());
                              logg('Menekan tombol fingerprint');
                              bool success = await fpController.authenticate();
                              if (success) {
                                final token =
                                    await storage.read('fingerprint_token');
                                final user =
                                    await storage.read('fingerprint_user');
                                if (token != null && user != null) {
                                  await storage.write('token', token);
                                  await storage.write('user', user);
                                  Fetchly.setToken(token);
                                  Get.snackbar('Fingerprint',
                                      'Login fingerprint berhasil');
                                  Get.offAllNamed(Routes.APP);
                                } else {
                                  Get.snackbar('Fingerprint',
                                      'Tidak ada data login fingerprint');
                                }
                              } else {
                                Get.snackbar(
                                    'Fingerprint', 'Autentikasi dibatalkan');
                              }
                            },
                          ),
                          const SizedBox(width: 15),
                          LzButton(
                            icon: Icons.face,
                            onTap: () async {
                              final faceController =
                                  Get.put(BiometricController());
                              logg('Menekan tombol Face ID');
                              bool success =
                                  await faceController.authenticate();
                              if (success) {
                                final token = await storage.read('face_token');
                                final user = await storage.read('face_user');
                                if (token != null && user != null) {
                                  await storage.write('token', token);
                                  await storage.write('user', user);
                                  Fetchly.setToken(token);
                                  Get.snackbar(
                                      'Face ID', 'Login Face ID berhasil');
                                  Get.offAllNamed(Routes.APP);
                                } else {
                                  Get.snackbar('Face ID',
                                      'Tidak ada data login Face ID');
                                }
                              } else {
                                Get.snackbar(
                                    'Face ID', 'Autentikasi dibatalkan');
                              }
                            },
                          ),
                          const SizedBox(width: 15),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: ['302C7B'.hex, '4A90E2'.hex],
                                begin: Alignment.topLeft,
                                end: Alignment.topRight,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: LzButton(
                              text: 'PASSWORD',
                              onTap: () {
                                context.bottomSheet(
                                  const LoginFormModal(),
                                  backgroundColor: Colors.transparent,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      LupaPassword.lupaPasswordButton(context: context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
