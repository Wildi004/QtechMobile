import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tetap.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';
import 'package:get/get.dart' hide Bindings;
import 'karyawan_tetap_controller.dart';

class SettingKaryawanTetapController extends GetxController with Apis {
  RxBool isLoading = false.obs;
  final forms = LzForm.make([
    "name",
    "no_induk",
    "golongan",
    "prosentase",
    "no_ktp",
    "email",
    "no_telp",
    "image",
    "role_id",
    "dept_id",
    "regional",
    "regional_ktp",
    'alamat_ktp',
    'alamat_domisili',
    'tempat_lahir',
    'tgl_lahir',
    'gender',
    'agama',
    'status_kawin_id',
    'tgl_bergabung',
    'is_active',
    'shift_id',
    'building_id',
    'ttd',
    'status_karyawan',
    'id_telegram',
  ]);
  KaryawanTetap? details;

  Future getDetailUser(int id) async {
    try {
      Bindings.onRendered(() async {
        Toast.overlay('Loading...', onCancel: () {});

        if (details == null) {
          final res = await api.karyawanTetap.getDataDetail(id);
          details = KaryawanTetap.fromJson(res.data ?? {});
        }

        forms.fill(details!.toJson());
        await getAktif(details?.isActive);

        Toast.dismiss();
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  final aktif = [
    {'id': 1, 'name': 'Active'},
    {'id': 0, 'name': 'Non-Active'},
  ];

  Future getAktif(int? id) async {
    final option = aktif.firstWhere(
      (e) => e['id'] == id,
      orElse: () => {},
    );

    if (option.isNotEmpty) {
      forms.set('is_active', option['name']);

      forms.set(
        'is_active',
        Option(option['name'] as String, value: option['id'] as int),
      );

      return option;
    } else {
      return null;
    }
  }

  Future<List<Map>> getStatusAktif() async {
    return aktif;
  }

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*']);

      logg('Form validasi: ${form.ok}');
      logg('Form value: ${form.value}');

      if (!form.ok) {
        logg('Form tidak valid, validasi gagal');
        return;
      }

      final auth = await Auth.user();
      final payload = form.value;

      final isActiveRaw = forms.extra('is_active');
      logg('is_active raw: $isActiveRaw (${isActiveRaw.runtimeType})');

      int? isActiveId;
      if (isActiveRaw == null) {
        Toast.show('Pilih status karyawan terlebih dahulu');
        logg('Gagal submit: status karyawan belum dipilih');
        return;
      } else if (isActiveRaw is int) {
        isActiveId = isActiveRaw;
      } else if (isActiveRaw is String) {
        isActiveId = int.tryParse(isActiveRaw);
      } else if (isActiveRaw is Map) {
        isActiveId = isActiveRaw['id'] as int?;
      } else if (isActiveRaw is Option) {
        // asumsi Option(name, value: int)
        isActiveId = isActiveRaw.value as int?;
      }

      if (isActiveId == null) {
        Toast.show('Status karyawan tidak valid');
        logg('Gagal submit: is_active tidak bisa diparsing');
        return;
      }

      payload['is_active'] = isActiveId;
      payload['user_id'] = auth.id;

      logg('Payload sebelum kirim: $payload');
      logg('ID karyawan: $id');

      if (id != null) {
        final res = await api.karyawanTetap
            .updateStatus(payload, id)
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
    } catch (e, s) {
      logg('Terjadi error: $e');
      Errors.check(e, s);
    }
  }

  void updateData(KaryawanTetap data, int id) {
    try {
      final employee = Get.find<KaryawanTetapController>();
      int index = employee.listkaryawan.indexWhere((e) => e.id == id);

      if (index >= 0) {
        employee.listkaryawan[index] = data;
        employee.isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
