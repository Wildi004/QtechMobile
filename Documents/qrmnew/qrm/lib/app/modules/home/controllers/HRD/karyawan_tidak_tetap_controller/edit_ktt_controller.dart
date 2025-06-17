import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/karyawan_tidak.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class EditKttController extends GetxController with Apis {
  XFile? fileFoto;

  final forms = LzForm.make([
    'nik',
    'name',
    'no_telp',
    'foto',
    'role_id',
    'dep_id',
    'regional',
    'alamat_ktp',
    'alamat_domisili',
    'tgl_lahir',
    'tempat_lahir',
    'gender',
    'agama',
    'status_kawin_id',
    'status_proyek',
    'proyek_item_id',
    'tgl_bergabung',
    'is_active',
  ]);
  File? file;
  RxString fileName = ''.obs;
  List<KaryawanTidak> listkaryawan = [];

  Rxn<KaryawanTidak> rxKar = Rxn<KaryawanTidak>();
  RxList<KaryawanTidak> karyawan = <KaryawanTidak>[].obs;
  RxBool isLoading = true.obs;

  RxList<FormManager> statusKawinID = RxList<FormManager>();
  List<Map<String, dynamic>> statusKawin = [];

  RxList<FormManager> roleid = RxList<FormManager>();
  List<Map<String, dynamic>> roles = [];

  RxList<FormManager> depId = RxList<FormManager>();
  List<Map<String, dynamic>> dep = [];

  RxList<FormManager> proyekId = RxList<FormManager>();
  List<Map<String, dynamic>> proyek = [];

  @override
  void onInit() {
    super.onInit();
    roleid.add(LzForm.make(['role_id']));
    depId.add(LzForm.make(['dep_id']));
    statusKawinID.add(LzForm.make(['status_kawin_id']));
    proyekId.add(LzForm.make(['proyek_item_id']));
  }

  final agama = [
    {'name': 'Islam'},
    {'name': 'Hindu'},
    {'name': 'Khatolik'},
    {'name': 'Kristen'},
    {'name': 'Budha'},
  ];

  final gender = [
    {'name': 'Laki-laki'},
    {'name': 'Perempuan'},
  ];

  final aktif = [
    {'id': 1, 'name': 'Active'},
    {'id': 0, 'name': 'Non-Active'},
  ];

  Future<List<Map>> getAktif() async {
    await Future.delayed(const Duration(seconds: 1));
    return aktif;
  }

  Future<List<Map>> getAgama() async {
    await Future.delayed(const Duration(seconds: 1));
    return agama;
  }

  Future<List<Map>> getgender() async {
    await Future.delayed(const Duration(seconds: 1));
    return gender;
  }

  Future getRoles(int? id) async {
    final res = await api.role.getData();
    roles = List<Map<String, dynamic>>.from(res.data ?? []);

    if (roles.isNotEmpty) {
      // Pastikan key label dan value benar
      roleid[0].set('role_id', '').options(
            roles
                .where((e) =>
                    e['role'] != null && e['id'] != null) // filter valid data
                .map((e) => {
                      'label': e['role'].toString(), // key label harus 'label'
                      'value': e['id'].toString(), // key value harus 'value'
                    })
                .toList(),
          );
    } else {
      roleid[0].set('role_id', '').options([]);
    }

    final result = roles.firstWhere((e) => e['id'] == id, orElse: () => {});

    if (result['id'] != null) {
      forms.set('role_id', Option(result['role'], value: result['id']));
    }
  }

  Future getDept(int? id) async {
    final res = await api.departemen.getData();
    roles = List<Map<String, dynamic>>.from(res.data ?? []);

    if (roles.isNotEmpty) {
      depId[0].set('dep_id', '').options(
            roles
                .where((e) => e['departemen'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['departemen'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } else {
      depId[0].set('dep_id', '').options([]);
    }
    final result = roles.firstWhere((e) => e['id'] == id, orElse: () => {});
    if (result['id'] != null) {
      forms.set('dep_id', Option(result['departemen'], value: result['id']));
    }
  }

  Future getProyek(int? id) async {
    try {
      final res = await api.proyekItem.getData();
      proyek = List<Map<String, dynamic>>.from(res.data ?? []);

      final options = proyek
          .where((e) => e['kode_proyek'] != null && e['id'] != null)
          .map((e) => {
                'label': '${e['kode_proyek']} – ${e['uraian_pekerjaan']}',
                'value': e['id'].toString(),
              })
          .toList();

      proyekId[0].set('proyek_item_id', '').options(options);

      final selected =
          proyek.firstWhere((e) => e['id'] == id, orElse: () => {});
      if (selected['id'] != null) {
        forms.set(
          'proyek_item_id',
          Option(
            '${selected['kode_proyek']} – ${selected['uraian_pekerjaan']}',
            value: selected['id'],
          ),
        );
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future openStatusKawin() async {
    try {
      if (statusKawin.isEmpty) {
        final res = await api.statusKawin.getData().ui.loading();
        statusKawin = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      forms.set('status_kawin_id', '').options(
            statusKawin
                .where((e) => e['keterangan'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['keterangan'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future openDep() async {
    try {
      if (dep.isEmpty) {
        final res = await api.departemen.getData().ui.loading();
        dep = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      forms.set('dep_id', '').options(
            dep
                .where((e) => e['departemen'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['departemen'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future openRole() async {
    try {
      if (roles.isEmpty) {
        final res = await api.role.getData().ui.loading();
        roles = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      forms.set('role_id', '').options(
            roles
                .where((e) => e['role'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['role'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future openProyek() async {
    try {
      if (proyek.isEmpty) {
        final res = await api.proyekItem.getData().ui.loading();
        proyek = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      forms.set('proyek_item_id', '').options(
            proyek
                .where((e) => e['kode_proyek'] != null && e['id'] != null)
                .map((e) => {
                      'label': '${e['kode_proyek']} – ${e['uraian_pekerjaan']}',
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

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

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*']);

      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;
        payload['role_id'] = forms.extra('role_id');
        payload['status_kawin_id'] = forms.extra('status_kawin_id');
        payload['dep_id'] = forms.extra('dep_id');
        payload['proyek_item_id'] = forms.extra('proyek_item_id');

        payload['user_id'] = auth.id;

        if (fileFoto == null) {
          return Toast.show('File image harus diisi');
        }

        payload['foto'] = await api.toFile(fileFoto!.path);

        if (id == null) {
          final res = await api.karyawanTidak
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message.toString());
          }
        } else {
          final res = await api.karyawanTidak
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
