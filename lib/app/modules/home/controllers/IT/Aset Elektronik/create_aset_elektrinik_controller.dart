import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20it/aset_elektronik.dart';

class CreateAsetElektrinikController extends GetxController with Apis {
  final forms = LzForm.make([
    'nama_asset',
    'kode_asset',
    'tgl_beli',
    'image',
    'image2',
    'kondisi',
    'tgl_pemberian',
    'merk',
    'keterangan',
    'user_id',
    'harga',
  ]);
  File? file;
  RxString fileName = ''.obs;
  XFile? fileImage;

  File? file2;
  RxString fileName2 = ''.obs;
  XFile? fileImage2;

  Rxn<AsetElektronik> aset = Rxn<AsetElektronik>();

  final status = [
    {'name': 'Baik'},
    {'name': 'Rusak'},
  ];

  Future<List<Map>> getStatus() async {
    return status;
  }

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*']);
      if (form.ok) {
        final payload = form.value;
        payload['user_id'] = forms.extra('user_id');

        if (file != null) {
          logg('Uploading image1: ${file!.path}');
          payload['image'] = await api.toFile(file!.path);
        }
        if (file2 != null) {
          logg('Uploading image2: ${file2!.path}');
          payload['image2'] = await api.toFile(file2!.path);
        }

        if (id == null) {
          final res = await api.asetElektronik
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        } else {
          final res = await api.asetElektronik
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

  RxList<FormManager> userId = RxList<FormManager>();
  List<Map<String, dynamic>> users = [];
  @override
  void onInit() {
    super.onInit();

    userId.add(LzForm.make(['user_id']));
  }

  Future getUser(int? id) async {
    final res = await api.user.getPageUser();
    users = List<Map<String, dynamic>>.from(res.data ?? []);

    if (users.isNotEmpty) {
      // Pastikan key label dan value benar
      userId[0].set('user_id', '').options(
            users
                .where((e) => e['name'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['name'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } else {
      userId[0].set('user_id', '').options([]);
    }
    final result = users.firstWhere((e) => e['id'] == id, orElse: () => {});
    if (result['id'] != null) {
      forms.set('user_id', Option(result['name'], value: result['id']));
    }
  }

  Future openUser() async {
    try {
      if (users.isEmpty) {
        final res = await api.user.getPageUser().ui.loading();
        users = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      forms.set('user_id', '').options(
            users
                .where((e) => e['name'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['name'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
