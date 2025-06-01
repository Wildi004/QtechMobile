import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/kasbon.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class KasbonTestController extends GetxController with Apis {
  RxString searchQuery = "".obs;
  var selectedIndex = (-1).obs;
  RxBool isLoading = true.obs;
  List<Kasbon> listKs = [];
  RxList<Kasbon> rxKs = <Kasbon>[].obs;
  int page = 1;

  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getTkdn() async {
    try {
      isLoading.value = true;

      final auth = await Auth.user();

      final res = await api.kasbon.getDataKasbon(auth.id!);
      listKs = Kasbon.fromJsonList(res.data);
      logg('ini data kasbon $res');

      rxKs.value = listKs;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future deletetdkn(int id) async {
    try {
      final res =
          await api.daftarTkdn.deletetdkn(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listKs.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Toast.success('Data berhasil dihapus');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    rxKs.value = listKs
        .where((logistik) =>
            logistik.user?.toLowerCase().contains(searchQuery.value) ?? false)
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    getTkdn();
  }
}
