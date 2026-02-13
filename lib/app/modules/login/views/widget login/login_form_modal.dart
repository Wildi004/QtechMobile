import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import '../../controllers/login_controller.dart';

class LoginFormModal extends GetView<LoginController> {
  const LoginFormModal({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginController());
    final forms = controller.forms;
    forms.fill({'email': '', 'password': '123456'});

    return LayoutBuilder(
      builder: (context, constraints) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SizedBox(
              width: constraints.maxWidth,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.05,
                  horizontal: MediaQuery.of(context).size.width * 0.001,
                ),
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
                      Text(
                        'E-MAIL',
                        style: GoogleFonts.notoSerif()
                            .copyWith(fontSize: 30, color: Colors.white),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: LzForm.input(
                          hint: 'Enter your email',
                          model: forms.key('email'),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: LzForm.input(
                          hint: 'Enter your password',
                          model: forms.key('password'),
                          suffix: Obscure(),
                        ),
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
          ),
        );
      },
    );
  }
}
