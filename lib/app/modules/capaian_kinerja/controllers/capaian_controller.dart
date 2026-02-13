// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lazyui/lazyui.dart';
// import 'package:qrm_dev/app/data/apis/api.dart';
// import 'package:qrm_dev/app/data/models/capaian/capaian.dart';

// class CapaianController extends GetxController with Apis {
//   RxString searchQuery = "".obs;
//   RxBool isLoading = true.obs;
//   var isExpanded = false.obs;
//   RxInt tabIndex = 0.obs;

//   Capaian capaian = Capaian();

//   List<Capaian> listCap = [];
//   RxList<Capaian> rxCap = <Capaian>[].obs;

//   // Future getData() async {
//   //   try {
//   //     isLoading.value = true;
//   //     final res = await api.capaian.getData();

//   //     listCap = Capaian.fromJsonList(res.data);
//   //     rxCap.value = listCap;
//   //   } catch (e, s) {
//   //     Errors.check(e, s);
//   //   } finally {
//   //     isLoading.value = false;
//   //   }
//   // }

//   Future<void> getData() async {
//     try {
//       isLoading.value = true;
//       final res = await api.capaianKerja.getData();
//       capaian = Capaian.fromJson(res.data ?? {});
//     } catch (e, s) {
//       Errors.check(e, s);
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Future deletetdkn(int id) async {
//   //   try {
//   //     final res =
//   //         await api.daftarTkdn.deletetdkn(id).ui.loading('Menghapus...');
//   //     if (!res.status) {
//   //       return Toast.error(res.message);
//   //     }
//   //     listDt.removeWhere((e) => e.id == id);

//   //     isLoading.refresh();

//   //     Toast.success('Data berhasil dihapus');
//   //   } catch (e, s) {
//   //     Errors.check(e, s);
//   //   }
//   // }

//   // void updateSearchQuery(String query) {
//   //   searchQuery.value = query.toLowerCase();
//   //   rxDt.value = listDt
//   //       .where((logistik) =>
//   //           logistik.nama?.toLowerCase().contains(searchQuery.value) ?? false)
//   //       .toList();
//   // }

//   Future onPageInit() async {
//     try {
//       await getData();
//     } catch (e, s) {
//       Errors.check(e, s);
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     getData();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       onPageInit();
//     });
//   }

//   // insert data yang didapatkan ketika create data
//   // void insertData(DaftarTkdn data) {
//   //   listDt.insert(0, data);
//   //   isLoading.refresh();
//   // }

//   // void updateData(DaftarTkdn data, int id) {
//   //   try {
//   //     int index = listDt.indexWhere((e) => e.id == id);
//   //     if (index >= 0) {
//   //       listDt[index] = data;
//   //       isLoading.refresh();
//   //     }
//   //   } catch (e, s) {
//   //     Errors.check(e, s);
//   //   }
//   // }

//   // RxBool isPaginate = false.obs;

//   // Future onPaginate() async {
//   //   try {
//   //     if (listDt.length >= total || isPaginate.value) {
//   //       return;
//   //     }

//   //     page++;
//   //     isPaginate.value = true;
//   //     final res = await api.daftarTkdn.getData(query);
//   //     final data = DaftarTkdn.fromJsonList(res.data);
//   //     listDt.addAll(data);
//   //   } catch (e, s) {
//   //     Errors.check(e, s);
//   //   } finally {
//   //     Utils.timer(() {
//   //       isPaginate.value = false;
//   //       isLoading.refresh();
//   //     }, 1.s);
//   //   }
//   // }
// }
