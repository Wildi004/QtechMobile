import 'package:get/get.dart' hide Bindings;
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/ekpedisi.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class CreateEkpedisiController extends GetxController with Apis {
  final forms = LzForm.make([
    'nama',
    'alamat',
    'jenis',
    'no_hp',
    'cp',
    'hp_cp',
    'status',
    'keterangan',
  ]);

  Rxn<Ekpedisi> data = Rxn<Ekpedisi>();
  final status = [
    {'id': 0, 'name': 'Warning'},
    {'id': 1, 'name': 'Aktif'},
    {'id': 2, 'name': 'Tidak Aktif'},
  ];
  Future<List<Map>> getStatus() async {
    return status;
  }

  Future onSubmit([int? id]) async {
    try {
      final required = ['*'];

      final form = forms.validate(required: required);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;
        payload['status'] = forms.extra('status');
        payload['user_id'] = auth.id;

        if (id == null) {
          final res = await api.ekpedisi
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        } else {
          final res = await api.ekpedisi
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

  Ekpedisi? details;

  Future getStatusAktif(int? id) async {
    final option = status.firstWhere(
      (e) => e['id'] == id,
      orElse: () => {},
    );

    if (option.isNotEmpty) {
      forms.set('status', option['name']);
      forms.set(
        'status',
        Option(option['name'] as String, value: option['id'] as int),
      );

      return option;
    } else {
      return null;
    }
  }

  Future getDetails(int id) async {
    try {
      Bindings.onRendered(() async {
        Toast.overlay('Loading...', onCancel: () {});

        if (details == null) {
          final res = await api.ekpedisi.getDataDetail(id);
          details = Ekpedisi.fromJson(res.data ?? {});
        }

        forms.fill(details!.toJson());
        await getStatusAktif(details?.status);
        Toast.dismiss();
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
