import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/buku_bank.dart';
import 'package:qrm_dev/app/data/models/user.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class BukuBankController extends GetxController with Apis {
  Rxn<User> user = Rxn<User>();
  int page = 1, total = 0;
  RxBool isloading = true.obs;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  List<BukuBank> buku = [];
  RxList<BukuBank> rxBuku = <BukuBank>[].obs;
  RxList<BukuBankGroup> grouped = <BukuBankGroup>[].obs;
  RxSet<String> expandedKeys = <String>{}.obs;

  Future getData() async {
    try {
      page = 1;
      isloading.value = true;
      final res = await api.bukuBank.getData(query);
      total = res.body?['pagination']?['total_records'] ?? 0;
      buku = BukuBank.fromJsonList(res.data);
      rxBuku.value = buku;
      groupByYearMonth(); // ⬅️ PENTING
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isloading.value = false;
    }
  }

  Future getUserLogged() async {
    try {
      final auth = await Auth.user();
      final res = await api.user.getData(auth.id!);
      user.value = User.fromJson(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (buku.length >= total || isPaginate.value) return;

      page++;
      isPaginate.value = true;

      final res = await api.bukuBank.getData(query);
      final data = BukuBank.fromJsonList(res.data);

      buku.addAll(data);
      rxBuku.value = buku; // ✅ WAJIB
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isPaginate.value = false;
    }
  }

  void groupByYearMonth() {
    final Map<String, List<BukuBank>> map = {};

    for (var item in rxBuku) {
      final date = DateTime.parse(item.tglJurnal!);
      final key = '${date.year}-${date.month.toString().padLeft(2, '0')}';

      map.putIfAbsent(key, () => []);
      map[key]!.add(item);
    }

    grouped.value = map.entries.map((e) {
      final parts = e.key.split('-');
      final year = parts[0];
      final month = int.parse(parts[1]);

      return BukuBankGroup(
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
      await onPageInit();
      await getData();
    });
  }
}

class BukuBankGroup {
  final String key;
  final String label;
  final List<BukuBank> items;

  BukuBankGroup({
    required this.key,
    required this.label,
    required this.items,
  });
}
