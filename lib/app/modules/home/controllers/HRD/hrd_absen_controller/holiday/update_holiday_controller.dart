import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/holiday.dart';

class UpdateHolidayController extends GetxController with Apis {
  final forms = LzForm.make(['description']);
  RxString fileName = ''.obs;
  Rxn<Holiday> holiday = Rxn<Holiday>();

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['description']);
      if (form.ok) {
        final payload = form.value;
        if (id == null) {
          final res = await api.holiday
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
          }
        } else {
          final res = await api.holiday
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
