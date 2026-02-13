import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Bindings;
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/profile_cuti.dart';

class FormValidasiCutiBsdController extends GetxController with Apis {
  ProfileCuti? data;
  final forms = LzForm.make([
    'user_id',
    'dep_id',
    'tgl_cuti',
    'perihal',
    'keterangan',
    'cuti_from',
    'cuti_to',
    'lama_cuti',
    'status_hrd',
    'approval',
    'status_dir_keuangan',
    'aprroved_by',
    'created_at',
    'created_in',
    'user_name',
    'approval_name',
    'aprroved_by_name',
    'departemen',
  ]);

  Future<List<Map>> statusV() async {
    return status;
  }

  final status = [
    {'id': 0, 'name': 'Pending'},
    {'id': 1, 'name': 'Acc'},
    {'id': 2, 'name': 'Tolak'},
  ];
  RxBool isLoading = true.obs;

  List<ProfileCuti> listData = [];
  RxList<ProfileCuti> dataProfileCuti = <ProfileCuti>[].obs;

  ProfileCuti? details;

  Future getDetailAset(int id) async {
    try {
      Bindings.onRendered(() async {
        Toast.overlay('Loading...', onCancel: () {});

        if (details == null) {
          final res = await api.profileCuti.getDataDetailBelum(id);
          details = ProfileCuti.fromJson(res.data ?? {});
        }

        forms.fill(details!.toJson());

        // await getStatusAktif(details?.status);

        Toast.dismiss();
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future getDetailSudah(int id) async {
    try {
      Bindings.onRendered(() async {
        Toast.overlay('Loading...', onCancel: () {});

        if (details == null) {
          final res = await api.profileCuti.getDataDetailSudah(id);
          details = ProfileCuti.fromJson(res.data ?? {});
        }

        forms.fill(details!.toJson());

        // await getStatusAktif(details?.status);

        Toast.dismiss();
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future<void> onSubmit(int? id) async {
    try {
      if (data == null) {
        return Toast.show('Data kasbon tidak ditemukan.');
      }

      final kesimpulan = forms.extra('status_dir_keuangan');

      final payload = {
        'status_dir_keuangan': kesimpulan,
      };

      final res = await api.hrdCuti
          .updateValidasi(payload, data!.id!)
          .ui
          .loading('Mengirim validasi...');

      if (res.status) {
        Toast.show('Validasi berhasil dikirim');
        Get.back(result: res.data);
      } else {
        Toast.error(res.message ?? 'Gagal mengirim validasi');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future onPageInit() async {
    try {} catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (data != null) {
      forms.fill(data!.toJson());
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }
}
