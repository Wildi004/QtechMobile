import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/bonus.dart';
import 'package:qrm_dev/app/data/models/user.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class BonusKaryawanController extends GetxController with Apis {
  Rxn<User> user = Rxn<User>();
  RxBool isloading = true.obs;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  int page = 1, total = 0;

  List<Bonus> buku = [];
  RxList<Bonus> rxBuku = <Bonus>[].obs;
  RxList<BonusGroup> grouped = <BonusGroup>[].obs;
  RxSet<String> expandedKeys = <String>{}.obs;

  Future getUserLogged() async {
    try {
      final auth = await Auth.user();
      final res = await api.user.getData(auth.id!);
      user.value = User.fromJson((res.data));
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future getData() async {
    try {
      page = 1;
      isloading.value = true;
      final res = await api.bonus.getData(query);
      total = res.body?['pagination']?['total_records'] ?? 0;
      buku = Bonus.fromJsonList(res.data);
      rxBuku.value = buku;
      groupByYearMonth();
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isloading.value = false;
    }
  }

  void groupByYearMonth() {
    final Map<String, List<Bonus>> map = {};

    for (var item in rxBuku) {
      final date = DateTime.parse(item.tglBonus!);
      final key = '${date.year}-${date.month.toString().padLeft(2, '0')}';

      map.putIfAbsent(key, () => []);
      map[key]!.add(item);
    }

    grouped.value = map.entries.map((e) {
      final parts = e.key.split('-');
      final year = parts[0];
      final month = int.parse(parts[1]);

      return BonusGroup(
        key: e.key,
        label: '${_monthName(month)} $year',
        items: e.value,
      );
    }).toList();
  }

  String _monthName(int m) {
    const months = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return months[m];
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (buku.length >= total || isPaginate.value) return;

      page++;
      isPaginate.value = true;

      final res = await api.bonus.getData(query);
      final data = Bonus.fromJsonList(res.data);

      buku.addAll(data);
      rxBuku.value = buku; // ✅ WAJIB
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isPaginate.value = false;
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      onPageInit();
      await getData();
    });
  }
}

class BonusGroup {
  final String key; // contoh: 2020-02
  final String label; // contoh: Februari 2020
  final List<Bonus> items;

  BonusGroup({
    required this.key,
    required this.label,
    required this.items,
  });
}
