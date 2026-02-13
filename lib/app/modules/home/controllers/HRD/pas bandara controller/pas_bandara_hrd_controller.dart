import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/pas_bandara_hrd/detail_orang.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/pas_bandara_hrd/pas_bandara_hrd.dart';

class PasBandaraHrdController extends GetxController with Apis {
  final forms = LzForm.make([
    'kode_proyek',
    'proyek_item_name',
    'no_pengajuan',
    'kode_pengajuan',
    'jenis_pas',
    'masa_berlaku',
    'tgl_pengajuan',
    'status_gm',
    'regional',
    'pm_name',
    'approved_by_name',
    'dep',
  ]);

  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;

  List<PasBandaraHrd> listPasBan = [];
  RxList<PasBandaraHrd> pasBan = <PasBandaraHrd>[].obs;
  int page = 1, total = 0;

  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  // Simpan model asli dan form masing-masing orang
  final detailOrangList = <DetailOrang>[].obs;
  final formDetails =
      <dynamic>[].obs; // dynamic supaya kompatibel dg LzForm.make

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.pasBandaraHrd.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listPasBan = PasBandaraHrd.fromJsonList(res.data);
      pasBan.value = listPasBan;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void fillFormDetails(List<DetailOrang>? orang) {
    formDetails.clear();
    detailOrangList.clear();

    if (orang != null) {
      for (var e in orang) {
        final form = LzForm.make(['nama', 'status_gm', 'komentar']);
        form.fill({
          'nama': e.nama ?? '',
          'status_gm': e.statusGm ?? '',
          'komentar': e.komentar ?? '',
        });

        formDetails.add(form);
        detailOrangList.add(e);
      }
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
      final res = await api.pasBandaraHrd.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listPasBan = PasBandaraHrd.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future onPageInit() async {
    try {
      await getData();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listPasBan.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res =
          await api.pasBandaraHrd.getData({...query, 'search': searchC.text});
      final data = PasBandaraHrd.fromJsonList(res.data);
      listPasBan.addAll(data);
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
