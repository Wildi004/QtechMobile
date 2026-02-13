import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/notulen/notulen.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class NotulenController extends GetxController with Apis {
  var tabIndex = 0.obs;
  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;

  var isExpanded = false.obs;
  List<Notulen> listNotulen = [];
  RxList<Notulen> not = <Notulen>[].obs;
  RxInt tab = 0.obs;
  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final forms = LzForm.make([
    'judul',
    'sifat',
    'tgl_rapat',
    'departemen',
    'jml_peserta',
    'isi',
  ]);

  Future getNotulen() async {
    try {
      ListItemAnimasi.animatedItems.clear();

      page = 1;
      isLoading.value = true;
      final res = await api.notulen.getNotulen(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listNotulen = Notulen.fromJsonList(res.data);
      filterNotulenByTab();
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future delete(int id) async {
    try {
      final res =
          await api.notulen.deleteNotulen(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listNotulen.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Toast.success('Data berhasil dihapus');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void insertData(Notulen data) {
    listNotulen.insert(0, data);
    isLoading.refresh();
  }

  void updateData(Notulen data, int id) {
    try {
      int index = listNotulen.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listNotulen[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    not.value = listNotulen
        .where((not) =>
            not.judul?.toLowerCase().contains(searchQuery.value) ?? false)
        .toList();
  }

  Future onPageInit() async {
    try {
      await getNotulen();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    getNotulen();
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listNotulen.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.notulen.getNotulen(query);
      final data = Notulen.fromJsonList(res.data);
      listNotulen.addAll(data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      Utils.timer(() {
        isPaginate.value = false;
        isLoading.refresh();
      }, 1.s);
    }
  }

  void filterNotulenByTab() {
    int activeTab = tabIndex.value;

    if (activeTab == 0) {
      // Semua
      not.value = listNotulen;
    } else if (activeTab == 1) {
      // Umum
      not.value = listNotulen.where((n) => n.sifat == 0).toList();
    } else if (activeTab == 2) {
      // Penting
      not.value = listNotulen.where((n) => n.sifat == 1).toList();
    } else if (activeTab == 3) {
      // Rahasia
      not.value = listNotulen.where((n) => n.sifat == 2).toList();
    }
  }
}
