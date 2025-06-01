import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/notulen/notulen.dart';
import 'package:qrm/app/modules/notulen/views/detail_notulen.dart';
import 'package:qrm/app/modules/notulen/views/form_notulen_view.dart';

import '../controllers/notulen_controller.dart';

class NotulenAllView extends GetView<NotulenController> {
  const NotulenAllView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      bool notLoad = controller.isLoading.value;
      final notulens = controller.listNotulen;

      if (notLoad) {
        return Center(child: LzLoader.bar());
      }

      if (notulens.isEmpty) {
        return Empty(
          message: 'Tidak ada data apa pun.',
          onTap: () => controller.getNotulen(),
        );
      }

      return LzListView(
        padding: Ei.sym(v: 20),
        onRefresh: () => controller.getNotulen(),
        onScroll: (scroll) {
          if (scroll.atBottom(100)) {
            controller.onPaginate();
          }
        },
        children: [
          // Row Search + Button Tambah
          Row(
            children: [
              // Search Field
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
                  Get.to(() => FormNotulenView());
                },
              ),
            ],
          ),
          SizedBox(height: 20),

          ...notulens.generate((item, i) {
            return Touch(
              onTap: () {
                Get.to(() => DetailNotulen(
                      judul: item.judul,
                      isi: item.isi,
                      sifat: item.sifat,
                      tgl: item.tglRapat,
                      departemen: item.departemen,
                      jumlah: item.jmlPeserta,
                    ));
              },
              margin: Ei.only(b: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
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
                        item.judul ?? 'tidak ada',
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
                            Get.to(() => FormNotulenView(data: item))
                                ?.then((value) {
                              if (value != null) {
                                controller.updateData(
                                    Notulen.fromJson(value), item.id!);
                              }
                            });
                          },
                          icon: Icon(Hi.edit01, color: Colors.white),
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
                                    MediaQuery.of(context).size.height * 0.018,
                              ),
                              textConfirm: 'Ya',
                              buttonColor: Colors.blue,
                              textCancel: 'Batal',
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                Get.back();
                                controller.delete(item.id!);
                              },
                            );
                          },
                          icon: Icon(Hi.delete02, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),

          // animasi loading paginasi
          Obx(() => LzLoader.bar().lz.hide(!controller.isPaginate.value))
        ],
      );
    });
  }
}
