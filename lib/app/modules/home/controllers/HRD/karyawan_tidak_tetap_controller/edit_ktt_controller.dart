import 'dart:io';

import 'package:get/get.dart' hide Bindings;

import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tidak.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class EditKttController extends GetxController with Apis {
  XFile? fileFoto;
  RxInt tab = 0.obs;

  final forms = LzForm.make([
    'nik',
    'name',
    'no_telp',
    'foto',
    'role_id',
    'dep_id',
    'regional',
    "dep",
    'alamat_ktp',
    'alamat_domisili',
    'tgl_lahir',
    "role_id",
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

  KaryawanTidak? details;

  Future getDetailUser(int id) async {
    try {
      Bindings.onRendered(() async {
        Toast.overlay('Loading...', onCancel: () {});

        if (details == null) {
          final res = await api.karyawanTidak.getDataDetail(id);
          details = KaryawanTidak.fromJson(res.data ?? {});
        }
        forms.set('dep_id', details?.depId?.toString());

        forms.fill(details!.toJson());

        await getDept(details?.depId);
        logg('Data diisi ke form: ${details!.toJson()}', limit: 9999);
        final userAgama = details?.agama?.trim();

        final fAgama = agama.firstWhere(
          (e) => e['name'] == userAgama,
          orElse: () => {},
        );
        if (fAgama.isNotEmpty) {
          forms.set('agama', Option(userAgama!, value: userAgama));
        } else {}
        final userGender = details?.gender?.trim();

        final fGander = gender.firstWhere(
          (e) => e['name'] == userGender,
          orElse: () => {},
        );

        if (fGander.isNotEmpty) {
          forms.set('gender', Option(userGender!, value: userGender));
        } else {}
        await getStatusKawin(details?.statusKawinId);
        await getRoles(details?.roleId);
        await getStatusAktif(details?.isActive);
        Toast.dismiss();
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();
    roleid.add(LzForm.make(['role_id']));

    depId.add(LzForm.make(['dep_id']));
    statusKawinID.add(LzForm.make(['status_kawin_id']));
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
    return aktif;
  }

  Future getStatusAktif(int? id) async {
    final option = aktif.firstWhere(
      (e) => e['id'] == id,
      orElse: () => {},
    );

    if (option.isNotEmpty) {
      // set value ke form
      forms.set(
        'is_active',
        Option(option['name'] as String, value: option['id'] as int),
      );

      // log isi detail
      logg('==> isActive option: $option'); // map dari aktif
      logg('==> isActive di form: ${forms.get('is_active')}'); // object Option
      logg('==> isActive extra: ${forms.extra('is_active')}'); // value
      return option;
    } else {
      logg('==> isActive kosong, id: $id');
      return null;
    }
  }

  Future<List<Map>> getAgama() async {
    return agama;
  }

  Future<List<Map>> getgender() async {
    return gender;
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
      forms.set('dep_id', option['departemen']);
      forms.set('dep_id', Option(option['departemen'], value: option['id']));
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
      final required = [
        'nik',
        'name',
        'no_telp',
        'role_id',
        'dep_id',
        'alamat_ktp',
        'alamat_domisili',
        'tgl_lahir',
        'tempat_lahir',
        'gender',
        'agama',
        'status_kawin_id',
        'tgl_bergabung',
        'is_active',
      ];

      if (id == null) {
        required.addAll([
          'foto',
        ]);
      }

      final form = forms.validate(required: required);

      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['role_id'] = forms.extra('role_id');
        payload['status_kawin_id'] = forms.extra('status_kawin_id');
        payload['dep_id'] = forms.extra('dep_id');
        payload['is_active'] = forms.extra('is_active');
        payload['user_id'] = auth.id;

        if (details == null) {
          logg('Data detail belum tersedia. Gagal submit.');
          Toast.warning('Data belum siap. Mohon tunggu.');
          return;
        }

        payload.remove('proyek_item_id');

        if (file != null) {
          payload['foto'] = await api.toFile(file!.path);
        } else {
          payload.remove('foto');
        }

        final proyekItem = forms.extra('proyek_item_id');

        if (proyekItem != null && proyekItem.toString().trim().isNotEmpty) {
          final parsed = int.tryParse(proyekItem.toString());
          if (parsed != null) {
            payload['proyek_item_id'] = parsed;
          }
        }

        if (id == null) {
          final res = await api.karyawanTidak
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
          }
        } else {
          final res = await api.karyawanTidak
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateData1(KaryawanTidak data, int id) {
    try {
      final index = listkaryawan.indexWhere((e) => e.id == id);
      logg('updating... index=$index, id=$id');

      if (index >= 0) {
        listkaryawan[index] = data;

        // jika kamu pakai rx list utk UI:
        karyawan.value = List.from(listkaryawan);

        // kalau ada widget yang listen isLoading.refresh:
        isLoading.refresh();
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
}
