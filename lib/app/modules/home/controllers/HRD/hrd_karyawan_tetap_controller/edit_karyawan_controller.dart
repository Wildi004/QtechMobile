import 'dart:io';

import 'package:get/get.dart' hide Bindings;
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tetap.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

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

  File? file;
  XFile? fileImage;
  XFile? fileTtd;

  RxString fileName = ''.obs;
  List<KaryawanTetap> listkaryawan = [];
  final jabatanLabel = 'Jabatan'.obs;

  RxBool isLoading = true.obs;

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
        forms.set('role_id', details?.roleId?.toString());
        forms.set('dept_id', details?.deptId?.toString());

        final userRegional = details?.regional?.trim();
        final foundRegional = regionals.firstWhere(
          (e) => e['name'] == userRegional,
          orElse: () => {},
        );

        if (foundRegional.isNotEmpty) {
          forms.set('regional', Option(userRegional!, value: userRegional));
        } else {}

        await getRoles(details?.roleId);
        await getDept(details?.deptId);
        await getStatusKawin(details?.statusKawinId);
        await getStatusAktif(details?.isActive);
        await getShift(details?.shiftId);
        await getBuilding(details?.buildingId);

        Toast.dismiss();
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

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

  List<Map<String, dynamic>> regional = [];
  RxList<FormManager> regionalID = RxList<FormManager>();

  RxList<FormManager> statusAktifID = RxList<FormManager>();
  List<Map<String, dynamic>> statusAktif = [];
  @override
  void onInit() {
    super.onInit();

    roleid.add(LzForm.make(['role_id']));
    depId.add(LzForm.make(['dept_id']));
    shiftID.add(LzForm.make(['shift_id']));
    buildingID.add(LzForm.make(['building_id']));
    statusKawinID.add(LzForm.make(['status_kawin_id']));
  }

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
  final statuskaryawan = [
    {'name': 'Kontrak'},
    {'name': 'Tetap'},
  ];

  final aktif = [
    {'id': 1, 'name': 'Active'},
    {'id': 0, 'name': 'Non-Active'},
  ];

  final regionals = [
    {'name': 'Pusat'},
    {'name': 'Pusat-Finance'},
    {'name': 'Pusat-BSD'},
    {'name': 'Pusat-Teknik'},
    {'name': 'Timur'},
    {'name': 'Barat'},
  ];

  Future<List<Map>> getReg() async {
    return regionals;
  }

  Future getStatusAktif(int? id) async {
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

  Future<List<Map>> getAktif() async {
    return aktif;
  }

  Future<List<Map>> getStatuskaryawan() async {
    return statuskaryawan;
  }

  Future<List<Map>> getgender() async {
    return gender;
  }

  Future<List<Map>> getAgama() async {
    return agama;
  }

  Future getRoles(int? id) async {
    final res = await api.role.getDataPage();
    roles = List<Map<String, dynamic>>.from(res.data ?? []);

    final option = roles.firstWhere((e) => e['id'] == id, orElse: () => {});

    if (option['id'] != null) {
      forms.set('role_id', option['role']);
      forms.set('role_id', Option(option['role'], value: option['id']));
    }
  }

  Future getDept(int? id) async {
    final res = await api.departemen.getDataPage();
    dep = List<Map<String, dynamic>>.from(res.data ?? []);

    final option = dep.firstWhere((e) => e['id'] == id, orElse: () => {});

    if (option['id'] != null) {
      forms.set('dept_id', option['departemen']);
      forms.set('dept_id', Option(option['departemen'], value: option['id']));
    }
  }

  Future getShift(int? id) async {
    final res = await api.shift.getData();
    shift = List<Map<String, dynamic>>.from(res.data ?? []);

    final option =
        shift.firstWhere((e) => e['shift_id'] == id, orElse: () => {});

    if (option['shift_id'] != null) {
      forms.set('shift_id', option['shift_name']);
      forms.set(
          'shift_id', Option(option['shift_name'], value: option['shift_id']));
    }
  }

  Future getBuilding(int? id) async {
    final res = await api.building.getData();
    building = List<Map<String, dynamic>>.from(res.data ?? []);

    final option =
        building.firstWhere((e) => e['building_id'] == id, orElse: () => {});

    if (option['building_id'] != null) {
      forms.set('building_id', option['name']);
      forms.set(
          'building_id', Option(option['name'], value: option['building_id']));
    }
  }

  Future getStatusKawin(int? id) async {
    final res = await api.statusKawin.getData();
    statusKawin = List<Map<String, dynamic>>.from(res.data ?? []);

    final option =
        statusKawin.firstWhere((e) => e['id'] == id, orElse: () => {});

    if (option['id'] != null) {
      forms.set('status_kawin_id', option['keterangan']);
      forms.set(
          'status_kawin_id', Option(option['keterangan'], value: option['id']));
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
      final required = [
        'name',
        'no_induk',
        'email',
        'no_telp',
        'golongan',
        'prosentase',
        'no_ktp',
      ];

      if (id == null) {
        required.addAll(['image', 'ttd']);
      }

      final form = forms.validate(required: required);
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

        if (details == null) {
          logg('Data detail belum tersedia. Gagal submit.');
          Toast.warning('Data belum siap. Mohon tunggu.');
          return;
        }

        if (file != null) {
          payload['image'] = await api.toFile(file!.path);
        } else {
          payload.remove('image');
        }
        if (file != null) {
          payload['ttd'] = await api.toFile(file!.path);
        } else {
          payload.remove('ttd');
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
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');

          if (res.status) {
            Get.back(result: res.data);
            Toast.success(res.message);
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
