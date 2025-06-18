import 'dart:io';

import 'package:get/get.dart' hide Bindings;
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/karyawan_tetap.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class EditKaryawanController extends GetxController with Apis {
  RxInt tab = 0.obs;

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

  //select custom

  final gender = [
    {'name': 'Laki-laki'},
    {'name': 'Perempuan'},
  ];
  final agama = [
    {'name': 'Islam'},
    {'name': 'Hindu'},
    {'name': 'Khatolik'},
    {'name': 'Kristen'},
    {'name': 'Budha'},
  ];
  final aktif = [
    {'id': 1, 'name': 'Active'},
    {'id': 0, 'name': 'Non-Active'},
  ];
  final statuskaryawan = [
    {'name': 'Kontrak'},
    {'name': 'Tetap'},
  ];
  Future<List<Map>> getgender() async {
    await Future.delayed(const Duration(seconds: 1));
    return gender;
  }

  Future<List<Map>> getAgama() async {
    await Future.delayed(const Duration(seconds: 1));
    return agama;
  }

  Future<List<Map>> getAktif() async {
    await Future.delayed(const Duration(seconds: 1));
    return aktif;
  }

  Future<List<Map>> getStatuskaryawan() async {
    await Future.delayed(const Duration(seconds: 1));
    return statuskaryawan;
  }

  File? file;
  XFile? fileImage;
  XFile? fileTtd;

  RxString fileName = ''.obs;
  List<KaryawanTetap> listkaryawan = [];
  final jabatanLabel = 'Jabatan'.obs;

  RxBool isLoading = true.obs;

  RxList<FormManager> roleid = RxList<FormManager>();
  List<Map<String, dynamic>> roles = [];

  RxList<FormManager> depId = RxList<FormManager>();
  List<Map<String, dynamic>> dep = [];

  RxList<FormManager> shiftID = RxList<FormManager>();
  List<Map<String, dynamic>> shift = [];

  RxList<FormManager> buildingID = RxList<FormManager>();
  List<Map<String, dynamic>> building = [];

  RxList<FormManager> statusKawinID = RxList<FormManager>();
  List<Map<String, dynamic>> statusKawin = [];

  KaryawanTetap? details;

  @override
  void onInit() {
    super.onInit();

    roleid.add(LzForm.make(['role_id']));
    depId.add(LzForm.make(['dept_id']));
    shiftID.add(LzForm.make(['shift_id']));
    buildingID.add(LzForm.make(['building_id']));
    statusKawinID.add(LzForm.make(['status_kawin_id']));
  }

  Future getDetailUser(int id) async {
    try {
      Bindings.onRendered(() async {
        Toast.overlay('Loading...', onCancel: () {});

        if (details == null) {
          final res = await api.karyawanTetap.getDataDetail(id);
          details = KaryawanTetap.fromJson(res.data ?? {});
        }

        await getRoles(details?.roleId);

        Toast.dismiss();
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
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
      // Jika kosong, set options kosong agar tidak error
      roleid[0].set('role_id', '').options([]);
    }

    // get data roles
    final result = roles.firstWhere((e) => e['id'] == id, orElse: () => {});

    if (result['id'] != null) {
      forms.set('role_id', Option(result['role'], value: result['id']));
    }
  }

  Future getDept(int? id) async {
    final res = await api.departemen.getData();
    roles = List<Map<String, dynamic>>.from(res.data ?? []);

    if (roles.isNotEmpty) {
      // Pastikan key label dan value benar
      depId[0].set('dept_id', '').options(
            roles
                .where((e) =>
                    e['departemen'] != null &&
                    e['id'] != null) // filter valid data
                .map((e) => {
                      'label':
                          e['departemen'].toString(), // key label harus 'label'
                      'value': e['id'].toString(), // key value harus 'value'
                    })
                .toList(),
          );
    } else {
      depId[0].set('dept_id', '').options([]);
    }
    final result = roles.firstWhere((e) => e['id'] == id, orElse: () => {});
    if (result['id'] != null) {
      forms.set('dept_id', Option(result['departemen'], value: result['id']));
    }
  }

  Future getShift(int? id) async {
    final res = await api.shift.getData();
    shift = List<Map<String, dynamic>>.from(res.data ?? []);

    if (shift.isNotEmpty) {
      // Pastikan key label dan value benar
      shiftID[0].set('shift_id', '').options(
            shift
                .where((e) =>
                    e['shift_name'] != null &&
                    e['id'] != null) // filter valid data
                .map((e) => {
                      'label':
                          e['shift_name'].toString(), // key label harus 'label'
                      'value': e['id'].toString(), // key value harus 'value'
                    })
                .toList(),
          );
    } else {
      shiftID[0].set('shift_id', '').options([]);
    }
    final result = shift.firstWhere((e) => e['id'] == id, orElse: () => {});
    if (result['id'] != null) {
      forms.set('shift_id', Option(result['shift_name'], value: result['id']));
    }
  }

  Future getBuilding(int? id) async {
    final res = await api.building.getData();
    building = List<Map<String, dynamic>>.from(res.data ?? []);

    if (building.isNotEmpty) {
      buildingID[0].set('building_id', '').options(
            building
                .where((e) => e['name'] != null && e['building_id'] != null)
                .map((e) => {
                      'label': e['name'].toString(),
                      'value': e['building_id'].toString(),
                    })
                .toList(),
          );
    } else {
      buildingID[0].set('building_id', '').options([]);
    }
    final result =
        building.firstWhere((e) => e['building_id'] == id, orElse: () => {});
    if (result['building_id'] != null) {
      forms.set(
          'building_id', Option(result['name'], value: result['building_id']));
    }
  }

  Future getStatusKawin(int? id) async {
    final res = await api.statusKawin.getData();
    statusKawin = List<Map<String, dynamic>>.from(res.data ?? []);

    if (statusKawin.isNotEmpty) {
      statusKawinID[0].set('status_kawin_id', '').options(
            statusKawin
                .where((e) => e['keterangan'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['keterangan'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } else {
      statusKawinID[0].set('status_kawin_id', '').options([]);
    }
    final result =
        statusKawin.firstWhere((e) => e['id'] == id, orElse: () => {});
    if (result['id'] != null) {
      forms.set(
          'status_kawin_id', Option(result['keterangan'], value: result['id']));
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

  Future openDep() async {
    try {
      if (dep.isEmpty) {
        final res = await api.departemen.getData().ui.loading();
        dep = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      forms.set('dept_id', '').options(
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

  Future opensift() async {
    try {
      if (shift.isEmpty) {
        final res = await api.shift.getData().ui.loading();
        shift = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      forms.set('shift_id', '').options(
            shift
                .where((e) => e['shift_name'] != null && e['shift_id'] != null)
                .map((e) => {
                      'label': e['shift_name'].toString(),
                      'value': e['shift_id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future openBuilding() async {
    try {
      if (building.isEmpty) {
        final res = await api.building.getData().ui.loading();
        building = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      forms.set('building_id', '').options(
            building
                .where((e) => e['name'] != null && e['building_id'] != null)
                .map((e) => {
                      'label': e['name'].toString(),
                      'value': e['building_id'].toString(),
                    })
                .toList(),
          );
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

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*']);

      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['role_id'] = forms.extra('role_id');
        payload['dept_id'] = forms.extra('dept_id');
        payload['shift_id'] = forms.extra('shift_id');
        payload['building_id'] = forms.extra('building_id');
        payload['status_kawin_id'] = forms.extra('status_kawin_id');
        payload['is_active'] = forms.extra('is_active');

        payload['user_id'] = auth.id;

        // validasi file
        if (fileImage == null || fileTtd == null) {
          return Toast.show('File image dan ttd harus diisi');
        }

        payload['ttd'] = await api.toFile(fileTtd!.path);
        payload['image'] = await api.toFile(fileImage!.path);

        if (id == null) {
          final res = await api.karyawanTetap
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message.toString());
          }
        } else {
          final res = await api.karyawanTetap
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

  Future onSubmitTtd([int? id]) async {
    try {
      final form = forms.validate(required: ['ttd']);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;

        if (file != null) {
          payload['ttd'] = await api.toFile(file!.path);
        }

        if (id == null) {
          final res = await api.karyawanTetap
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message.toString());
          }
        } else {
          final res = await api.karyawanTetap
              .updateTtd(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
            Toast.success('Data berhasil diperbarui, silahkan refresh');
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future deleteUser(int id) async {
    try {
      final res =
          await api.karyawanTetap.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listkaryawan.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Get.snackbar('Berhasil', res.message.toString());
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
