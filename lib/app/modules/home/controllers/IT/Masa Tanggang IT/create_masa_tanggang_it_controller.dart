import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';

class CreateMasaTanggangItController extends GetxController with Apis {
  final forms = LzForm.make([
    'nama_hosting',
    'penyedia',
    'tgl_expired',
  ]);

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*']);
      if (form.ok) {
        final payload = form.value;

        if (id == null) {
          final res = await api.masaTanggang
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        } else {
          final res = await api.masaTanggang
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
