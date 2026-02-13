import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tidak.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/karyawan_tidak_tetap_controller/karyawan_tidak_tetap_controller.dart';

class SettingKttController extends GetxController with Apis {
  RxBool isLoading = false.obs;
  final forms = LzForm.make([
    "name",
    "is_active",
  ]);

  final aktif = [
    {'id': 1, 'name': 'Active'},
    {'id': 0, 'name': 'Non-Active'},
  ];
  Future<List<Map>> getAktif() async {
    await Future.delayed(const Duration(seconds: 1));
    return aktif;
  }

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*']);

      logg('Form validasi: ${form.ok}');
      logg('Form value: ${form.value}');

      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        final isActive = forms.extra('is_active');
        if (isActive == null) {
          Toast.show('Pilih status karyawan terlebih dahulu');
          logg('Gagal submit: status karyawan belum dipilih');
          return;
        }

        payload['is_active'] = isActive['id'];
        payload['user_id'] = auth.id;

        logg('Payload sebelum kirim: $payload');
        logg('ID karyawan: $id');

        if (id != null) {
          final res = await api.karyawanTidak
              .updateStatusTidak(payload, id)
              .ui
              .loading('Mengupdate...');

          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        } else {
          Toast.show('ID tidak valid');
          logg('Gagal submit: ID tidak valid');
        }
      } else {
        logg('Form tidak valid, validasi gagal');
      }
    } catch (e, s) {
      logg('Terjadi error: $e');
      Errors.check(e, s);
    }
  }

  void updateData(KaryawanTidak data, int id) {
    try {
      final employee = Get.find<KaryawanTidakTetapController>();

      int index = employee.listkaryawan.indexWhere((e) => e.id == id);
      logg('updateing... $index');
      if (index >= 0) {
        employee.listkaryawan[index] = data;
        employee.isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
