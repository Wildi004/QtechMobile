import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/kasbon_dep_bsd/kasbon_dep_bsd.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Kasbon%20Dev%20Bsd/kasbon_dep_bsd_belum_controller.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class KasbonDepBsdController extends GetxController with Apis {
  KasbonDepBsd? data;
  final isFilled = false.obs;
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;
  final forms = LzForm.make([]);
  RxBool isLoading = true.obs;
  var isExpanded = false.obs;
  RxList<FormManager> formRabs = RxList([]);

  List<KasbonDepBsd> listPengajuan = [];
  RxList<KasbonDepBsd> pengajuan = <KasbonDepBsd>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final id = Get.parameters['id'];

  Future getData() async {
    try {
      ListItemAnimasi.animatedItems.clear();

      page = 1;
      isLoading.value = true;
      final res = await api.kasbonDepBsd.getDataSudahVal(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listPengajuan = KasbonDepBsd.fromJsonList(res.data);

      pengajuan.value = listPengajuan;
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
          await api.kasbonDepBsd.getDataSudahVal({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listPengajuan = KasbonDepBsd.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  // PengajuanDepBsd details = PengajuanDepBsd();
  // RxList<DetailPengajuanIt> cards = RxList([]);

  // Future getDetails(PengajuanDepBsd data) async {
  //   try {
  //     String nohide = data.noHide ?? '';
  //     final res = await api.pengajuanGlobal.getDataItByNoHide(nohide);
  //     details = PengajuanDepBsd.fromJson(res.data ?? {});
  //     cards.value = details.detail ?? [];
  //   } catch (e, s) {
  //     Errors.check(e, s);
  //   }
  // }

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

    ever(tab, (value) {
      if (value == 1) {
        getData();
      }
    });

    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void insertData(KasbonDepBsd data) {
    try {
      final controller = Get.find<KasbonDepBsdBelumController>();
      controller.pengajuan.insert(0, data);
      controller.isLoading.refresh();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listPengajuan.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.kasbonDepBsd
          .getDataSudahVal({...query, 'search': searchC.text});
      final data = KasbonDepBsd.fromJsonList(res.data);
      listPengajuan.addAll(data);
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
