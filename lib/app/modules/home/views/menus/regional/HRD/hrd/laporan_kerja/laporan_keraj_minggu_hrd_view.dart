import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_laporan_kerja_controller/hrd_laporan_kerja_minggu_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_laporan_kerja_controller/hrd_nama_pekerjaan_pic_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/laporan_kerja/nama_pekerjaan_hrd_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class LaporanKerajMingguHrdView
    extends GetView<HrdLaporanKerjaMingguController> {
  final String encryptedMinggu;

  const LaporanKerajMingguHrdView({super.key, required this.encryptedMinggu});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadDetail(encryptedMinggu);
    });

    return Scaffold(
      appBar: CustomAppbar(title: 'Laporan Harian').appBar,
      body: Obx(() {
        Get.lazyPut(() => HrdLaporanKerjaMingguController());
        final isLoading = controller.isLoading.value;
        final data = controller.detailList;

        if (isLoading) {
          return Center(child: CustomLoading());
        }

        if (data.isEmpty) {
          return Empty(
            message: 'Tidak ada data apa pun.',
            onTap: () => controller.loadDetail(encryptedMinggu),
          );
        }

        return Column(
          children: [
            Padding(
              padding: Ei.sym(h: 20, v: 10),
              child: Row(
                children: [
                  Expanded(
                    child: SearchQuery.searchInput(
                      onChanged: controller.updateSearchQuery,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LzListView(
                padding: Ei.sym(h: 20),
                onRefresh: () => controller.loadDetail(encryptedMinggu),
                onScroll: (scroll) {
                  if (scroll.atBottom(100)) {
                    controller.onPaginate();
                  }
                },
                children: [
                  const SizedBox(height: 10),
                  ...data.generate((item, i) {
                    return CustomScalaContainer(
                      child: Touch(
                        onTap: () {
                          Get.lazyPut(() => HrdNamaPekerjaanPicController());
                          Get.to(
                            () => NamaPekerjaanHrdView(
                              encryptedTglRencana:
                                  item.encryptedTglRencana ?? '',
                              encryptedPic: item.encryptedPic ?? '',
                            ),
                          );
                        },
                        margin: Ei.only(b: 10),
                        child: Container(
                          width: itemWidth,
                          padding: const EdgeInsets.all(10),
                          decoration: CustomDecoration.validator(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.tglRencana ?? 'Tidak ada',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                item.userName ?? 'Tidak ada',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  Obx(() =>
                      CustomLoading().lz.hide(!controller.isPaginate.value)),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
