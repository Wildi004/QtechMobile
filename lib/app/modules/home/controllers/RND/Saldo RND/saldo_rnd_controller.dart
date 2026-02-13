import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20rnd/saldo_rnd.dart';
import 'package:qrm_dev/app/data/models/saldo_ptj.dart';

class SaldoRndController extends GetxController with Apis {
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;
  final forms = LzForm.make([
    'id',
    'head_trans',
    'sub_trans',
    'keterangan',
    'tgl_terima',
    'debit',
    'kredit',
    'saldo',
    'dep_id',
    'pengirim',
    'created_at',
    'user_name',
    'dep',
  ]);

  RxBool isLoading = true.obs;
  var isExpanded = false.obs;

  List<SaldoRnd> listSaldo = [];
  RxList<SaldoRnd> saldo = <SaldoRnd>[].obs;
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
      final res = await api.saldoRnd.getDataMax();
      saldoPtj.value = SaldoPtj.fromJson(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future<void> getData() async {
    try {
      page = 1;
      isLoading.value = true;

      final res = await api.saldoRnd.getData(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      final dataList = SaldoRnd.fromJsonList(res.data);
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
      final res = await api.saldoRnd.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listSaldo = SaldoRnd.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void insertData(SaldoRnd data) {
    listSaldo.insert(0, data);
    // sortByTanggal(listSaldo);
    saldo.value = List.from(listSaldo);
  }

  void updateData(SaldoRnd data, int id) {
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
          await api.saldoRnd.getData({...query, 'search': searchC.text});
      final newData = SaldoRnd.fromJsonList(res.data);

      listSaldo.addAll(newData);

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

  String formatRp(dynamic value) {
    if (value == null) return 'Rp 0';

    final number = num.tryParse(value.toString()) ?? 0;

    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return formatter.format(number);
  }

  Future<void> onSubmit() async {
    try {} catch (e, s) {
      Toast.dismiss();
      Errors.check(e, s);
    }
  }
}
