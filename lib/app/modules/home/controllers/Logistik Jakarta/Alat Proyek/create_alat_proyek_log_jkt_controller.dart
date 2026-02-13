import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/alat_proyek.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class CreateAlatProyekLogJktController extends GetxController with Apis {
  final forms = LzForm.make([
    'kode_alat',
    'type',
    'nama_alat',
    'jumlah',
    'harga_satuan',
    'harga_perolehan',
    'status',
    'keterangan',
    'tgl_beli',
    'reg_id',
    'dep_id',
    'proyek_item_id',
    'image',
    'pm',
    'tgl_service',
  ]);

  File? file;
  RxString fileName = ''.obs;
  XFile? fileImage;
  Rxn<AlatProyek> aset = Rxn<AlatProyek>();

  final status = [
    {'id': 0, 'name': 'Tersedia'},
    {'id': 1, 'name': 'Terpakai'},
    {'id': 2, 'name': 'Rusak'},
    {'id': 3, 'name': 'Service'},
    {'id': 4, 'name': 'Hilang'},
  ];

  Future<List<Map>> getStatus() async {
    return status;
  }

  int parseNumber(dynamic value) {
    if (value == null) return 0;
    final cleaned = value.toString().replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleaned) ?? 0;
  }

  Future onSubmit([int? id]) async {
    try {
      final required = ['*', 'image'];

      if (id != null) {
        required.add('image');
      }

      final form = forms.validate(required: required);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['harga_perolehan'] = parseNumber(payload['harga_perolehan']);
        payload['jumlah'] = parseNumber(payload['jumlah']);
        payload['harga_satuan'] = parseNumber(payload['harga_satuan']);

        payload['status'] = forms.extra('status');
        payload['dep_id'] = forms.extra('dep_id');
        payload['reg_id'] = forms.extra('reg_id');
        payload['proyek_item_id'] = forms.extra('proyek_item_id');
        payload['pm'] = forms.extra('pm');

        payload['user_id'] = auth.id;
        if (file != null) {
          payload['image'] = await api.toFile(file!.path);
        } else {
          payload.remove('image');
        }

        if (id == null) {
          final res = await api.alatProyekLogJkt
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        } else {
          final res = await api.alatProyekLogJkt
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxList<FormManager> depId = RxList<FormManager>();
  List<Map<String, dynamic>> dep = [];

  RxList<FormManager> regId = RxList<FormManager>();
  List<Map<String, dynamic>> reg = [];

  RxList<FormManager> proyekId = RxList<FormManager>();
  List<Map<String, dynamic>> proyek = [];

  Future openProyek() async {
    try {
      if (proyek.isEmpty) {
        final res =
            await api.dataProyek.getProyekBaratAll(limit: 'all').ui.loading();
        proyek = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      final opts = proyek
          .where((e) => e['judul_kontrak'] != null && e['id'] != null)
          .map((e) => {
                'label': '${e['kode_proyek']} || ${e['judul_kontrak']}',
                'value': e['id'],
              })
          .toList();

      if (opts.isEmpty) {
        return;
      }

      forms.set('proyek_item_id', '').options(opts);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future getPM() async {
    final data = proyek.firstWhere(
        (e) => e['id'] == forms.extra('proyek_item_id'),
        orElse: () => {});

    if (data['id'] == null) {
      return Toast.show('Data tidak ditemukan');
    }

    final items = List<Map>.from(data['data_proyek_item'] ?? []);
    final options = items.labelValue('pm_name', 'pm');

    forms.set('pm').options(options);
  }

  Future getProyek(int? id) async {
    final res =
        await api.dataProyek.getProyekBaratAll(limit: 'all').ui.loading();
    proyek = List<Map<String, dynamic>>.from(res.data ?? []);

    final option = proyek.firstWhere((e) => e['id'] == id, orElse: () => {});

    if (option['id'] != null) {
      forms.set('proyek_item_id', option['judul_kontrak']);
      forms.set('proyek_item_id',
          Option(option['judul_kontrak'], value: option['id']));
    }
  }

  Future openDep() async {
    try {
      if (dep.isEmpty) {
        final res = await api.departemen.getDepAll(limit: 'all').ui.loading();
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
    final res = await api.departemen.getDepAll(limit: 'all');
    dep = List<Map<String, dynamic>>.from(res.data ?? []);

    final option = dep.firstWhere((e) => e['id'] == id, orElse: () => {});

    if (option['id'] != null) {
      forms.set('dep_id', option['departemen']);
      forms.set('dep_id', Option(option['departemen'], value: option['id']));
    }
  }

  Future openReg() async {
    try {
      if (reg.isEmpty) {
        final res = await api.regional.getData().ui.loading();
        reg = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      forms.set('reg_id', '').options(
            reg
                .where((e) => e['regional'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['regional'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future getReg(int? id) async {
    final res = await api.regional.getData();
    reg = List<Map<String, dynamic>>.from(res.data ?? []);

    final option = reg.firstWhere((e) => e['id'] == id, orElse: () => {});

    if (option['id'] != null) {
      forms.set('reg_id', option['regional']);
      forms.set('reg_id', Option(option['regional'], value: option['id']));
    }
  }
}
