import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/kasbon.dart';

class ValidasiKasbonController extends GetxController with Apis {
  Kasbon? data;
  final isFilled = false.obs;
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;
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

  RxBool isLoading = true.obs;
  var isExpanded = false.obs;
  RxList<FormManager> formRabs = RxList([]);

  List<Kasbon> listData = [];
  RxList<Kasbon> dataKasbon = <Kasbon>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final id = Get.parameters['id'];

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.kasbon.getDataSudahValidasi(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listData = Kasbon.fromJsonList(res.data);

      dataKasbon.value = listData;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onSubmit() async {
    try {} catch (e, s) {
      Toast.dismiss();
      Errors.check(e, s);
    }
  }

  RxBool isSearching = false.obs;
  RxBool isPaginateSearch = false.obs;
  String keyword = '';
  TextEditingController searchC = TextEditingController();

  Future updateSearchQuery(String value) async {
    try {
      page = 1;
      isLoading.value = true;
      final res =
          await api.kasbon.getDataSudahValidasi({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = Kasbon.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future onPageInit() async {
    try {
      await getData();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (data != null) {
      forms.fill(data!.toJson());
    }
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listData.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.kasbon.getDataSudahValidasi(query);
      final data = Kasbon.fromJsonList(res.data);
      listData.addAll(data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      Utils.timer(() {
        isPaginate.value = false;
        isLoading.refresh();
      }, 1.s);
    }
  }
}
