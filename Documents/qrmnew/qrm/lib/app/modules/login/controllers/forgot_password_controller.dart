import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';

class ForgotPasswordController extends GetxController with Apis {
  final forms =
      LzForm.make(['email', 'token', 'password', 'password_confirmation']);

  Future<bool?> onSubmit() async {
    try {
      final form = forms.validate(required: [
        '*'
      ], message: {
        'email': 'Alamat email harus diisi',
        'token': 'Token harus diisi',
        'password': 'Password harus diisi',
        'password_confirmation': 'Konfirmasi password harus diisi',
        'password_confirmation:match': 'Konfirmasi password tidak sama'
      }, match: [
        'password:password_confirmation'
      ]);

      if (form.ok) {
        final res = await api.auth.resetPassword(form.value).ui.loading();

        if (res.status) {
          Toast.success(res.message);
        }

        return res.status;
      }

      return false;
    } catch (e, s) {
      Errors.check(e, s);
      return false;
    }
  }
}
