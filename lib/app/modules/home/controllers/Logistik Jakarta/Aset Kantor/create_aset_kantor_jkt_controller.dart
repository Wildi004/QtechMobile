import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik%20jkt/aset_kantor_log_jkt.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class CreateAsetKantorJktController extends GetxController with Apis {
  final forms = LzForm.make([
    'kode_aset',
    'nama_aset',
    'jumlah',
    'harga_perolehan',
    'tgl_beli',
    'penanggung_jawab',
    'image',
    'status',
  ]);
  File? file;
  RxString fileName = ''.obs;
  XFile? fileImage;
  Rxn<AsetKantorLogJkt> aset = Rxn<AsetKantorLogJkt>();

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

        final hargaText = payload['harga_perolehan'] ?? '0';
        final hargaNumber = hargaText.replaceAll(RegExp(r'[^0-9]'), '');
        payload['harga_perolehan'] = int.tryParse(hargaNumber) ?? 0;

        payload['status'] = forms.extra('status');

        payload['user_id'] = auth.id;
        if (file != null) {
          payload['image'] = await api.toFile(file!.path);
        } else {
          payload.remove('image');
        }

        if (id == null) {
          final res = await api.asetKantorLogJkt
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        } else {
          final res = await api.asetKantorLogJkt
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
}
