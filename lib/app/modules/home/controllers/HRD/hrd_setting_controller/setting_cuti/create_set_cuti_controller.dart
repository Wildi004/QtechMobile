import 'dart:io';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/cuti.dart';

class CreateSetCutiController extends GetxController with Apis {
  final forms = LzForm.make(['jml_cuti']);
  File? file;
  RxString fileName = ''.obs;
  Rxn<Cuti> cuti = Rxn<Cuti>();

  List<Map<String, dynamic>> users = [];
  RxList<FormManager> members = RxList<FormManager>();

  @override
  void onInit() {
    super.onInit();

    // Inisialisasi form 1 peserta langsung tampil
    members.add(LzForm.make(['user_id']));
  }

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['jml_cuti']);
      if (form.ok) {
        final payload = form.value;
        final userId = members
            .map((e) => int.tryParse(e.extra('user_id').toString()))
            .where((e) => e != null)
            .map((e) => e!)
            .first;
        payload['user_id'] = userId;

        logg('Ini nilainya $userId'); // pastikan nilai userIds sudah benar
        payload['user_id'] = userId;

        if (id == null) {
          final res =
              await api.cuti.createData(payload).ui.loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message.toString());
          }
        } else {
          final res = await api.cuti
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

  Future openUser(int index) async {
    try {
      if (users.isEmpty) {
        final res = await api.user.getPageUser(limit: 'all').ui.loading();

        users = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      members[index].set('user_id').options(users.labelValue('name', 'id'));
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
