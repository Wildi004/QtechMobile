import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/notulen/notulen.dart';

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
      page = 1;
      isLoading.value = true;
      final res = await api.notulen.getNotulen(query);

      // set total untuk paginasi
      total = res.body?['pagination']?['total_records'] ?? 0;
      listNotulen = Notulen.fromJsonList(res.data);
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

//  Future getDatanot()async{
//   try{
//     Toast.overlay('Loading...');
//     final auth = await Auth.user();
//     final res = await api.notulen.getDatanot(auth.id!);
//     not.value = Notulen.fromJson(res.data);

//   }
//  }

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
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lazyui/lazyui.dart';
// import 'package:qrm/app/modules/home/controllers/hrd_absen_controller/absen_controller.dart';
// import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/absensi/jam_lokasi/detail_jamlokasi_view.dart';
// import 'package:qrm/app/modules/notulen/views/form_notulen_view.dart';

// class JamLokasiView extends GetView<AbsenController> {
//   const JamLokasiView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final itemWidth = MediaQuery.of(context).size.width - 30;

//     return Obx(() {
//       bool isLoading = controller.isLoading.value;
//       final data = controller.buldList;

//       if (isLoading) {
//         return Center(child: LzLoader.bar());
//       }

//       if (data.isEmpty) {
//         return Empty(
//           message: 'Tidak ada data apa pun.',
//           onTap: () => controller.getBuilding(),
//         );
//       }

//       return LzListView(
//         padding: Ei.sym(v: 20),
//         onRefresh: () => controller.getBuilding(),
//         children: [

//           Row(
//             children: [
//               TextField(
//                   onChanged: controller.updateSearchQuery,
//                   decoration: InputDecoration(
//                     hintText: "Cari...",
//                     prefixIcon: Icon(Icons.search),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     contentPadding: EdgeInsets.symmetric(vertical: 10),
//                   ),
//                 ),

//               SizedBox(width: 10),
//               LzButton(
//                 icon: Hi.addSquare,
//                 onTap: () {
//                   Get.to(() => FormNotulenView());
//                 },
//               ),
//             ],
//           ),
//           SizedBox(height: 20),

//           ...data.generate((item, i) {
//             return Touch(
//               onTap: () {
//                 Get.to(() => DetailJamlokasiView(
//                       name: item.building?.name ?? '',
//                       address: item.building?.address ?? '',
//                       time_in: item.shift?.timeIn ?? '',
//                       time_out: item.shift?.timeOut ?? '',
//                       radius: item.building?.radius.toString(),
//                     ));
//               },
//               margin: Ei.only(b: 10),
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.08,
//                 width: itemWidth,
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       const Color.fromARGB(255, 54, 145, 220),
//                       const Color.fromARGB(255, 73, 173, 255),
//                       const Color.fromARGB(255, 14, 63, 210)
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         item.building?.name ?? 'tidak ada',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           padding: EdgeInsets.zero,
//                           onPressed: () {
//                             // Get.to(() => FormNotulenView(data: item))
//                             //     ?.then((value) {
//                             //   if (value != null) {
//                             //     controller.updateData(
//                             //         Notulen.fromJson(value), item.id!);
//                             //   }
//                             // });
//                           },
//                           icon: Icon(Hi.edit01, color: Colors.white),
//                         ),
//                         IconButton(
//                           padding: EdgeInsets.zero,
//                           onPressed: () {
//                             Get.defaultDialog(
//                               title: 'Konfirmasi',
//                               titleStyle: TextStyle(fontWeight: Fw.bold),
//                               middleText:
//                                   'Apakah Anda yakin ingin menghapus data ini?',
//                               middleTextStyle: TextStyle(
//                                 fontSize:
//                                     MediaQuery.of(context).size.height * 0.018,
//                               ),
//                               textConfirm: 'Ya',
//                               buttonColor: Colors.blue,
//                               textCancel: 'Batal',
//                               confirmTextColor: Colors.white,
//                               onConfirm: () {
//                                 // Get.back();
//                                 // controller.delete(item.id!);
//                               },
//                             );
//                           },
//                           icon: Icon(Hi.delete02, color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }),
//         ],
//       );
//     });
//   }
// }
