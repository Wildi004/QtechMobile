import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/company_profile.dart';

class ProfilePerusahaanController extends GetxController with Apis {
  final forms = LzForm.make([
    'nama_perusahaan',
    'alamat',
    'telp_kantor',
    'telp_hp',
    'email1',
    'email2',
    'fax',
    'web',
    'instagram',
    'youtube',
    'fb',
    'bank1',
    'logo',
    'rek1',
    'bank2',
    'rek2',
    'bank3',
    'rek3',
    'nama_perusahaan_jkt',
    'alamat_jkt',
    'telp_kantor_jkt',
    'telp_hp_jkt',
    'email1_jkt',
    'email2_jkt',
    'fax_jkt',
    'web_jkt',
    'instagram_jkt',
    'youtube_jkt',
    'fb_jkt',
    'bank1_jkt',
    'rek1_jkt',
    'bank2_jkt',
    'rek2_jkt',
    'bank3_jkt',
    'rek3_jkt',
  ]);

  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;
  final formDetails = <FormManager>[].obs;
  Rxn<CompanyProfile> data = Rxn<CompanyProfile>();
  RxList<CompanyProfile> rxData = <CompanyProfile>[].obs; //
  File? file;
  RxString fileName = ''.obs;
  List<CompanyProfile> listData = [];
  RxList<CompanyProfile> arsip = <CompanyProfile>[].obs;
  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData(int id) async {
    try {
      isLoading.value = true;

      final res = await api.companyProfile.getDataId(id);

      final data = CompanyProfile.fromJson(res.data);

      forms.fill(data.toJson());
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void updateData(CompanyProfile data) {
    try {
      final controller = Get.find<ProfilePerusahaanController>();
      int index = controller.rxData.indexWhere((e) => e.id == data.id);

      logg('--- index: $index');

      if (index != -1) {
        controller.rxData[index] = data;
        controller.isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void insertData(CompanyProfile data) {
    listData.insert(0, data);
    isLoading.refresh();
  }

  RxBool isSearching = false.obs;
  RxBool isPaginateSearch = false.obs;
  String keyword = '';
  TextEditingController searchC = TextEditingController();

  Future onPageInit(id) async {
    try {
      await getData(id);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  late int id;

  @override
  void onInit() {
    super.onInit();

    id = Get.arguments;
    getData(id);
  }

  Future onSubmit() async {
    final form = forms.validate(required: ['nama_perusahaan', 'image']);
    if (!form.ok) return;

    final payload = Map<String, dynamic>.from(form.value);

    if (file == null) {
      payload.remove('logo');
    } else {
      payload['logo'] = await api.toFile(file!.path);
    }

    final res = await api.companyProfile
        .updateData(payload, id)
        .ui
        .loading('Memperbarui...');

    if (res.status == true) {
      Get.back(result: res.data);
      showSuccess(res.message);
    }
  }
}

void showSuccess(String? msg) {
  Get.snackbar(
    'Berhasil',
    msg ?? 'Berhasil diproses',
    snackPosition: SnackPosition.TOP,
  );
}
