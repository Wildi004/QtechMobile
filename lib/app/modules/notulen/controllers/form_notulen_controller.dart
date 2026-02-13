import 'dart:io';

import 'package:get/get.dart' hide Bindings;
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/notulen/notulen.dart';
import 'package:qrm_dev/app/data/models/notulen/notulen_detail.dart';

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
  List<NotulenDetail>? notulenDetail;

  Notulen? details;

  Future getDetailAset(int id) async {
    try {
      Bindings.onRendered(() async {
        Toast.overlay('Loading...', onCancel: () {});

        if (details == null) {
          final res = await api.notulen.getDatanot(id);
          details = Notulen.fromJson(res.data ?? {});
        }

        forms.fill(details!.toJson());

        await getSifatAktif(details?.sifat);

        Toast.dismiss();
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  final sifat = [
    {'id': 0, 'name': 'Umum'},
    {'id': 1, 'name': 'Penting'},
    {'id': 2, 'name': 'Rahasia'},
  ];
  Future getSifatAktif(int? id) async {
    final option = sifat.firstWhere(
      (e) => e['id'] == id,
      orElse: () => {},
    );

    if (option.isNotEmpty) {
      forms.set('sifat', option['name']);
      forms.set(
        'sifat',
        Option(option['name'] as String, value: option['id'] as int),
      );

      return option;
    } else {
      return null;
    }
  }

  Rxn<Notulen> notulen = Rxn<Notulen>();
  void loadMembersFromNotulen(Notulen data) {
    members.clear();

    final details = data.notulenDetail;
    if (details == null || details.isEmpty) return;

    for (final d in details) {
      if (d.userId == null || d.role == null) continue;

      final fm = LzForm.make(['user_id', 'role']);

      fm.set('user_id', d.userId).extra(d.userId!.toString());
      fm.set('role', d.role).extra(d.role!.toString());

      members.add(fm);
    }

    logg('Members loaded: ${members.length}');
  }

  Future onSubmit([int? id]) async {
    try {
      final required = ['*', 'image'];

      final form = forms.validate(required: required);

      logg(form.error);
      if (form.ok) {
        final payload = form.value;

        logg(' Validasi form: $payload');
        logg(' Data form: ${form.value}');
        logg(form);

        if (id != null) {
          required.add('image');
        }

        final userIds = members.map((e) => e.extra('user_id')).toList();
        final roleIds = members.map((e) => e.extra('role')).toList();

        payload['user_id[]'] = userIds;
        payload['role[]'] = roleIds;
        payload['sifat'] = forms.extra('sifat');
        if (file != null) {
          payload['image'] = await api.toFile(file!.path);
        } else {
          payload.remove('image');
        }
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

  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> roles = [];

  RxList<FormManager> members = RxList([]);

  Future<List<Map>> getSifat() async {
    await Future.delayed(const Duration(seconds: 1));
    return sifat;
  }

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
