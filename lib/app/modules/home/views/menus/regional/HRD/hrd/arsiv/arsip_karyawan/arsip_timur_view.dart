import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/arsip_karyawan_hrd/arsip_karyawan_hrd.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_arsip_controller/arsip_karyawan_timur_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/arsiv/arsip_karyawan/arsip_karyawan_sett_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class ArsipTimurView extends GetView<ArsipKaryawanTimurController> {
  const ArsipTimurView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ArsipKaryawanTimurController());

    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Arsip Karyawan Timur',
      ).appBar,
      body: Obx(() {
        bool isLoading = controller.isLoading.value;
        final data = controller.listAK;

        if (isLoading) {
          return Center(child: CustomLoading());
        }

        if (data.isEmpty) {
          return Empty(
            message: 'Tidak ada data apa pun.',
            onTap: () => controller.getArsip(),
          );
        }

        return Column(
          children: [
            Padding(
              padding: Ei.sym(v: 10, h: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SearchQuery.searchInput(
                        onSubmitted: controller.updateSearchQuery,
                        controller: controller.searchC,
                        hint: 'Search...'),
                  ),
                  // LzButton(
                  //   icon: Hi.addSquare,
                  //   onTap: () {},
                  // ),
                ],
              ),
            ),
            Expanded(
              child: LzListView(
                padding: Ei.sym(v: 10, h: 20),
                onRefresh: () => controller.getArsip(),
                onScroll: (scroll) {
                  if (scroll.atBottom(100)) {
                    controller.onPaginate();
                  }
                },
                children: [
                  ...data.generate((item, i) {
                    return CustomScalaContainer(
                      child: Touch(
                        onTap: () {
                          Get.to(() => ArsipKaryawanSettView(data: item))
                              ?.then((value) {
                            if (value != null) {
                              controller.updateData(
                                  ArsipKaryawanHrd.fromJson(value),
                                  item.userId!);
                            }
                          });
                        },
                        margin: Ei.only(b: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          width: itemWidth,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 54, 145, 220),
                                Color.fromARGB(255, 73, 173, 255),
                                Color.fromARGB(255, 14, 63, 210)
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
                                      item.name ?? 'tidak ada',
                                      style: GoogleFonts.notoSerif().copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
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
                                      Get.back(); // Tutup dialog
                                      // controller.deletet(data
                                      //     .id!); // Jalankan fungsi simpan
                                    },
                                  );
                                },
                                icon: Icon(Hi.delete02, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

                  // animasi loading paginasi
                  Obx(() =>
                      CustomLoading().lz.hide(!controller.isPaginate.value))
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
