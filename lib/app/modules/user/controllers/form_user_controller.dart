import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';

class FormUserController extends GetxController with Apis {
  final forms = LzForm.make(['name', 'no_induk']);

  Future onSubmit() async {
    try {
      final form = forms.validate(
          required: ['*'], message: {'name': 'Nama tidak boleh kosong'});

      if (form.ok) {
        Toast.overlay('Menambahkan...');
        final res = await api.user.createUser(form.value);
        logg('Berhasil $res');
        Toast.dismiss();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
