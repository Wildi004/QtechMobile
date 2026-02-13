import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/company_profile.dart';
import 'package:qrm_dev/app/modules/company_profile/controllers/profile%20perusahaan%20controller/profile_perusahaan_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/aset_kantor_controller/image_token_aset.dart';

class IconPerusahaanController extends GetxController with Apis {
  final forms = LzForm.make(['icon']);
  late ImageFileTokenController imageC;
  RxBool isLoading = true.obs;
  Rxn<CompanyProfile> data = Rxn<CompanyProfile>();
  File? file;
  RxString fileName = ''.obs;
  late int id;

  @override
  void onInit() {
    super.onInit();
    imageC = Get.put(ImageFileTokenController());

    id = Get.arguments ?? 0;
    getData(id);
  }

  Future getData(int id) async {
    try {
      isLoading.value = true;
      final res = await api.companyProfile.getDataId(id);
      final result = CompanyProfile.fromJson(res.data);
      data.value = result;
      forms.fill(result.toJson());
      if (result.icon != null && result.icon!.isNotEmpty) {
        await imageC.loadImage(result.icon!);
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future onSubmit() async {
    try {
      final form = forms.validate(required: ['icon']);
      if (!form.ok) return;

      final payload = form.value;
if (file == null) {
      payload.remove('icon');
    } else {
      payload['icon'] = await api.toFile(file!.path);
    }
      final res = await api.companyProfile
          .updateData(payload, id)
          .ui
          .loading('Memperbarui...');

      if (res.status == true) {
        Get.back(result: res.data);
        showSuccess(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
