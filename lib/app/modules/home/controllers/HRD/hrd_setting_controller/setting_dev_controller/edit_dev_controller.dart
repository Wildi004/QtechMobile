import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/departemen.dart';

class EditDevController extends GetxController with Apis {
  final forms = LzForm.make(['departemen']);
  RxString fileName = ''.obs;
  Rxn<Departemen> departemen = Rxn<Departemen>();

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['departemen']);
      if (form.ok) {
        final payload = form.value;
        if (id == null) {
          final res = await api.departemen
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Toast.success(
                'Berhasil menambahkan, silahkan refresh jika tidak ada perubahan');
          }
        } else {
          final res = await api.departemen
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
            Toast.success(
                'Berhasil Update, silahkan refresh jika tidak ada perubahan');
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
