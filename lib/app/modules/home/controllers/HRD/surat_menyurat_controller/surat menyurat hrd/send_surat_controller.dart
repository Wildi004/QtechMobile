import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/user.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class SendSuratController extends GetxController with Apis {
  final forms = LzForm.make([
    'perihal',
    'tgl_surat',
    'sifat',
    'image',
    'keterangan',
  ]);
  File? file;
  RxString fileName = ''.obs;

  RxList<User> user = <User>[].obs;
  RxList<int> selectedDepIds = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    getDepartemen();
  }

  Future getDepartemen() async {
    try {
      final res = await api.user.getPageUser(limit: 'all');
      user.value = User.fromJsonList(res.body['data']);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future<List<Map>> getSifat() async {
    await Future.delayed(const Duration(seconds: 1));
    return sifat;
  }

  final sifat = [
    {'name': 'Biasa'},
    {'name': 'Penting'},
    {'name': 'Rahasia'},
  ];

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['perihal']);

      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;

        if (file != null) {
          payload['image'] = await api.toFile(file!.path);
        }
        final userIds = members.map((e) => e.extra('penerima')).toList();
        payload['penerima[]'] = userIds;

        if (id == null) {
          final res = await api.suratMasuk
              .sendData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message.toString());
          }
        } else {
          final res = await api.suratMasuk
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

  List<Map<String, dynamic>> users = [];
  RxList<FormManager> members = RxList([]);
  void addMember() async {
    try {
      members.add(LzForm.make(['penerima']));
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void removeMember(int index) {
    try {
      if (index >= 0 && index < members.length) {
        members.removeAt(index);
        update();
        logg('Member ke-$index dihapus');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future openUser(int index) async {
    try {
      if (users.isEmpty) {
        final res = await api.user.getPageUser().ui.loading();
        users = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      members[index].set('penerima').options(users.labelValue('name', 'id'));
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
