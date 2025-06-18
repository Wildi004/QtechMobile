import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/daftar_tkdn.dart';
import 'package:qrm/app/modules/daftar_tkdn/controllers/daftar_tkdn_controller.dart';
import 'package:qrm/app/modules/daftar_tkdn/views/create_tkdn_view.dart';
import 'package:qrm/app/modules/daftar_tkdn/views/detail_daftar_tkdn_view.dart';
import 'package:qrm/app/modules/daftar_tkdn/views/form_tkdn.dart';

class DaftarTkdnView extends StatelessWidget {
  final DaftarTkdnController controller = Get.put(DaftarTkdnController());

  DaftarTkdnView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Daftar TKDN',
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
                    Get.to(() => CreateTkdnView())?.then((data) {
                      if (data != null) {
                        controller.insertData(DaftarTkdn.fromJson(data));
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: Obx(() {
                bool isLoading = controller.isLoading.value;
                final tkdn = controller.rxDt;
                final itemWidth = MediaQuery.of(context).size.width - 30;

                if (isLoading) {
                  return Center(child: LzLoader.bar());
                }

                if (tkdn.isEmpty) {
                  return Empty(
                    message: 'Tidak ada data.',
                    onTap: () => controller.getTkdn(),
                  );
                }

                return LzListView(
                    padding: Ei.sym(v: 20),
                    onRefresh: () => controller.getTkdn(),
                    onScroll: (scroll) {
                      if (scroll.atBottom(100)) {
                        controller.onPaginate();
                      }
                    },
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: tkdn.map((data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => DetailDaftarTkdnView(
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
                                              Get.to(() => FormTkdn(data: data))
                                                  ?.then((value) {
                                                if (value != null) {
                                                  controller.updateData(
                                                      DaftarTkdn.fromJson(
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
                                                  Get.back();
                                                  controller
                                                      .deletetdkn(data.id!);
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
