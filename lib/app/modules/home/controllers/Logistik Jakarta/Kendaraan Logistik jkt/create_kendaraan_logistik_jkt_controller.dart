import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/kendaraan_logistik.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class CreateKendaraanLogistikJktController extends GetxController with Apis {
  final forms = LzForm.make([
    'kode_aset',
    'nama_aset',
    'no_pol',
    'tgl_qir',
    'tgl_beli',
    'tgl_samsat',
    'jumlah',
    'harga_perolehan',
    'penanggung_jawab',
    'status',
    'image',
  ]);

  File? file;
  RxString fileName = ''.obs;
  XFile? fileImage;
  Rxn<KendaraanLogistik> data = Rxn<KendaraanLogistik>();
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
        payload['status'] = forms.extra('status');

        final hargaText = payload['harga_perolehan'] ?? '0';
        final hargaNumber = hargaText.replaceAll(RegExp(r'[^0-9]'), '');
        payload['harga_perolehan'] = int.tryParse(hargaNumber) ?? 0;

        payload['user_id'] = auth.id;
        if (file != null) {
          payload['image'] = await api.toFile(file!.path);
        } else {
          payload.remove('image');
        }

        if (id == null) {
          final res = await api.kendaraanLogistik
              .createDataJkt(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        } else {
          final res = await api.kendaraanLogistik
              .updateDataJkt(payload, id)
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
}
