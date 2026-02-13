import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/anggaran/anggaran.dart';

class AnggaranDepartemenController extends GetxController with Apis {
  RxBool isLoading = true.obs;
  var isExpanded = false.obs;
  List<Anggaran> listData = [];
  RxList<Anggaran> data = <Anggaran>[].obs;
  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
RxList<ChartPoint> baratChart = <ChartPoint>[].obs;
RxList<ChartPoint> pusatChart = <ChartPoint>[].obs;
RxList<ChartPoint> timurChart = <ChartPoint>[].obs;
RxList<ChartPoint> tengahChart = <ChartPoint>[].obs;

Future getData() async {
  try {
    isLoading.value = true;

    final res = await api.anggaran.getData(query);
    final body = res.body?['data'];

    // BARAT
    final barat = body?['barat']?['jakarta_year'] ?? [];
    baratChart.value = ChartPoint.fromList(barat);

    // PUSAT
    final pusat = body?['pusat']?['pusat_year'] ?? [];
    pusatChart.value = ChartPoint.fromList(pusat);

    // TIMUR
    final timur = body?['timur']?['bali_year'] ?? [];
    timurChart.value = ChartPoint.fromList(timur);

    // TENGAH
    final tengah = body?['tengah']?['tengah_year'] ?? [];
    tengahChart.value = ChartPoint.fromList(tengah);

  } catch (e, s) {
    Errors.check(e, s);
  } finally {
    isLoading.value = false;
  }
}

  @override
  void onInit() {
    super.onInit();
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }
}
class ChartPoint {
  final int year;
  final double total;

  ChartPoint({required this.year, required this.total});

  factory ChartPoint.fromJson(Map<String, dynamic> json) {
    return ChartPoint(
      year: json['year'] ?? 0,
      total: (json['total_amount'] ?? 0).toDouble(),
    );
  }

  static List<ChartPoint> fromList(List list) {
    return list.map((e) => ChartPoint.fromJson(e)).toList();
  }
}
