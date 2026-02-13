import 'package:flutter/material.dart';
import 'package:qrm_dev/app/modules/login/views/forgot_password_view.dart';

class LupaPassword {
  static Widget lupaPasswordButton({
    required BuildContext context,
  }) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => FormInputEmail(context: context),
          );
        },
        child: Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
          child: Text(
            'Lupa Password',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 36, 71, 185)),
          ),
        ),
      ),
    );
  }
}
