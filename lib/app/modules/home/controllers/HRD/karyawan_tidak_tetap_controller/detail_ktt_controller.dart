import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tidak.dart';

class DetailKttController extends GetxController with Apis {
  XFile? fileFoto;
  final forms = LzForm.make([
    'id',
    'nik',
    'name',
    'no_telp',
    'foto',
    'regional',
    'alamat_ktp',
    'alamat_domisili',
    'tgl_lahir',
    'tempat_lahir',
    'gender',
    'agama',
    'status_proyek',
    'tgl_bergabung',
    'is_active',
    'date_created',
    'role',
    'status_kawin',
    'proyek_item',
    'dep',
  ]);
  List<KaryawanTidak> listkaryawan = [];

  Rxn<KaryawanTidak> rxKar = Rxn<KaryawanTidak>();
  RxList<KaryawanTidak> karyawan = <KaryawanTidak>[].obs;
  RxBool isLoading = true.obs;

  void updateData(KaryawanTidak data, int id) {
    try {
      int index = listkaryawan.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listkaryawan[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
