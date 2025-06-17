import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/notulen/views/notulen_all_view.dart';

import '../controllers/notulen_controller.dart';

class NotulenView extends GetView<NotulenController> {
  const NotulenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notulen",
          style: TextStyle(color: Colors.white, fontWeight: Fw.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 91, 122),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // Tombol Buat Notulen

            const SizedBox(height: 20),

            // Tab View
            Obx(() {
              int active = controller.tabIndex.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: LzTabView(
                      tabs: const [
                        'Semua',
                        'Umum',
                        'Penting',
                        'Rahasia',
                      ],
                      onTap: (key, i) {
                        controller.tabIndex.value = i;
                      },
                      builder: (label, i) {
                        bool isActive = active == i;
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color.fromARGB(255, 173, 155, 38)
                                : const Color.fromARGB(255, 243, 238, 238),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black),
                          ),
                          margin: EdgeInsets.only(left: i == 0 ? 0 : 8),
                          child: Text(
                            label,
                            style: TextStyle(
                              color: isActive ? Colors.white : Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(height: 10),

            // List Notulen dengan Expanded agar tidak overflow
            Expanded(
              child: Obx(() {
                if (controller.tabIndex.value == 0) {
                  return NotulenAllView();
                } else if (controller.tabIndex.value == 1) {
                  return Center(child: Text("Tab Umum"));
                }
                return const SizedBox();
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// class AbsensiView extends GetView<AbsenController> {
//   const AbsensiView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut(() => AbsenController());
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Jam Dan Lokasi",
//           style: TextStyle(color: Colors.white, fontWeight: Fw.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 6, 91, 122),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           children: [
//             // Tombol Buat Notulen

//             const SizedBox(height: 20),

//             // Tab View
//             Obx(() {
//               int active = controller.tabIndex.value;
//               return Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: LzTabView(
//                       tabs: const [
//                         'Jam dan lokasi',
//                         'Laporan absensi',
//                         'Libur nasional',
//                       ],
//                       onTap: (key, i) {
//                         controller.tabIndex.value = i;
//                       },
//                       builder: (label, i) {
//                         bool isActive = active == i;
//                         return Container(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 8, horizontal: 16),
//                           decoration: BoxDecoration(
//                             color: isActive
//                                 ? const Color.fromARGB(255, 173, 155, 38)
//                                 : const Color.fromARGB(255, 243, 238, 238),
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: Colors.black),
//                           ),
//                           margin: EdgeInsets.only(left: i == 0 ? 0 : 8),
//                           child: Text(
//                             label,
//                             style: TextStyle(
//                               color: isActive ? Colors.white : Colors.black,
//                               fontSize:
//                                   MediaQuery.of(context).size.width * 0.04,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               );
//             }),

//             const SizedBox(height: 10),

//             // List Notulen dengan Expanded agar tidak overflow
//             Expanded(
//               child: Obx(() {
//                 if (controller.tabIndex.value == 0) {
//                   return JamLokasiView();
//                 } else if (controller.tabIndex.value == 2) {
//                   return LiburNasionalView();
//                 } else if (controller.tabIndex.value == 1) {
//                   return LaporanAbsensiView();
//                 }
//                 return const SizedBox();
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
