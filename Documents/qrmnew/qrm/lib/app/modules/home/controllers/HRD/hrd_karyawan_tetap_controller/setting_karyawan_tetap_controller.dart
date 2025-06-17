import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/apis/api.dart';

class SettingKaryawanTetapController extends GetxController with Apis {
  RxBool isLoading = false.obs;
  final forms = LzForm.make([
    "id",
    "name",
    "no_induk",
    "golongan",
    "prosentase",
    "no_ktp",
    "email",
    "no_telp",
    "image",
    "password",
    "role_id",
    "dept_id",
    "regional",
    "regional_ktp",
    "alamat_ktp",
    "alamat_domisili",
    "tempat_lahir",
    "tgl_lahir",
    "gender",
    "agama",
    "status_kawin_id",
    "tgl_bergabung",
    "is_active",
    "is_online",
    "shift_id",
    "building_id",
    "ttd",
    "status_karyawan",
    "date_created",
    "id_telegram",
    "role",
    "dept",
    "shift",
    "building",
    'image',
    'ttd'
  ]);

  final status = [
    {'name': 'Aktif'},
    {'name': 'Tidak Aktif'},
  ];
  Rxn<KaryawanTetapApi> arsip = Rxn<KaryawanTetapApi>();
  Future<List<Map>> getStatus() async {
    await Future.delayed(const Duration(seconds: 1));
    return status;
  }
}
