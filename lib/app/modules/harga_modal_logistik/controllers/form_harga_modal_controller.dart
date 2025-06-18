import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/modal_logistik.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class FormHargaModalController extends GetxController with Apis {
  final forms = LzForm.make([
    "kode_material",
    "nama",
    "tgl_input",
    "tgl_berlaku",
    "qty",
    "satuan",
    "harga_satuan",
    "harga_diskon",
    "ppn",
    "total_ppn",
    "sub_total",
    "ongkir",
    "harga_modal",
    "lokasi",
    "user_id",
    'lokasi',
    "supplier",
    "keterangan"
  ]);
  File? file;
  RxString fileName = ''.obs;
  Rxn<ModalLogistik> modalLogistik = Rxn<ModalLogistik>();

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*', 'user_id']);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;

        if (id == null) {
          final res = await api.modalLogistik
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
          }
        } else {
          final res = await api.modalLogistik
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
          }
        }
      } else {
        logg(form.error);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
