import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/daftar_tkdn.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/arsip_karyawan_hrd/detail.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_arsip_controller/create_arsip_karyawan_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreateArsipKaryawanView extends GetView<CreateArsipKaryawanController> {
  final int? userId;
  final DaftarTkdn? data;
  final ArsivKaryawanDetail? arsip;
  const CreateArsipKaryawanView(
      {super.key, this.data, this.userId, this.arsip});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateArsipKaryawanController());
    final forms = controller.forms;

    controller.selectedUserId = userId;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    final isEdit = arsip != null;
    // final image = arsip?.filepath;
    controller.setToken();

    return Scaffold(
      appBar: CustomAppbar(
        title: isEdit ? 'Edit Arsip' : 'Buat Arsip',
        actions: [
          IconButton(
              onPressed: () {
                controller.onSubmit(data?.id, arsip?.id);
              },
              icon: Icon(Hi.tick04))
        ],
      ).appBar,
      body: LzListView(
        gap: 25,
        children: [
          LzForm.input(
            hint: 'Pilih Arsip',
            label: 'Pilih Arsip ',
            model: forms.key('files[]'),
            suffixIcon: Hi.image01,
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.any,
                allowMultiple: true,
              );
              if (result != null && result.files.isNotEmpty) {
                controller.onFiles(result.files);
              }
            },
          ),

          // list file

          Obx(() {
            return Column(
              children: controller.files.generate((file, i) {
                return Container(
                  padding: Ei.sym(v: 10, h: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Br.only(['t'], except: i),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(file).lz.flexible(),
                          Touch(
                            onTap: () {
                              controller.removeFile(i);
                            },
                            child: Icon(Hi.cancel01),
                          )
                        ],
                      ).between.gap(15),
                      // LzImage(image, size: 100, headers: {
                      //   'Authorization': 'Bearer ${controller.token}'
                      // })
                    ],
                  ),
                );
              }),
            ).start;
          })
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lazyui/lazyui.dart';
// import 'package:qrm_dev/app/data/models/arsip_karyawan_hrd/arsip_karyawan_hrd.dart';
// import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_arsip_controller/arsip_karyawan_controller.dart';

// class ArsipKaryawanSettView extends GetView<ArsipKaryawanController> {
//   ArsipKaryawanHrd? data;
//   ArsipKaryawanSettView({super.key, this.data});
//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut(() => ArsipKaryawanController());
//     final itemWidth = MediaQuery.of(context).size.width - 30;
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.white),
//         centerTitle: true,
//         title: Text(
//           'Arsip Karyawan  ',
//           style: TextStyle(color: Colors.white),
//         ),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 colors: ['4CA1AF'.hex, '808080'.hex],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter),
//           ),
//         ),
//       ),
//       body: Obx(() {
//         bool isLoading = controller.isLoading.value;
//         final data = controller.rxAK;
//         if (isLoading) {
//           return Center(child:  CustomLoading()
// );
//         }
//         if (data.isEmpty) {
//           return Empty(
//             message: 'Tidak ada data apa pun.',
//             onTap: () => controller.getArsip(),
//           );
//         }
//         return LzListView(
//           padding: Ei.sym(v: 20, h: 20),
//           onRefresh: () => controller.getArsip(),
//           onScroll: (scroll) {
//             if (scroll.atBottom(100)) {
//               controller.onPaginate();
//             }
//           },
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     onChanged: controller.updateSearchQuery,
//                     decoration: InputDecoration(
//                       hintText: "Cari...",
//                       prefixIcon: const Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(vertical: 10),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 // LzButton(
//                 //   icon: Hi.addSquare,
//                 //   onTap: () {},
//                 // ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             ...data.generate((item, i) {
//               return Touch(
//                 onTap: () {
//                   Get.to(() => ArsipKaryawanSettView(data: item))
//                       ?.then((value) {
//                     if (value != null) {
//                       controller.updateData(
//                           ArsipKaryawanHrd.fromJson(value), item.userId!);
//                     }
//                   });
//                 },
//                 margin: Ei.only(b: 10),
//                 child: Container(
//                   height: MediaQuery.of(context).size.height * 0.09,
//                   width: itemWidth,
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [
//                         Color.fromARGB(255, 54, 145, 220),
//                         Color.fromARGB(255, 73, 173, 255),
//                         Color.fromARGB(255, 14, 63, 210)
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               item.departemen ?? 'tidak ada',
//                               style: GoogleFonts.notoSerif().copyWith(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                       ),
//                       IconButton(
//                         padding: EdgeInsets.zero,
//                         onPressed: () {
//                           Get.defaultDialog(
//                             title: 'Konfirmasi',
//                             titleStyle: TextStyle(fontWeight: Fw.bold),
//                             middleText:
//                                 'Apakah Anda yakin ingin menghapus data ini?',
//                             middleTextStyle: TextStyle(
//                               fontSize:
//                                   MediaQuery.of(context).size.height * 0.018,
//                             ),
//                             textConfirm: 'Ya',
//                             buttonColor: Colors.blue,
//                             textCancel: 'Batal',
//                             confirmTextColor: Colors.white,
//                             onConfirm: () {
//                               Get.back(); // Tutup dialog
//                               // controller.deletet(data
//                               //     .id!); // Jalankan fungsi simpan
//                             },
//                           );
//                         },
//                         icon: Icon(Hi.delete02, color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),

//             // animasi loading paginasi
//             Obx(() =>  CustomLoading()
// .lz.hide(!controller.isPaginate.value))
//           ],
//         );
//       }),
//     );
//   }
// }

/* */
