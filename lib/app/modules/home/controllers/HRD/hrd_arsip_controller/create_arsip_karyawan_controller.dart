import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/arsip_karyawan.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/arsip_karyawan_hrd/detail.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';

class CreateArsipKaryawanController extends GetxController with Apis {
  final forms = LzForm.make(['files[]']);
  File? file;
  RxString fileName = ''.obs;
  Rxn<ArsipKaryawan> tkdn = Rxn<ArsipKaryawan>();
  int? selectedUserId;
  String? token;
  RxList<ArsivKaryawanDetail> detailsArsip = RxList([]);

  void setToken() {
    token = storage.read('token');
  }

  Future onSubmit([int? id, int? idArsip]) async {
    try {
      if (files.isEmpty) {
        return Toast.show('Kamu belum memilih file');
      }
      Toast.overlay('Memperbarui...', onCancel: () => {});

      Map<String, dynamic> payload = {
        'user_id': selectedUserId,
      };

      if (idArsip == null) {
        // create
        payload['files[]'] =
            await Future.wait(files.map((path) => api.toFile(path)));
      } else {
        payload['files'] =
            await Future.wait(files.map((path) => api.toFile(path)));
      }

      if (idArsip != null) {
        final res = await api.arsipKaryawanHrd
            .updateData(payload, idArsip)
            .ui
            .loading('Mengubah...');

        if (res.status) {
          Toast.success('Berhasil memperbarui files');
          Get.back(result: res.data);
        }

        return;
      }

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
