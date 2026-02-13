import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/modal_logistik.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class HargaModalLogistikController extends GetxController with Apis {
  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;

  List<ModalLogistik> listHargaModal = [];
  RxList<ModalLogistik> rxHargaModal = <ModalLogistik>[].obs;
  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final forms = LzForm.make([
    'id',
    'kode_material',
    'nama',
    'tgl_input',
    'tgl_berlaku',
    'qty',
    'satuan',
    'harga_satuan',
    'harga_diskon',
    'ppn',
    'total_ppn',
    'sub_total',
    'ongkir',
    'harga_modal',
    'lokasi',
    'user_id',
    'supplier',
    'keterangan',
    'user_name',
    'supplier_name',
  ]);

  Future getLogistik() async {
    try {
      ListItemAnimasi.animatedItems.clear();

      page = 1;
      isLoading.value = true;
      final res = await api.modalLogistik.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listHargaModal = ModalLogistik.fromJsonList(res.data);
      rxHargaModal.value = listHargaModal;

      logg('data satuan logistik $listHargaModal');
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteData(int id) async {
    try {
      final res =
          await api.modalLogistik.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listHargaModal.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Get.snackbar('Berhasil', res.message ?? '');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    rxHargaModal.value = listHargaModal
        .where((logistik) =>
            logistik.kodeMaterial?.toLowerCase().contains(searchQuery.value) ??
            false)
        .toList();
  }

  Future onPageInit() async {
    try {
      await getLogistik();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getLogistik();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void insertData(ModalLogistik data) {
    listHargaModal.insert(0, data);
    isLoading.refresh();
  }

  void updateData(ModalLogistik data, int id) {
    try {
      int index = listHargaModal.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listHargaModal[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listHargaModal.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.modalLogistik.getData(query);
      final data = ModalLogistik.fromJsonList(res.data);
      listHargaModal.addAll(data);
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

// class DetailCapaian1View extends GetView<DetailCapaian1Controller> {
//   final Capaian1 data;

//   const DetailCapaian1View({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(DetailCapaian1Controller(data));

//     double percentage = (data.tercapai ?? 0) / (data.total ?? 1) * 100;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Capaian Kinerja'),
//         centerTitle: true,
//         backgroundColor: Colors.blue.shade800,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 200,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   SizedBox(
//                     width: 150,
//                     height: 150,
//                     child: CircularProgressIndicator(
//                       value: percentage / 100,
//                       strokeWidth: 12,
//                       backgroundColor: Colors.grey[300],
//                       valueColor: const AlwaysStoppedAnimation(Colors.green),
//                     ),
//                   ),
//                   Text(
//                     '${percentage.toStringAsFixed(0)}%',
//                     style: const TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'KEREN!, Tetap jaga performa kerja kamu\nKalau bisa lebih ditingkatkan lagi ya Sobat QINAR',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),

//             // Tab Dummy

//             const SizedBox(height: 20),

//             // Detail Box
//           ],
//         ),
//       ),
//     );
//   }
// }
