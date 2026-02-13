import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/cuti.dart';

class UpdateCutiController extends GetxController with Apis {
  final forms = LzForm.make(['jml_cuti']);
  RxString fileName = ''.obs;
  Rxn<Cuti> cuti = Rxn<Cuti>();

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['jml_cuti']);
      if (form.ok) {
        final payload = form.value;
        if (id == null) {
          final res =
              await api.cuti.createData(payload).ui.loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message.toString());
          }
        } else {
          final res = await api.cuti
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message.toString());
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
