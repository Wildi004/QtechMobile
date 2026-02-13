import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/validasi_alat/validasi_alat.dart';

class ValidasiAlatBelumValController extends GetxController with Apis {
  ValidasiAlat? data;
  final isFilled = false.obs;
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;
  final forms = LzForm.make([]);
  RxBool isLoading = true.obs;
  var isExpanded = false.obs;
  RxList<FormManager> formRabs = RxList([]);

  List<ValidasiAlat> listData = [];
  RxList<ValidasiAlat> datas = <ValidasiAlat>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final id = Get.parameters['id'];

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.validasiAlat.getBelumVal(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listData = ValidasiAlat.fromJsonList(res.data);

      datas.value = listData;
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
          await api.validasiAlat.getBelumVal({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = ValidasiAlat.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void updateData(ValidasiAlat data, String id) {
    try {
      final controller = Get.find<ValidasiAlatBelumValController>();
      int index = controller.datas.indexWhere((e) => e.id == data.id);

      logg('--- index: $index');

      if (index != -1) {
        controller.datas[index] = data;
        controller.isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  // Future deleteData(String noHide) async {
  //   try {
  //     final res = await api.validasiAlat.deleteData(noHide).ui.loading('Menghapus...');
  //     if (!res.status) {
  //       return Toast.error(res.message);
  //     }
  //     listData.removeWhere((e) => e.noHide == noHide);
  //     isLoading.refresh();
  //     Get.snackbar('Berhasil', res.message ?? '');
  //   } catch (e, s) {
  //     Errors.check(e, s);
  //   }
  // }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listData.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.validasiAlat
          .getBelumVal({...query, 'search': searchC.text});
      final data = ValidasiAlat.fromJsonList(res.data);
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
