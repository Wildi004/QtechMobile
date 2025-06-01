import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/modal_logistik.dart';

class EditHargaModalController extends GetxController with Apis {
  final forms = LzForm.make([
    'kode_material',
  ]);
  RxString fileName = ''.obs;
  Rxn<ModalLogistik> modal = Rxn<ModalLogistik>();

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['kode_material']);
      if (form.ok) {
        final payload = form.value;

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
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
