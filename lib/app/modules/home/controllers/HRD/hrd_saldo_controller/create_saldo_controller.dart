import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/saldo_ptj.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class CreateSaldoController extends GetxController with Apis {
  final forms = LzForm.make([
    'keterangan',
    'tgl_terima',
    'kredit',
    'dep',
    'saldo_akhir',
  ]);
  Rxn<SaldoPtj> saldoPtj = Rxn<SaldoPtj>();

  @override
  void onInit() {
    super.onInit();
    getSaldoAkhir();
  }

  Future<void> getSaldoAkhir() async {
    try {
      final res = await api.saldo.getDataSaldoPtj();
      if (res.status) {
        saldoPtj.value = SaldoPtj.fromJson(res.data);

        forms.set('saldo_akhir', saldoPtj.value?.saldoAkhirFormat ?? '0');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*']);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;

        payload.remove('saldo_akhir');

        if (id == null) {
          final res =
              await api.saldo.createData(payload).ui.loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message.toString());
          }
        } else {
          final res = await api.saldo
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message.toString());
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
