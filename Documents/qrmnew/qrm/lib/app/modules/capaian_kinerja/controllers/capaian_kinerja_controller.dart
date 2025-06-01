import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/capaian_kinerja/capaian_kinerja.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class CapaianKinerjaController extends GetxController with Apis {
  var tabIndex = 0.obs;
  var isExpanded = false.obs;
  var selectedCategory = "Semua".obs;
  Rxn<CapaianKinerja> cap = Rxn<CapaianKinerja>();
  RxBool isLoading = true.obs;
  var cap2 = CapaianKinerja().obs;
  List<CapaianKinerja> listCP = [];

  var categories = ["Semua", "Pekerjaan", "Meeting", "Lainnya"];

  RxList<bool> isExpandeds = List.generate(7, (index) => false).obs;
  void toggleExpande(int index) {
    isExpandeds[index] = !isExpandeds[index];
  }

  var dataList = [
    {"title": "Mengikuti Kegiatan Sabtu Belajar", "date": "1 Januari 2025"},
    {"title": "Melakukan develop Menu IT", "date": "1 Januari 2025"},
    {
      "title": "Koordinasi dengan team IT Pembahasan tentang Website",
      "date": "1 Januari 2025"
    },
  ].obs;
  void togglePanel() {
    isExpanded.value = !isExpanded.value;
  }

  void setSelectedCategory(String value) {
    selectedCategory.value = value;
  }

  var dropdownStates = List.generate(4, (_) => false.obs).obs;
  void toggleDropdown(int index) {
    dropdownStates[index].value = !dropdownStates[index].value;
  }

  Future getCapaian() async {
    try {
      final auth = await Auth.user();
      final res = await api.capaianKinerja.getData({'dept_id': auth.deptId});
      logg('ini capaian kinerja $res');
      // final dataC = CapaianKinerja.fromJson(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future onPageInit() async {
    try {
      await getCapaian();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
