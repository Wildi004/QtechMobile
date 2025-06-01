import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/job_desk.dart';
import 'package:qrm/app/modules/job_desk/controllers/job_desk_controller.dart';
import 'package:qrm/app/modules/job_desk/views/create_job_view.dart';
import 'package:qrm/app/modules/job_desk/views/update_job_view.dart';

class JobDeskView extends StatelessWidget {
  final JobDeskController controller = Get.put(JobDeskController());
  JobDeskView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Desc", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 91, 122),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search dan Tambah
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: controller.updateSearchQuery,
                    decoration: InputDecoration(
                      hintText: "Cari...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                LzButton(
                  icon: Hi.addSquare,
                  onTap: () {
                    Get.to(() => CreateJobView());
                  },
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            // List Data
            Expanded(
              child: Obx(() {
                bool isLoading = controller.isLoading.value;
                final jobdesk = controller.rxJd;
                final itemWidth = MediaQuery.of(context).size.width - 30;

                if (isLoading) {
                  return Center(child: LzLoader.bar());
                }
                if (jobdesk.isEmpty) {
                  return Empty(
                    message: 'Tidak ada data.',
                    onTap: () => controller.getJob(),
                  );
                }

                return LzListView(
                    padding: Ei.sym(v: 20),
                    onRefresh: () => controller.getJob(),
                    onScroll: (scroll) {
                      if (scroll.atBottom(100)) {
                        controller.onPaginate();
                      }
                    },
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: jobdesk.map((data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Get.to(() => FormInfoSuratInternalView(
                                  //       id: data.id,
                                  //       nama: data.nama,
                                  //       keterangan: data.keterangan,
                                  //       image: data.image,
                                  //       tglUpload: data.tglUpload,
                                  //       userId: data.userId,
                                  //       userName: data.userName,

                                  //     ));
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  width: itemWidth,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color.fromARGB(255, 54, 145, 220),
                                        const Color.fromARGB(255, 73, 173, 255),
                                        const Color.fromARGB(255, 14, 63, 210)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data.roleName ?? 'tidak ada data',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              Get.to(() =>
                                                      UpdateJobView(data: data))
                                                  ?.then((value) {
                                                if (value != null) {
                                                  controller.updateData(
                                                      JobDesk.fromJson(value),
                                                      data.id!);
                                                }
                                              });
                                            },
                                            icon: Icon(Hi.edit01,
                                                color: Colors.white),
                                          ),
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              Get.defaultDialog(
                                                title: 'Konfirmasi',
                                                titleStyle: TextStyle(
                                                    fontWeight: Fw.bold),
                                                middleText:
                                                    'Apakah Anda yakin ingin menghapus data ini?',
                                                middleTextStyle: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.018,
                                                ),
                                                textConfirm: 'Ya',
                                                buttonColor: Colors.blue,
                                                textCancel: 'Batal',
                                                confirmTextColor: Colors.white,
                                                onConfirm: () {
                                                  Get.back(); // Tutup dialog
                                                  controller.delete(data
                                                      .id!); // Jalankan fungsi simpan
                                                },
                                              );
                                            },
                                            icon: Icon(Hi.delete02,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        }).toList(),
                      ),
                      Obx(() =>
                          LzLoader.bar().lz.hide(!controller.isPaginate.value))
                    ]);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
//  Column(
//                         children: [
//                           ListView.builder(
//                             shrinkWrap: true,
//                             itemCount: controller.rxJd.length,
//                             itemBuilder: (context, index) {
//                               var item = controller.rxJd[index];

//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     height: 70,
//                                     padding: const EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           const Color.fromARGB(
//                                               255, 54, 145, 220),
//                                           const Color.fromARGB(
//                                               255, 73, 173, 255),
//                                           const Color.fromARGB(255, 14, 63, 210)
//                                         ],
//                                       ),
//                                       borderRadius: BorderRadius.circular(15),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Expanded(
//                                           child: Wrap(
//                                             alignment: WrapAlignment.start,
//                                             children: [
//                                               Text(
//                                                 item.roleName ?? 'tidak ada',
//                                                 style: const TextStyle(
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                                 softWrap: true,
//                                                 overflow: TextOverflow.visible,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Row(
//                                           children: [
//                                             Container(
//                                               decoration: BoxDecoration(
//                                                 color: const Color.fromARGB(
//                                                     255, 151, 176, 14),
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                               ),
//                                               child: IconButton(
//                                                 onPressed: () {},
//                                                 icon: Icon(Hi.eye,
//                                                     color: Colors.white),
//                                               ),
//                                             ),
//                                             SizedBox(width: 8),
//                                             Container(
//                                               decoration: BoxDecoration(
//                                                 color: const Color.fromARGB(
//                                                     255, 177, 13, 1),
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                               ),
//                                               child: IconButton(
//                                                 onPressed: () {
//                                                   Get.defaultDialog(
//                                                     title: 'Konfirmasi',
//                                                     titleStyle: TextStyle(
//                                                         fontWeight: Fw.bold),
//                                                     middleText:
//                                                         'Apakah Anda yakin ingin menghapus data ini?',
//                                                     middleTextStyle: TextStyle(
//                                                       fontSize:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .height *
//                                                               0.018,
//                                                     ),
//                                                     textConfirm: 'Ya',
//                                                     buttonColor: Colors.blue,
//                                                     textCancel: 'Batal',
//                                                     confirmTextColor:
//                                                         Colors.white,
//                                                     onConfirm: () {
//                                                       Get.back(); // Tutup dialog
//                                                       controller.deletetJob(item
//                                                           .id!); // Jalankan fungsi simpan
//                                                     },
//                                                   );
//                                                 },
//                                                 icon: Icon(Hi.delete02,
//                                                     color: Colors.white),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(height: 10),
//                                 ],
//                               );
//                             },
//                           ),
//                            Obx(() =>
//                           LzLoader.bar().lz.hide(!controller.isPaginate.value))
//                         ],
//                       ),
