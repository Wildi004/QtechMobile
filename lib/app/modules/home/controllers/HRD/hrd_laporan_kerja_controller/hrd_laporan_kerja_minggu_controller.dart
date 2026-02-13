import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20it/laporan_it_mingguan.dart';

class HrdLaporanKerjaMingguController extends GetxController with Apis {
  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;

  RxList<LaporanItMingguan> detailList = <LaporanItMingguan>[].obs;
  List<LaporanItMingguan> listRk = [];
  int limit = 20;
  int page = 1, total = 0;
  String? encryptedMinggu;
  Map<String, dynamic> get query => {'page': page, 'per_page': 20};

  Future loadDetail(String encryptedMinggu) async {
    try {
      this.encryptedMinggu = encryptedMinggu;
      isLoading.value = true;
      page = 1;
      final res = await api.rk.getDetail(encryptedMinggu, query);
      final rawList = res.data as List<dynamic>;
      final items = LaporanItMingguan.fromJsonList(rawList);
      listRk = items;
      detailList.value = items;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();

    if (query.isEmpty) {
      detailList.value = List.from(listRk);
      return;
    }

    detailList.value = listRk
        .where((data) =>
            data.userName?.toLowerCase().contains(searchQuery.value) ?? false)
        .toList();
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (detailList.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      if (encryptedMinggu == null) {
        throw Exception("encryptedMinggu belum di-set");
      }
      final res = await api.rk.getDetail(encryptedMinggu!, query);
      final data = LaporanItMingguan.fromJsonList(res.data);
      listRk.addAll(data);
      detailList.addAll(data);
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
