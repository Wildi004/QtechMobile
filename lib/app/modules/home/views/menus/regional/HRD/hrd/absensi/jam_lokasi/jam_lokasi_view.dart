// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lazyui/lazyui.dart';
// import 'package:qrm_dev/app/data/models/shift_building/shift_building.dart';
// import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_absen_controller/absen_controller.dart';
// import 'package:qrm_dev/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/absensi/jam_lokasi/create_jam_lokasi_view.dart';
// import 'package:qrm_dev/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/absensi/jam_lokasi/detail_jamlokasi_view.dart';
// import 'package:qrm_dev/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/absensi/jam_lokasi/edit_jamlokasi_view.dart';

// class JamLokasiView extends GetView<AbsenController> {
//   const JamLokasiView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final itemWidth = MediaQuery.of(context).size.width - 30;

//     return Obx(() {
//       bool isLoading = controller.isLoading.value;
//       final data = controller.buildr;

//       if (isLoading) {
//         return Center(child:  CustomLoading()
// );
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
//               Expanded(
//                 child: TextField(
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
//               ),
//               SizedBox(width: 10),
//               LzButton(
//                 icon: Hi.addSquare,
//                 onTap: () {
//                   Get.to(() => CreateJamLokasiView());
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
//                       timein: item.shift?.timeIn ?? '',
//                       timeout: item.shift?.timeOut ?? '',
//                       radius: item.building?.radius.toString(),
//                       latitudelongtitude:
//                           item.building?.latitudeLongtitude ?? '',
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
//                             Get.to(() => EditJamlokasiView(data: item))
//                                 ?.then((value) {
//                               if (value != null) {
//                                 controller.updateData(
//                                     ShiftBuilding.fromJson(value), item.id!);
//                               }
//                             });
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
//                                 Get.back();
//                                 controller.delete(item.id!);
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

//           // animasi loading paginasi
//         ],
//       );
//     });
//   }
// }
