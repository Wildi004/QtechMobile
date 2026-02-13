import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tidak.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class CreateKttController extends GetxController with Apis {
  final forms = LzForm.make([
    'nik',
    'name',
    'no_telp',
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
    'tgl_bergabung',
  ]);

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

  final regional = [
    {'name': 'Kantor Pusat'},
    {'name': 'Timur'},
    {'name': 'Barat'},
    {'name': 'Tengah'},
  ];

  Future<List<Map>> getgender() async {
    return gender;
  }

  Future<List<Map>> getAgama() async {
    return agama;
  }

  Future<List<Map>> getRegional() async {
    return regional;
  }

  @override
  void onInit() {
    super.onInit();
    roleid.add(LzForm.make(['role_id']));
    depId.add(LzForm.make(['dep_id']));

    statusKawinID.add(LzForm.make(['status_kawin_id']));
  }

  RxList<FormManager> statusKawinID = RxList<FormManager>();
  List<Map<String, dynamic>> statusKawin = [];

  RxList<FormManager> roleid = RxList<FormManager>();
  List<Map<String, dynamic>> roles = [];

  RxList<FormManager> depId = RxList<FormManager>();
  List<Map<String, dynamic>> dep = [];

  RxList<FormManager> regId = RxList<FormManager>();
  List<Map<String, dynamic>> reg = [];

  Future getReg(int? id) async {
    final res = await api.regional.getData();
    reg = List<Map<String, dynamic>>.from(res.data ?? []);

    if (reg.isNotEmpty) {
      regId[0].set('status_kawin_id', '').options(
            reg
                .where((e) => e['regional'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['regional'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } else {
      regId[0].set('status_kawin_id', '').options([]);
    }
    final result = reg.firstWhere((e) => e['id'] == id, orElse: () => {});
    if (result['id'] != null) {
      forms.set(
          'status_kawin_id', Option(result['regional'], value: result['id']));
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

  Future getDept(int? id) async {
    final res = await api.departemen.getData();
    roles = List<Map<String, dynamic>>.from(res.data ?? []);

    if (roles.isNotEmpty) {
      // Pastikan key label dan value benar
      depId[0].set('dep_id', '').options(
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
      depId[0].set('dep_id', '').options([]);
    }
    final result = roles.firstWhere((e) => e['id'] == id, orElse: () => {});
    if (result['id'] != null) {
      forms.set('dep_id', Option(result['departemen'], value: result['id']));
    }
  }

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

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*']);

      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['status_kawin_id'] = forms.extra('status_kawin_id');
        payload['role_id'] = forms.extra('role_id');
        payload['dep_id'] = forms.extra('dep_id');
        payload['user_id'] = auth.id;

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
