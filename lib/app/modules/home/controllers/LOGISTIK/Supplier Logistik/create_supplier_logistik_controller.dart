import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/supplier.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class CreateSupplierLogistikController extends GetxController with Apis {
  final forms = LzForm.make([
    'nama_perusahaan',
    'cp1',
    'cp2',
    'cp3',
    'email1',
    'email2',
    'email3',
    'alamat',
    'no_telp1',
    'no_telp2',
    'no_telp3',
    'no_fax',
    'npwp',
    'rek1',
    'bank1',
    'rek2',
    'bank2',
    'rek3',
    'bank3',
  ]);

  Rxn<Supplier> data = Rxn<Supplier>();

  Future onSubmit([int? id]) async {
    try {
      final required = [
        '*',
      ];
      final form = forms.validate(required: required);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;

        if (id == null) {
          final res = await api.supplier
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        } else {
          final res = await api.supplier
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
