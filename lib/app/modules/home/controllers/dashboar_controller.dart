import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/kasbon.dart';

class DashboarController extends GetxController with Apis {
  RxBool isLoading = true.obs;

  List<Kasbon> kasbon = [];

  int page = 1;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  // Future getDataKasbon() async {
  //   isLoading.value = true;
  //   try{
  //     final auth = await Auth.user();
  //     final res = await api.kasbon.getDataKasbon(query);
  //     logg('ini data kasbon $res');
  //     kasbon = Kasbon.fromJsonList(res.data);
  //   } catch (e, s) {
  //     Errors.check(e, s);
  //   }finally {
  //     isLoading.value = false;
  //   }
  // }
  @override
  void onInit() {
    // getDataKasbon();
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  Future onPageInit() async {
    try {
      // await getDataKasbon();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
