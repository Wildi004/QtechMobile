import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/arsip_karyawan_hrd/arsip_karyawan_hrd.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_arsip_controller/arsip_karyawan_controller.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/arsiv/arsip_karyawan/create_arsip_karyawan_view.dart';

class ArsipKaryawanSettView extends StatelessWidget {
  final ArsipKaryawanController controller = Get.put(ArsipKaryawanController());

  final ArsipKaryawanHrd? data;

  ArsipKaryawanSettView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final details = data?.detail ?? [];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          data?.name ?? 'Detail Arsip Karyawan',
          style: TextStyle(color: Colors.white, fontWeight: Fw.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: ['4CA1AF'.hex, '808080'.hex],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: details.isEmpty
          ? const Center(child: Text('Tidak ada detail'))
          : RefreshIndicator(
              onRefresh: () async {
                await controller.getArsip(); // Panggil fungsi refresh
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: details.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  controller.updateSearchQuery(value);
                                },
                                decoration: InputDecoration(
                                  hintText: "Cari...",
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            LzButton(
                              icon: Hi.addSquare,
                              onTap: () {
                                if (data != null) {
                                  Get.to(() => CreateArsipKaryawanView(
                                      userId: data!.userId))?.then((result) {
                                    if (result != null) {
                                      controller.insertData(
                                          ArsipKaryawanHrd.fromJson(result));
                                    }
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }

                  final item = details[index - 1];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 54, 145, 220),
                              Color.fromARGB(255, 73, 173, 255),
                              Color.fromARGB(255, 14, 63, 210)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.filename ?? 'No file',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                controller
                                    .openFileWithToken(item.filepath ?? '');
                              },
                              icon: Icon(Icons.remove_red_eye,
                                  color: Colors.white),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Get.defaultDialog(
                                  title: 'Konfirmasi',
                                  titleStyle: TextStyle(fontWeight: Fw.bold),
                                  middleText:
                                      'Apakah Anda yakin ingin menghapus data ini?',
                                  middleTextStyle: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.018,
                                  ),
                                  textConfirm: 'Ya',
                                  buttonColor: Colors.blue,
                                  textCancel: 'Batal',
                                  confirmTextColor: Colors.white,
                                  onConfirm: () {
                                    Get.back();
                                    controller.deletet(item.id!);
                                  },
                                );
                              },
                              icon: Icon(Hi.delete02, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lazyui/lazyui.dart';
// import 'package:qrm/app/data/models/arsip_karyawan_hrd/arsip_karyawan_hrd.dart';
// import 'package:qrm/app/modules/home/controllers/HRD/hrd_arsip_controller/arsip_karyawan_controller.dart';
// import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/arsiv/arsip_karyawan/create_arsip_karyawan_view.dart';
// import 'package:path/path.dart' as p;

// class ArsipKaryawanSettView extends StatelessWidget {
//   final ArsipKaryawanController controller = Get.put(ArsipKaryawanController());

//   final ArsipKaryawanHrd? data;

//   ArsipKaryawanSettView({super.key, this.data});

//   @override
//   Widget build(BuildContext context) {
//     final details = data?.detail ?? [];

//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.white),
//         centerTitle: true,
//         title: Text(
//           data?.name ?? 'Detail Arsip Karyawan',
//           style: TextStyle(color: Colors.white, fontWeight: Fw.bold),
//         ),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: ['4CA1AF'.hex, '808080'.hex],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//         ),
//       ),
//       body: details.isEmpty
//           ? const Center(child: Text('Tidak ada detail'))
//           : ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: details.length + 1, // untuk Row di atas
//               itemBuilder: (context, index) {
//                 if (index == 0) {
//                   return Column(
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: TextField(
//                               onChanged: (value) {},
//                               decoration: InputDecoration(
//                                 hintText: "Cari...",
//                                 prefixIcon: Icon(Icons.search),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 contentPadding:
//                                     EdgeInsets.symmetric(vertical: 10),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           LzButton(
//                             icon: Hi.addSquare,
//                             onTap: () {
//                               Get.to(() => CreateArsipKaryawanView())
//                                   ?.then((data) {
//                                 if (data != null) {
//                                   controller.insertData(
//                                       ArsipKaryawanHrd.fromJson(data));
//                                 }
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                     ],
//                   );
//                 }

//                 final item = details[index - 1];
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: MediaQuery.of(context).size.width,
//                       padding: const EdgeInsets.all(16),
//                       margin: const EdgeInsets.only(bottom: 8),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Color.fromARGB(255, 54, 145, 220),
//                             Color.fromARGB(255, 73, 173, 255),
//                             Color.fromARGB(255, 14, 63, 210)
//                           ],
//                         ),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               item.filename ?? 'No file',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               overflow: TextOverflow
//                                   .ellipsis, // untuk mencegah text terlalu panjang
//                             ),
//                           ),
//                           IconButton(
//                             padding: EdgeInsets.zero,
//                             onPressed: () async {
//                               final filePath = item.filepath ?? '';
//                               final baseUrl =
//                                   'https://laravel.apihbr.link/api/';
//                               final fullUrl = filePath.startsWith('http')
//                                   ? filePath
//                                   : '$baseUrl$filePath';

//                               final ext = p.extension(fullUrl).toLowerCase();

//                               if (ext == '.jpg' ||
//                                   ext == '.jpeg' ||
//                                   ext == '.png' ||
//                                   ext == '.gif') {
//                                 final image =
//                                     await controller.getImageWithToken(fullUrl);
//                                 if (image != null) {
//                                   Get.dialog(
//                                     Dialog(
//                                       backgroundColor: Colors.transparent,
//                                       insetPadding: EdgeInsets.all(16),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(12),
//                                           color: Colors.white,
//                                         ),
//                                         padding: EdgeInsets.all(10),
//                                         child: Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Image(image: image),
//                                             SizedBox(height: 10),
//                                             ElevatedButton(
//                                               onPressed: () => Get.back(),
//                                               child: Text('Tutup'),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 } else {
//                                   Toast.show('Gagal menampilkan gambar');
//                                 }
//                               } else {
//                                 // selain gambar, buka dengan aplikasi eksternal
//                                 controller.openFileWithToken(fullUrl);
//                               }
//                             },
//                             icon:
//                                 Icon(Icons.remove_red_eye, color: Colors.white),
//                           ),
//                           IconButton(
//                             padding: EdgeInsets.zero,
//                             onPressed: () {
//                               Get.defaultDialog(
//                                 title: 'Konfirmasi',
//                                 titleStyle: TextStyle(fontWeight: Fw.bold),
//                                 middleText:
//                                     'Apakah Anda yakin ingin menghapus data ini?',
//                                 middleTextStyle: TextStyle(
//                                   fontSize: MediaQuery.of(context).size.height *
//                                       0.018,
//                                 ),
//                                 textConfirm: 'Ya',
//                                 buttonColor: Colors.blue,
//                                 textCancel: 'Batal',
//                                 confirmTextColor: Colors.white,
//                                 onConfirm: () {
//                                   Get.back(); // Tutup dialog
//                                   // controller.deletet(data
//                                   //     .id!); // Jalankan fungsi simpan
//                                 },
//                               );
//                             },
//                             icon: Icon(Hi.delete02, color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//     );
//   }
// }
