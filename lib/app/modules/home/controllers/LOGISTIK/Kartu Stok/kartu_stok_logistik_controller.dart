import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/kartu_stok.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/kartu_stok_str.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/delivery%20po%20non%20ppn/del_po_non_detail_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/delivery%20po%20ppn/del_po_ppn_detail_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/surat%20jalan%20logistik/surat%20jalan%20internal/surat_jalan_internal_detail_view.dart';

class KartuStokLogistikController extends GetxController with Apis {
  final forms = LzForm.make([
    'id',
    'nama',
    'tgl_upload',
    'keterangan',
    'image',
    'created_at',
    'kode_material',
    'user_name'
  ]);

  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;
  final formDetails = <FormManager>[].obs;

  List<KartuStok> listData = [];
  RxList<KartuStok> data = <KartuStok>[].obs;
  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  RxList<KartuStokStr> detailDatas = <KartuStokStr>[].obs;

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.kartuStok.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = KartuStok.fromJsonList(res.data);
      data.value = listData;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  RxBool isDetailLoading = false.obs;

  Future getDetail(String kodeStr) async {
    try {
      isDetailLoading.value = true;
      detailDatas.clear();

      final res = await api.kartuStok.getDataDetail(kodeStr);
      final body = res.body;

      if (body is Map && body['data'] is List) {
        logg("MASUK KE LIST DATA, length: ${body['data'].length}");
        detailDatas.value = (body['data'] as List)
            .map((e) => KartuStokStr.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } else if (body is List) {
        logg("MASUK KE LIST ROOT, length: ${body.length}");
        detailDatas.value = body
            .map((e) => KartuStokStr.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } else {
        logg("RESPON TIDAK SESUAI");
        detailDatas.clear();
      }

      logg("DETAIL DATAS LENGTH ===> ${detailDatas.length}");
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isDetailLoading.value = false;
    }
  }

  void openDetailByNoHide(KartuStokStr u) {
    final label = getLabel(u);
    String? noHide;

    if (label == "Delivery Material PO PPN") {
      noHide = u.noDelpo;
    } else if (label == "Delivery Material PO Non PPN") {
      noHide = u.noDelpoNon;
    } else if (label == "Delivery Material Pembelian PPN") {
      noHide = u.noBeli;
    } else if (label == "Delivery Material Pembelian Non PPN") {
      noHide = u.noBeliNon;
    } else if (label == "Surat Jalan Internal") {
      noHide = u.noInt;
    } else if (label == "Surat Jalan Eksternal PPN") {
      noHide = u.noEks;
    } else if (label == "Surat Jalan Eksternal Non PPN") {
      noHide = u.noEksNon;
    } else if (label == "Retur") {
      noHide = u.noretur;
    }

    logg("🟢 openDetailByNoHide dipanggil | label: $label | noHide: $noHide");

    if (noHide == null || noHide == "#" || noHide.isEmpty) {
      Toast.warning("Data detail tidak ditemukan untuk $label");
      return;
    }

    // 🔹 tambahkan kondisi ini:
    if (label == "Surat Jalan Internal") {
      Get.to(() => SuratJalanInternalDetailView(),
          arguments: {'noInt': noHide});
    } else if (label == "Delivery Material PO PPN") {
      Get.to(() => const DelPoPpnDetailView(), arguments: {'no_hide': noHide});
    } else if (label == "Delivery Material PO Non PPN") {
      Get.to(() => DelPoNonDetailView(noDelpoNon: noHide));
    } else {
      Toast.warning("Belum ada halaman detail untuk label ini: $label");
    }
  }

  String? getLabel(KartuStokStr u) {
    if (u.noSjInt != "#" && u.noSjInt != null) {
      return "Surat Jalan Internal";
    } else if (u.noPoNon != "#" && u.noPoNon != null) {
      return "Delivery Material PO Non PPN";
    } else if (u.noPembelian != "#" && u.noPembelian != null) {
      return "Delivery Material Pembelian PPN";
    } else if (u.noPembelianNon != "#" && u.noPembelianNon != null) {
      return "Delivery Material Pembelian Non PPN";
    } else if (u.noRetur != "#" && u.noRetur != null) {
      return "Retur";
    } else if (u.noPo != "#" && u.noPo != null) {
      return "Delivery Material PO PPN";
    } else if (u.noSjEks != "#" && u.noSjEks != null) {
      return "Surat Jalan Eksternal PPN";
    } else if (u.noSjEksNon != "#" && u.noSjEksNon != null) {
      return "Surat Jalan Eksternal Non PPN";
    }
    return null;
  }

  String? getNoBukti(KartuStokStr u) {
    if (u.noSjInt != "#" && u.noSjInt != null) {
      return u.noSjInt;
    } else if (u.noPoNon != "#" && u.noPoNon != null) {
      return u.noPoNon;
    } else if (u.noPembelian != "#" && u.noPembelian != null) {
      return u.noPembelian;
    } else if (u.noPembelianNon != "#" && u.noPembelianNon != null) {
      return u.noPembelianNon;
    } else if (u.noRetur != "#" && u.noRetur != null) {
      return u.noRetur;
    } else if (u.noPo != "#" && u.noPo != null) {
      return u.noPo;
    } else if (u.noSjEks != "#" && u.noSjEks != null) {
      return u.noSjEks;
    } else if (u.noSjEksNon != "#" && u.noSjEksNon != null) {
      return u.noSjEksNon;
    }
    return null;
  }

  Future deleteData(int id) async {
    try {
      final res = await api.kartuStok.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listData.removeWhere((e) => e.id == id);
      isLoading.refresh();
      Get.snackbar('Berhasil', res.message ?? '');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void insertData(KartuStok data) {
    listData.insert(0, data);
    isLoading.refresh();
  }

  RxBool isSearching = false.obs;
  RxBool isPaginateSearch = false.obs;
  String keyword = '';
  TextEditingController searchC = TextEditingController();

  Future updateSearchQuery(String value) async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.kartuStok.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = KartuStok.fromJsonList(res.data);
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
      if (listData.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res =
          await api.kartuStok.getData({...query, 'search': searchC.text});
      final data = KartuStok.fromJsonList(res.data);
      listData.addAll(data);
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
//  void navigateToDetail(KartuStokStr u) {
//     // Surat Jalan Internal
//     if (u.noSjInt != "#" && u.noSjInt != null) {
//       // Get.to(() => SuratJalanInternalDetailView(noInt: u.noInt));
//     }
//     // Delivery Material PO Non PPN
//     else if (u.noPoNon != "#" && u.noPoNon != null) {
//       Get.to(() => DelPoNonDetailView(noDelpoNon: u.noDelpoNon));
//     }
//     // Delivery Material Pembelian PPN
//     else if (u.noPembelian != "#" && u.noPembelian != null) {
//       // Get.to(() => DetailDeliveryPembelianView(noBeli: u.noBeli));
//     }
//     // Delivery Material Pembelian Non PPN
//     else if (u.noPembelianNon != "#" && u.noPembelianNon != null) {
//       // Get.to(() => DetailDeliveryPembelianNonView(noBeliNon: u.noBeliNon));
//     }
//     // Retur
//     else if (u.noRetur != "#" && u.noRetur != null) {
//       // Get.to(() => DetailReturView(noRetur: u.noretur));
//     }
//     // Delivery Material PO PPN
//     else if (u.noPo != "#" && u.noPo != null) {
//       Get.to(() => DelPoPpnDetailView(noDelpo: u.noDelpo));
//     }
//     // Surat Jalan Eksternal PPN
//     else if (u.noSjEks != "#" && u.noSjEks != null) {
//       // Get.to(() => DetailSjEksView(noEks: u.noEks));
//     }
//     // Surat Jalan Eksternal Non PPN
//     else if (u.noSjEksNon != "#" && u.noSjEksNon != null) {
//       // Get.to(() => DetailSjEksNonView(noEksNon: u.noEksNon));
//     }
//     // Jika tidak ada kondisi yang cocok
//     else {
//       Toast.warning("Tidak ada halaman detail yang cocok untuk data ini");
//     }
//   }
