// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:lazyui/lazyui.dart';

import '../controllers/login_controller.dart';
import 'forgot_password_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1,
        ),
        child: Center(
          child: LzListView(
            physics: AlwaysScrollableScrollPhysics(),
            scrollLimit: const [50, 50],
            padding: Ei.sym(),
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
                          fontWeight: Fw.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    // Tambahkan background pada gambar
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(8),
                      child: LzImage(
                        "pngnew.png",
                        size: MediaQuery.of(context).size.width * 1,
                      ),
                    ),
                    Text('LOGIN',
                        style: GoogleFonts.notoSerif().copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.08,
                          fontWeight: Fw.bold,
                        )),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LzButton(
                          icon: Icons.qr_code,
                          onTap: () {
                            Get.snackbar('Maaf', 'Fitur ini belum tersedia');
                          },
                        ),
                        SizedBox(width: 15),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
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
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Touch(
                        onTap: () {
                          context.bottomSheet(FormInputEmail(context: context),
                              backBlur: true,
                              backgroundColor: Colors.transparent,
                              draggable: true);
                        },
                        padding: Ei.only(r: context.width * 0.05),
                        child: Text(
                          'Lupa Password',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// form input email
class FormInputEmail extends GetView<LoginController> {
  final BuildContext context;
  const FormInputEmail({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginController());

    void requestOtp() async {
      final ok = await controller.requestOtp();

      if (ok) {
        context.lz.pop();

        this.context.bottomSheet(ForgotPasswordView(email: controller.email.text));

        // LzPad.otp(this.context,
        //     title: 'Kode OTP',
        //     length: 5,
        //     message:
        //         'Silakan masukkan kode OTP yang telah dikirimkan ke alamat email Anda.',
        //     expired: 3.m,
        //     onCompleted: (otp) {
        //       otp.pause(); // jeda dulu waktu mundurnya, sampai proses validasi selesai

        //       // lakukan validasi otp

        //     });
      }
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white),
          padding: Ei.only(
              b: context.viewInsets
                  .bottom), // untuk menyesuaikan ketika keyboard muncul
          child: LzTextField(
            hint: 'Ketik alamat email',
            controller: controller.email,
            autofocus: true,
            onSubmit: (_) => requestOtp(),
            border: Ltf.none,
            suffixIcon: SuffixBuilder(
                controller: controller.email,
                builder: (value) {
                  if (value.isEmpty) {
                    return const None();
                  }

                  return Touch(
                    onTap: () => requestOtp(),
                    padding: Ei.sym(v: 14, h: 16),
                    child: Text('Kirim', style: Gfont.bold),
                  );
                }),
          ),
        ),
      ],
    ).min;
  }
}

class LoginFormModal extends GetView<LoginController> {
  const LoginFormModal({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginController());
    final forms = controller.forms;
    forms.fill({'email': 'Wildi@qrm15.com', 'password': '123456'});

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            width: constraints.maxWidth,
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02,
                  horizontal: MediaQuery.of(context).size.width * 0.001),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: ['4CA1AF'.hex, '585858'.hex],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('E-MAIL',
                        style: GoogleFonts.notoSerif()
                            .copyWith(fontSize: 30, color: Colors.white)),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: LzForm.input(
                          hint: 'Enter your email', model: forms.key('email')),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: LzForm.input(
                          hint: 'Enter your password',
                          model: forms.key('password'),
                          suffix: Obscure()),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: ['302C7B'.hex, '4A90E2'.hex],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: LzButton(
                        text: 'SUBMIT',
                        onTap: () {
                          controller.onSubmit();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
