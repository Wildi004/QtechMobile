import 'package:get/get.dart' hide Bindings;

import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/company_profile.dart';

class EditProfilePerusahaanController extends GetxController with Apis {
  final forms = LzForm.make([
    'id',
    'nama_perusahaan',
    'alamat',
    'telp_kantor',
    'telp_hp',
    'email1',
    'email2',
    'fax',
    'npwp',
    'web',
    'instagram',
    'youtube',
    'fb',
    // Jakarta
    'telp_kantor_jkt',
    'alamat_jkt',
    'telp_hp_jkt',
    'email1_jkt',
    'email2_jkt',
    'fax_jkt',
    'npwp_jkt',
    'instagram_jkt',
    'fb_jkt',
    'youtube_jkt',
    // Bank Jakarta
    'bank1_jkt',
    'rek1_jkt',
    'bank2_jkt',
    'rek2_jkt',
    'bank3_jkt',
    'rek3_jkt',
    // Lainnya
    'struktur_organisasi',
    'logo',
    'icon',
    // Bank pusat
    'bank1',
    'rek1',
    'bank2',
    'rek2',
    'bank3',
    'rek3',
    // Audit
    'updated_by',
    'user_updated_by',
    'created_at',
  ]);

  CompanyProfile? details;

  Future getDetailData(int id) async {
    try {
      Bindings.onRendered(() async {
        Toast.overlay('Loading...', onCancel: () {});

        if (details == null) {
          final res = await api.companyProfile.getDataId(id);
          details = CompanyProfile.fromJson(res.data ?? {});
        }
        forms.fill(details!.toJson());
        Toast.dismiss();
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
  // Future onSubmit([int? id]) async {
  //   try {
  //     final form = forms.validate(required: ['kode_material']);
  //     if (form.ok) {
  //       final payload = form.value;
  //       payload['supplier'] = forms.extra('supplier');

  //       if (id == null) {
  //         final res = await api.modalLogistik
  //             .createData(payload)
  //             .ui
  //             .loading('Menambahkan...');
  //         if (res.status) {
  //           Get.back(result: res.data);
  //           Get.snackbar('Berhasil', res.message ?? '');
  //         }
  //       } else {
  //         final res = await api.modalLogistik
  //             .updateData(payload, id)
  //             .ui
  //             .loading('Memperbarui...');
  //         if (res.status) {
  //           Get.back(result: res.data);
  //           Get.snackbar('Berhasil', res.message ?? '');
  //         }
  //       }
  //     }
  //   } catch (e, s) {
  //     Errors.check(e, s);
  //   }
  // }
}
