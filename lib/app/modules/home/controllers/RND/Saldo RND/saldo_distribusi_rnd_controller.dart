import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20rnd/saldo_rnd.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class SaldoDistribusiRndController extends GetxController with Apis {
  final forms = LzForm.make(['keterangan', 'tgl_terima', 'kredit', 'dep']);
  Rxn<SaldoRnd> saldo = Rxn<SaldoRnd>();
  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*']);
      if (!form.ok) return;
      final auth = await Auth.user();
      final payload = form.value;
      payload['user_id'] = auth.id;
      final res = id == null
          ? await api.saldo
              .createDataSaldoIt(payload)
              .ui
              .loading('Menambahkan...')
          : await api.saldo
              .updateDataSaldoIt(payload, id)
              .ui
              .loading('Memperbarui...');
      if (res.status) {
        Get.back(result: res.data);
        Get.snackbar('Berhasil', res.message.toString());
      } else {
        String errorMessage = _parseErrorMessage(res.message);
        Get.snackbar(
          'Gagal',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

String _parseErrorMessage(dynamic message) {
  if (message is Map) {
    return message.values.expand((v) => v).join('\n');
  }
  return message.toString();
}
