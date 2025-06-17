import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/pengajuan_hrd/pengajuan_hrd.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_pengajuan_controller/pengajuan_hrd_controller.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/pengajuan_hrd/detail_pengajuan_hrd_view.dart';

class PengajuanSudahValidasiView extends GetView<PengajuanHrdController> {
  const PengajuanSudahValidasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      Get.lazyPut(() => PengajuanHrdController());
      bool isLoading = controller.isLoading.value;
      final data = controller.pengajuan;

      if (isLoading) {
        return Center(child: LzLoader.bar());
      }

      if (data.isEmpty) {
        return Empty(
          message: 'Tidak ada data apa pun.',
          onTap: () => controller.getData(),
        );
      }

      return LzListView(
        padding: Ei.sym(v: 20, h: 20),
        onRefresh: () => controller.getData(),
        onScroll: (scroll) {
          if (scroll.atBottom(100)) {
            controller.onPaginate();
          }
        },
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
            ],
          ),
          SizedBox(height: 20),

          ...data.generate((item, i) {
            return Touch(
              onTap: () {
                Get.to(() => DetailPengajuanHrdView(data: item))?.then((value) {
                  if (value != null) {
                    controller.updateData(
                        PengajuanHrd.fromJson(value), item.noHide!);
                  }
                });
              },
              margin: Ei.only(b: 10),
              child: Container(
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.createdName ?? 'tidak ada',
                            style: GoogleFonts.notoSerif().copyWith(
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            item.noPengajuan ?? 'tidak ada',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Text(
                                item.detail != null && item.detail!.isNotEmpty
                                    ? 'Rp ${item.detail!.first.totalHarga}'
                                    : 'tidak ada data',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                ' || ${item.tglPengajuan ?? 'tidak ada'}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [],
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
