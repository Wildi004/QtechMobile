import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/brosur_logistik.dart';
import 'package:qrm/app/modules/brosur_logistik/controllers/brosur_logistik_controller.dart';
import 'package:qrm/app/modules/brosur_logistik/views/create_brosur_view.dart';
import 'package:qrm/app/modules/brosur_logistik/views/detail_brosur_log_view.dart';
import 'package:qrm/app/modules/brosur_logistik/views/form_add_brosur.dart';

class BrosurLogistikView extends StatelessWidget {
  final BrosurLogistikController controller =
      Get.put(BrosurLogistikController());

  BrosurLogistikView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Brosur brosur',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: ['4CA1AF'.hex, '808080'.hex],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    Get.to(() => CreateBrosurView());
                  },
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: Obx(() {
                bool isLoading = controller.isLoading.value;
                final brosur = controller.rxbl;
                final itemWidth = MediaQuery.of(context).size.width - 30;

                if (isLoading) {
                  return Center(child: LzLoader.bar());
                }

                if (brosur.isEmpty) {
                  return Empty(
                    message: 'Tidak ada data apa pun.',
                    onTap: () => controller.getBrosur(),
                  );
                }

                return LzListView(
                    padding: Ei.sym(v: 20),
                    onRefresh: () => controller.getBrosur(),
                    onScroll: (scroll) {
                      if (scroll.atBottom(100)) {
                        controller.onPaginate();
                      }
                    },
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: brosur.map((data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => DetailBrosurLogView(
                                        nama: data.nama,
                                        tglUpload: data.tglUpload,
                                      ));
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
                                          data.nama ?? 'tidak ada',
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
                                                      FormAddBrosur(data: data))
                                                  ?.then((value) {
                                                if (value != null) {
                                                  controller.updateData(
                                                      BrosurLogistik.fromJson(
                                                          value),
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
                                                  controller.deleteBrosur(data
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
