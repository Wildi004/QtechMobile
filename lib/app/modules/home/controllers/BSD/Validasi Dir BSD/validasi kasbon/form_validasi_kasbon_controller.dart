import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Bindings;
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/kasbon.dart';

class FormValidasiKasbonController extends GetxController with Apis {
  Kasbon? data;
  final forms = LzForm.make([
    'no_pengajuan',
    'keterangan',
    'user_id',
    'dep_id',
    'status',
    'jml',
    'tgl_kasbon',
    'tgl_terima',
    'status_gm',
    'approval',
    'status_dir_keuangan',
    'approved_by',
    'status_dirut',
    'approved_dirut',
    'created_at',
    'created_by',
    'no_hide',
    'no_hide_bkk',
    'stts_check',
    'user',
    'dep',
    'approval_name',
    'approved_by_name',
    'approved_dirut_name',
    'created_by_name',
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

  List<Kasbon> listData = [];
  RxList<Kasbon> dataKasbon = <Kasbon>[].obs;

  Kasbon? details;

  Future getDetailAset(int id) async {
    try {
      Bindings.onRendered(() async {
        Toast.overlay('Loading...', onCancel: () {});

        if (details == null) {
          final res = await api.kasbon.getDataDetail(id);
          details = Kasbon.fromJson(res.data ?? {});
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

      final kesimpulan = forms.extra('status_gm');

      final payload = {
        'status_gm': kesimpulan,
      };

      final res = await api.kasbon
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
