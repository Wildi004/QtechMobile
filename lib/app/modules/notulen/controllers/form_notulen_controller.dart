import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/notulen/notulen.dart';

class FormNotulenController extends GetxController with Apis {
  final forms = LzForm.make([
    'tgl_rapat',
    'judul',
    'jam',
    'jml_peserta',
    'isi',
    'sifat',
    'image',
  ]);

  File? file;
  RxString fileName = ''.obs;

  Rxn<Notulen> notulen = Rxn<Notulen>();

  Future onSubmit([int? id]) async {
    try {
      final form = forms
          .validate(required: ['*'], message: {'judul': 'Judul wajib di isi,'});
      logg(form.error);
      if (form.ok) {
        final payload = form.value;

        logg(' Validasi form: $payload');
        logg(' Data form: ${form.value}');
        logg(form);

        if (file != null) {
          payload['image'] = await api.toFile(file!.path);
        }

        // get data user dan role dalam bentuk user_id[] dan role[]
        final userIds = members.map((e) => e.extra('user_id')).toList();
        final roleIds = members.map((e) => e.extra('role')).toList();

        payload['user_id[]'] = userIds;
        payload['role[]'] = roleIds;

        if (id == null) {
          final res = await api.notulen
              .createNotulen(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
          }
        } else {
          final res = await api.notulen
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

  // handle daftar peserta
  // get data user dan role
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> roles = [];

  RxList<FormManager> members = RxList([]);

  void addMember() async {
    try {
      members.add(LzForm.make(['user_id', 'role']));
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
        final res = await api.user.getListUser().ui.loading();
        users = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      members[index].set('user_id').options(users.labelValue('name', 'id'));
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future openRoles(int index) async {
    try {
      if (roles.isEmpty) {
        final res = await api.notulenRole.getData().ui.loading();
        roles = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      members[index].set('role').options(roles.labelValue('role', 'id'));
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
