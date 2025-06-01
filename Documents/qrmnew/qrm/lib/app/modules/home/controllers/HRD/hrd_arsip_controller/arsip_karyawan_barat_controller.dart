import 'package:get/get.dart' hide Bindings;
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/arsip_karyawan_hrd/arsip_karyawan_hrd.dart';

class ArsipKaryawanBaratController extends GetxController with Apis {
  var dataKaryawan = [].obs;
  var isLoading = true.obs;
  RxString searchQuery = "".obs;

  List<ArsipKaryawanHrd> listAK = [];
  RxList<ArsipKaryawanHrd> rxAK = <ArsipKaryawanHrd>[].obs;

  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  int page = 1, total = 0;

  Future getArsip() async {
    try {
      page = 1;
      isLoading.value = true;

      final res = await api.arsipKaryawanHrd.getDataBarat(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listAK = ArsipKaryawanHrd.fromJsonList(res.data);
      rxAK.value = listAK;
      logg('ini data daftar $res');
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    rxAK.value = listAK
        .where((data) =>
            data.name?.toLowerCase().contains(searchQuery.value) ?? false)
        .toList();
  }

  Future onPageInit() async {
    try {
      await getArsip();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    Bindings.onRendered(() {
      getArsip();
      // getArsipTimur();
    });
    super.onInit();
  }

  void insertData(ArsipKaryawanHrd data) {
    listAK.insert(0, data);
    isLoading.refresh();
  }

  void updateData(ArsipKaryawanHrd data, int id) {
    try {
      int index = listAK.indexWhere((e) => e.userId == id);
      if (index >= 0) {
        listAK[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listAK.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.arsipKaryawanHrd.getDataBarat(query);

      final data = ArsipKaryawanHrd.fromJsonList(res.data);
      listAK.addAll(data);
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
