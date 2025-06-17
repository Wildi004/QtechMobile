import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/arsip_karyawan.dart';

class CreateArsipKaryawanController extends GetxController with Apis {
  final forms = LzForm.make(['files[]']);
  File? file;
  RxString fileName = ''.obs;
  Rxn<ArsipKaryawan> tkdn = Rxn<ArsipKaryawan>();
  int? selectedUserId;

  Future onSubmit([int? id]) async {
    try {
      if (files.isEmpty) {
        return Toast.show('Kamu belum memilih file');
      }

      Map<String, dynamic> payload = {
        'user_id': selectedUserId,
        'files[]': await Future.wait(files.map((path) => api.toFile(path))),
      };

      final res = await api.arsipKaryawanHrd
          .createData(payload)
          .ui
          .loading('Menambahkan...');

      if (res.status) {
        Toast.success('Berhasil menambahkan files');
        Get.back(result: res.data);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  // handle files
  RxList<String> files = RxList([]);

  void onFiles(List<PlatformFile> data) async {
    try {
      // final filePath = result.files.single.path;
      // if (filePath != null) {
      //   forms.set('files[]', filePath);
      //   controller.fileName.value = filePath;
      //   controller.file = File(filePath);
      // }

      files.addAll(data.map((e) => e.path ?? '-'));
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void removeFile(int index) {
    files.removeAt(index);
  }
}
