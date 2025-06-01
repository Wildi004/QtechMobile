import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/user.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class BukuBankController extends GetxController with Apis {
  var saldo = 10000000.obs;
  Rxn<User> user = Rxn<User>();

  var dataBonus = [
    {
      "bulan": "Februari - 2025",
      "isExpanded": true.obs,
      "items": [
        {
          "kode": "RAP QRM 110/KP-RJ",
          "tanggal": "04 Februari 2025",
          "nominal": -100000000
        },
        {
          "kode": "RAP QRM 011/KP-RJ",
          "tanggal": "04 Februari 2025",
          "nominal": 100000000
        },
        {
          "kode": "RAP QRM 012/KP-RJ",
          "tanggal": "04 Februari 2025",
          "nominal": -100000000
        },
        {
          "kode": "RAP QRM 013/KP-RJ",
          "tanggal": "04 Februari 2025",
          "nominal": 100000000
        },
      ],
    },
    {
      "bulan": "Januari - 2025",
      "isExpanded": false.obs,
      "items": [],
    },
    {
      "bulan": "Desember - 2025",
      "isExpanded": false.obs,
      "items": [],
    },
    {
      "bulan": "November - 2025",
      "isExpanded": false.obs,
      "items": [],
    },
    {
      "bulan": "Oktober - 2025",
      "isExpanded": false.obs,
      "items": [],
    },
  ].obs;
  Future getUserLogged() async {
    try {
      final auth = await Auth.user();
      final res = await api.user.getData(auth.id!);
      user.value = User.fromJson(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future onPageInit() async {
    try {
      await getUserLogged();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }
}
