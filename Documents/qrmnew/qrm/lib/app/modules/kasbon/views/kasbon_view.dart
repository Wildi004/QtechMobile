import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/kasbon/controllers/kasbon_controller.dart';

class KasbonView extends GetView<KasbonController> {
  const KasbonView({super.key});

  @override
  Widget build(BuildContext context) {
    // bool showDetails = false;
    final KasbonController refreshController = Get.put(KasbonController());
    List<Map<String, String>> absensiFebruari = [
      {
        'tanggal': '10 Januari 2025',
        'keterangan': 'Keperluan Pribadi',
        'status': 'Rp. 100.000.000,-',
        'validasi': 'Sudah Di Validasi'
      },
    ];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshController.refreshData,
        child: Stack(
          children: [
            Obx(() => Container(
                  width: MediaQuery.of(context).size.width,
                  height: controller.height.value,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: ['808080'.hex, '4CA1AF'.hex],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Kasbon',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
            LzListView(
              physics: const NeverScrollableScrollPhysics(),
              gap: 20,
              padding: Ei.only(t: 140 - 50, b: 100),
              onScroll: (value) {
                double pixels = value.pixels;
                controller.adjustHeader(
                  pixels < 0
                      ? 250 + pixels.abs()
                      : (250 - pixels.abs()).clamp(0, 500),
                );
              },
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [Color(0xFF100C58), Color(0xFF5E5BA7)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 17, top: 10, right: 70),
                                child: Obx(() {
                                  final user = controller.user.value;
                                  return Text(
                                    'Sisa saldo ${user?.name}',
                                    style: TextStyle(color: Colors.white),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                })),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 17,
                                  top: MediaQuery.of(context).size.width *
                                      0.006),
                              child: Text(
                                'Rp. 100.000.000,-',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.045,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 17,
                          top: 10,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.showAjukanForm(context);
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.applyOpacity(0.2),
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child:
                                      const Icon(Icons.add, color: Colors.blue),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Ajukan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 15, right: 15),
                //   child: Container(
                //     height: MediaQuery.of(context).size.height * 0.06,
                //     decoration: BoxDecoration(
                //         color: Color(0xFF5E5BA7),
                //         borderRadius: BorderRadius.circular(10)),
                //     child: Align(
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text(
                //             'Perhatian!,',
                //             style: TextStyle(
                //                 color: Colors.white,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize:
                //                     MediaQuery.of(context).size.width * 0.04),
                //           ),
                //           Text(
                //             ' Saldo anda minus...',
                //             style: TextStyle(
                //                 color: Colors.white,
                //                 fontSize:
                //                     MediaQuery.of(context).size.width * 0.037),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Daftar Kasbon :',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.046),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Obx(
                    () {
                      return GestureDetector(
                        onTap: () {
                          controller.showDetails.value =
                              !controller.showDetails.value;
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' 1.',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045,
                                  ),
                                ),
                                Icon(
                                  controller.showDetails.value
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  size:
                                      MediaQuery.of(context).size.width * 0.066,
                                ),
                              ],
                            ),
                            if (controller.showDetails.value)
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: ['808080'.hex, '4CA1AF'.hex],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: absensiFebruari.length,
                                    itemBuilder: (context, index) {
                                      final absen = absensiFebruari[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (index == 0)
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 15),
                                                  child: Obx(() {
                                                    final kas = controller
                                                        .dataKas.value;

                                                    return Text(
                                                        kas?.tglKasbon ??
                                                            '00-00-0000',
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.039,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Poppins'));
                                                  })
                                                  //  (Text(
                                                  //   absen['tanggal']!,
                                                  //   style: TextStyle(
                                                  //       fontSize:
                                                  //           MediaQuery.of(context)
                                                  //                   .size
                                                  //                   .width *
                                                  //               0.048,
                                                  //       fontWeight:
                                                  //           FontWeight.bold,
                                                  //       color: Colors.white,
                                                  //       fontFamily: 'PassionOne'),
                                                  // )),
                                                  ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Obx(() {
                                                  final kas =
                                                      controller.dataKas.value;

                                                  return Text(
                                                      kas?.keterangan ??
                                                          'Belum ada keterangan',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.039,
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'Poppins'));
                                                }),
                                                Obx(() {
                                                  final kas =
                                                      controller.dataKas.value;

                                                  return Text(
                                                      'Rp. ${kas?.jml ?? 'tidak ada'}',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.039,
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'Poppins'));
                                                }),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Validasi :',
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.033,
                                                        color: Colors.white70,
                                                        fontWeight: Fw.bold),
                                                  ),
                                                  Text(
                                                    absen['validasi']!,
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.033,
                                                        color: Colors.white70,
                                                        fontWeight: Fw.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.snackbar('Info', 'Data bulan Januari tidak ditambahkan',
                        backgroundColor: Colors.white);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 19),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '2.',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.snackbar('Info', 'Data bulan Januari tidak ditambahkan',
                        backgroundColor: Colors.white);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 19),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '3.',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
