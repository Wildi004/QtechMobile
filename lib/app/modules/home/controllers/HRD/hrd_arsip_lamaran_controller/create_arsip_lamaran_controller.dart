import 'dart:io';

import 'package:get/get.dart' hide Bindings;

import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/arsip_lamaran.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class CreateArsipLamaranController extends GetxController with Apis {
  RxInt tab = 0.obs;

  final forms = LzForm.make([
    'nama',
    'image',
    'tgl_lamaran',
    'posisi',
    'lokasi_kantor',
    'status',
  ]);
  final status = [
    {'name': 'Interview'},
    {'name': 'Gagal Interview'},
    {'name': 'Lulus Interview'},
    {'name': 'Test'},
    {'name': 'Gagal Test'},
    {'name': 'Lulus Test'},
  ];
  File? file;
  RxString fileName = ''.obs;
  Rxn<ArsipLamaran> arsip = Rxn<ArsipLamaran>();
  RxBool isLoading = true.obs;

  Future<List<Map>> getStatus() async {
    return status;
  }

  ArsipLamaran? details;

  Future getDetailUser(int id) async {
    try {
      Bindings.onRendered(() async {
        Toast.overlay('Loading...', onCancel: () {});

        if (details == null) {
          final res = await api.arsipLamaran.getDataDetail(id);
          details = ArsipLamaran.fromJson(res.data ?? {});
        }

        forms.fill(details!.toJson());

        final uStatus = details?.status?.trim();
        final fStatus = status.firstWhere(
          (e) => e['name'] == uStatus,
          orElse: () => {},
        );

        if (fStatus.isNotEmpty) {
          forms.set('status', Option(uStatus!, value: uStatus));
        } else {}

        Toast.dismiss();
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
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

        payload['user_id'] = auth.id;

        if (file != null) {
          payload['image'] = await api.toFile(file!.path);
        } else {
          payload.remove('image');
        }

        if (id == null) {
          final res = await api.arsipLamaran
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? ' ');
          }
        } else {
          final res = await api.arsipLamaran
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? ' ');
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
