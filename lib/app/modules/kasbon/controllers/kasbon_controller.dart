import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/kasbon.dart';
import 'package:qrm_dev/app/data/models/sisa_kasbon.dart';
import 'package:qrm_dev/app/data/models/user.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';
import 'package:qrm_dev/app/modules/kasbon/views/kasbon_detail_view.dart';

class KasbonController extends GetxController with Apis {
  RxString searchQuery = "".obs;
  var selectedIndex = (-1).obs;
  RxBool isLoading = true.obs;
  List<Kasbon> listKs = [];
  RxList<Kasbon> rxKs = <Kasbon>[].obs;
  int page = 1, total = 0;
  Rxn<SisaKasbon> sisaKasbon = Rxn<SisaKasbon>();
  final forms = LzForm.make([
    'keterangan',
    'jml',
    'tgl_kasbon',
    'tgl_terima',
    'status',
    'status_gm',
    'status_dir_keuangan',
    'status_dirut',
  ]);
  Rxn<User> user = Rxn<User>();

  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  RxMap<String, List<Kasbon>> groupedKasbon = <String, List<Kasbon>>{}.obs;

  Future getUserLogged() async {
    try {
      isLoading.value = true;

      final auth = await Auth.user();
      final res = await api.user.getData(auth.id!);
      user.value = User.fromJson(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future onPageInit() async {
    try {
      await getUserLogged();
      await getDataSisa();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future getDataSisa() async {
    final auth = await Auth.user();

    try {
      final res = await api.sisaKasbon.getData(auth.id!);
      logg('🔹 Response SisaKasbon: ${res.data}');
      sisaKasbon.value = SisaKasbon.fromJson(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future getData() async {
    try {
      page = 1;

      isLoading.value = true;
      final auth = await Auth.user();
      final res = await api.kasbon.getDataKasbon(auth.id!);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listKs = Kasbon.fromJsonList(res.data);
      rxKs.value = listKs;

      groupKasbon();
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Rxn<Kasbon> selectedKasbon = Rxn<Kasbon>();
  void onTapKeterangan(Kasbon kasbon) {
    selectedKasbon.value = kasbon;
    Get.to(() => KasbonDetailView(data: kasbon));
  }

  void groupKasbon() {
    final Map<String, List<Kasbon>> data = {};
    for (final k in listKs) {
      final date = k.tglKasbon ?? '-';
      if (!data.containsKey(date)) {
        data[date] = [];
      }
      data[date]!.add(k);
    }
    groupedKasbon.value = data;
  }

  void insertData(Kasbon data) {
    listKs.insert(0, data);
    groupKasbon();
    isLoading.refresh();
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
    getData();
    getUserLogged();
    groupKasbon();
    getDataSisa();
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listKs.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;

      final auth = await Auth.user();

      final res = await api.kasbon.getDataKasbon(
        auth.id!,
        {'page': page, 'per_page': 10},
      );

      final data = Kasbon.fromJsonList(res.data);
      listKs.addAll(data);
      rxKs.value = listKs;

      groupKasbon();
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
