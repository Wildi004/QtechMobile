// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lazyui/lazyui.dart';
// import 'package:qrm/app/modules/home/controllers/dashboar_controller.dart';
// class Dashboard extends GetView<DashboarController> {
//   const Dashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut(() => DashboarController());
//     return Container(
//       color: const Color.fromARGB(255, 246, 245, 245),
//       height: 200,
//       width: 200,
//       child: Obx(() {
//         bool loading = controller.isLoading.value;
//         final data = controller.kasbon;
//         if (loading) {
//           return LzLoader.bar();
//         }

//         if (data.isEmpty) {
//           return Empty(
//               message: 'Data karyawan tidak ada.',
//               onTap: () => controller.getDataKasbon());
//         }
//         return LzListView(
//           padding: Ei.zero, // Hilangkan padding bawaan
//           onRefresh: () =>
//               controller.getDataKasbon(), // Fungsi refresh saat pull-to-refresh

//           children: [
//             // Looping data untuk menampilkan daftar user
//             ...data.generate((user, i) {
//               return Droplist(
//                 options: DropOption.of(
//                   ['Detail', 'Edit', 'Delete'], // Opsi menu dropdown
//                   icons: [
//                     Hi.informationSquare,
//                     Hi.edit01,
//                     Hi.delete02
//                   ], // Icon untuk masing-masing opsi
//                   separated: [
//                     1
//                   ], // Pisahkan opsi setelah indeks 1 (yaitu 'Edit')
//                   critical: [
//                     'delete'
//                   ], // Tandai opsi 'Delete' sebagai aksi kritis
//                 ),
//                 space: Offset(20, 20), // Jarak dropdown dari tombol pemicu
//                 builder: (key, action) {
//                   return InkTouch(
//                     key: key,
//                     onTap: () {
//                       // Ketika tombol ditekan, munculkan dropdown menu
//                     },
//                     padding: Ei.all(20), // Padding dalam item daftar
//                     border: Br.only(['t'],
//                         except:
//                             i), // Garis atas untuk memisahkan item, kecuali item pertama
//                     color: i % 2 == 0
//                         ? 'f5f5f5'.hex
//                         : Colors
//                             .white, // Background bergantian untuk setiap baris
//                     child: Row(
//                       children: [
//                         Column(
//                           children: [
//                             Text(user.tglKasbon ?? '-'), // Nama user
//                             // Text(user. ?? '-') // Nomor induk user
//                           ],
//                         ).start.lz.flexible(), // Agar teks user tetap responsif
//                         Icon(Hi
//                             .settings01) // Icon untuk menandakan ada opsi lebih lanjut
//                       ],
//                     ).between.gap(25), // Jarak antara teks dan icon settings
//                   );
//                 },
//               );
//             })
//           ],
//         );
//       }),
//     );
//   }
// }
