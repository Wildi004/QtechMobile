import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/saldo.dart';
import 'package:qrm_dev/app/data/models/saldo_ptj.dart';

class SaldoLegalController extends GetxController with Apis {
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;

  RxBool isLoading = true.obs;
  var isExpanded = false.obs;

  List<Saldo> listSaldo = [];
  RxList<Saldo> saldo = <Saldo>[].obs;
  Rxn<SaldoPtj> saldoPtj = Rxn<SaldoPtj>();

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final id = Get.parameters['id'];

  RxBool isPaginate = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
    getSaldoPtj();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  Future<void> onPageInit() async {
    try {
      await getData();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future getSaldoPtj() async {
    try {
      final res = await api.saldo.getDataSaldoPtjlegal();
      saldoPtj.value = SaldoPtj.fromJson(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future<void> getData() async {
    try {
      page = 1;
      isLoading.value = true;

      final res = await api.saldo.getDataSaldoLegal(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      final dataList = Saldo.fromJsonList(res.data);
      // sortByTanggal(dataList);

      listSaldo = dataList;
      saldo.value = List.from(listSaldo);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  RxBool isSearching = false.obs;
  RxBool isPaginateSearch = false.obs;
  String keyword = '';
  TextEditingController searchC = TextEditingController();

  Future updateSearchQuery(String value) async {
    try {
      page = 1;
      isLoading.value = true;
      final res =
          await api.saldo.getDataSaldoLegal({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listSaldo = Saldo.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void insertData(Saldo data) {
    listSaldo.insert(0, data);
    // sortByTanggal(listSaldo);
    saldo.value = List.from(listSaldo);
  }

  void updateData(Saldo data, int id) {
    try {
      int index = listSaldo.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listSaldo[index] = data;
        // sortByTanggal(listSaldo);
        saldo.value = List.from(listSaldo);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future<void> onPaginate() async {
    try {
      if (listSaldo.length >= total || isPaginate.value) return;

      page++;
      isPaginate.value = true;

      final res =
          await api.saldo.getDataSaldoLegal({...query, 'search': searchC.text});
      final newData = Saldo.fromJsonList(res.data);

      listSaldo.addAll(newData);
      // sortByTanggal(listSaldo);

      saldo.value = List.from(listSaldo);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      Utils.timer(() {
        isPaginate.value = false;
        isLoading.refresh();
      }, 1.s);
    }
  }

  Future<void> onSubmit() async {
    try {
      // tambahkan fungsi simpan jika dibutuhkan
    } catch (e, s) {
      Toast.dismiss();
      Errors.check(e, s);
    }
  }
}
