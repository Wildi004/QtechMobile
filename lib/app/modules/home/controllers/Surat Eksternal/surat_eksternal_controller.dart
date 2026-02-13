import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/surat%20eksternal/surat_eksternal.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';

class SuratEksternalController extends GetxController with Apis {
  final forms = LzForm.make([
    'id',
    'no_surat',
    'tgl',
    'keperluan',
    'created_by',
    'created_at',
    'user_name',
  ]);

  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;

  List<SuratEksternal> listSurat = [];
  RxList<SuratEksternal> surat = <SuratEksternal>[].obs;
  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  String? token;
  void setToken() {
    token = storage.read('token');
  }

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.suratEksternal.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listSurat = SuratEksternal.fromJsonList(res.data);
      surat.value = listSurat;
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
      final res = await api.suratEksternal.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listSurat = SuratEksternal.fromJsonList(res.data);
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

  void insertData(SuratEksternal data) {
    listSurat.insert(0, data);
    isLoading.refresh();
  }

  void updateData(SuratEksternal data, int id) {
    int index = listSurat.indexWhere((e) => e.id == id);
    if (index >= 0) {
      listSurat[index] = data;
      isLoading.refresh();
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listSurat.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res =
          await api.suratEksternal.getData({...query, 'search': searchC.text});
      final data = SuratEksternal.fromJsonList(res.data);
      listSurat.addAll(data);
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
