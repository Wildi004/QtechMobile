import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class AddKasbonController extends GetxController with Apis {
  final forms = LzForm.make(
      ['no_pengajuan', 'tgl_kasbon', 'jml', 'keterangan', 'user_id']);

  RxBool isLoading = false.obs;

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['no_pengajuan']);
      if (!form.ok) return;

      final payload = form.value;

      // Tambahkan user_id dari Auth
      final auth = await Auth.user();
      payload['user_id'] = auth.id;
      payload['jml'] = (forms.get('jml') ?? '0').numeric;

      if (id == null) {
        final res =
            await api.kasbon.createData(payload).ui.loading('Menambahkan...');
        if (res.status) {
          Get.back(result: res.data);
          Get.snackbar(
              'Berhasil', res.message ?? 'Data kasbon berhasil ditambahkan.');
        }
      } else {
        final res = await api.kasbon
            .updateData(payload, id)
            .ui
            .loading('Memperbarui...');
        if (res.status) {
          Get.back(result: res.data);
          Get.snackbar(
              'Berhasil', res.message ?? 'Data kasbon berhasil diperbarui.');
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
