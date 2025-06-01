// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/kasbon/controllers/kasbon_test_controller.dart';

class KasbonTestVies extends StatelessWidget {
  final KasbonTestController controller = Get.put(KasbonTestController());

  KasbonTestVies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kasbon",
          style: TextStyle(color: Colors.white, fontWeight: Fw.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 91, 122),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search dan Tombol Tambah
            Row(
              children: [
                // Search Field
                // Expanded(
                //   child: TextField(
                //     onChanged: controller.updateSearchQuery, // Tambahkan ini
                //     decoration: InputDecoration(
                //       hintText: "Cari...",
                //       prefixIcon: Icon(Icons.search),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       contentPadding: EdgeInsets.symmetric(vertical: 10),
                //     ),
                //   ),
                // ),
                SizedBox(width: 10),
                // Button Tambah
                // LzButton(
                //   icon: Hi.addSquare,
                //   onTap: () {
                //     Get.to(() => FormTkdn());
                //   },
                // ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            // List Data
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                      child: CircularProgressIndicator()); // Tampilkan loading
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.rxKs.length,
                        itemBuilder: (context, index) {
                          var item = controller.rxKs[index];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (controller.selectedIndex.value == index) {
                                    controller.selectedIndex.value = -1;
                                  } else {
                                    controller.selectedIndex.value = index;
                                  }
                                },
                                child: Container(
                                  height: 70,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Wrap(
                                          alignment: WrapAlignment.start,
                                          children: [
                                            Text(
                                              item.user ?? 'tidak ada',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              softWrap: true,
                                              overflow: TextOverflow.visible,
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Ikon Arrow yang Berubah Saat Ditekan
                                      Obx(() => Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Icon(
                                              controller.selectedIndex.value ==
                                                      index
                                                  ? Icons.keyboard_arrow_down
                                                  : Icons.arrow_forward_ios,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),

                              // Menampilkan Data di Bawah Jika Container Diklik
                              Obx(() => (controller.selectedIndex.value ==
                                      index)
                                  ? Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(top: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Nama dan Ikon dalam satu Row
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Membatasi teks agar hanya mengambil setengah dari Row
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8, // 50% dari Row
                                                child: Text(
                                                  item.user ?? '-',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  softWrap: true,
                                                ),
                                              ),
                                              // Ikon bisa ditekan
                                              // Row(
                                              //   children: [
                                              //     GestureDetector(
                                              //       onTap: () {
                                              //         Get.snackbar('Maaf',
                                              //             'Masih dalam tahap pengembangan');
                                              //       },
                                              //       child: Container(
                                              //         width: 35,
                                              //         height: 35,
                                              //         decoration: BoxDecoration(
                                              //           color: const Color
                                              //               .fromARGB(
                                              //               255, 135, 174, 44),
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(10),
                                              //         ),
                                              //         child: const Icon(
                                              //             Icons.remove_red_eye,
                                              //             color: Colors.white,
                                              //             size: 20),
                                              //       ),
                                              //     ),
                                              //     10.width,
                                              //     GestureDetector(
                                              //       onTap: () {
                                              //         Get.defaultDialog(
                                              //           title: 'Konfirmasi',
                                              //           titleStyle: TextStyle(
                                              //               fontWeight:
                                              //                   Fw.bold),
                                              //           middleText:
                                              //               'Apakah Anda yakin ingin menghapus data ini?',
                                              //           middleTextStyle:
                                              //               TextStyle(
                                              //             fontSize: MediaQuery.of(
                                              //                         context)
                                              //                     .size
                                              //                     .height *
                                              //                 0.018,
                                              //           ),
                                              //           textConfirm: 'Ya',
                                              //           buttonColor:
                                              //               Colors.blue,
                                              //           textCancel: 'Batal',
                                              //           confirmTextColor:
                                              //               Colors.white,
                                              //           onConfirm: () {
                                              //             Get.back(); // Tutup dialog
                                              //             controller.deletetdkn(
                                              //                 item.id!); // Jalankan fungsi simpan
                                              //           },
                                              //         );
                                              //       },
                                              //       child: Container(
                                              //         width: 35,
                                              //         height: 35,
                                              //         decoration: BoxDecoration(
                                              //           color: const Color
                                              //               .fromARGB(
                                              //               255, 193, 18, 5),
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(10),
                                              //         ),
                                              //         child: Icon(Icons.delete,
                                              //             color: Colors.white,
                                              //             size: 20),
                                              //       ),
                                              //     ),
                                              //   ],
                                              // )
                                            ],
                                          ),

                                          const SizedBox(height: 30),

                                          // Tanggal Upload
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Wrap(
                                                  alignment:
                                                      WrapAlignment.start,
                                                  children: [
                                                    Text(
                                                      item.jml?.toString() ??
                                                          'Tidak ada data',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                item.keterangan?.toString() ??
                                                    'Tidak ada data',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox()),

                              const SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Detail yang dituju
