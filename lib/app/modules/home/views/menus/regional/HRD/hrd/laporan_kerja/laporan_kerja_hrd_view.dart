import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_laporan_kerja_controller/hrd_laporan_kerja_hrd_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_laporan_kerja_controller/hrd_laporan_kerja_minggu_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/laporan_kerja/create_laporan_kerja_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/laporan_kerja/laporan_keraj_minggu_hrd_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class LaporanKerjaHrdView extends GetView<HrdLaporanKerjaHrdController> {
  const LaporanKerjaHrdView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HrdLaporanKerjaHrdController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Laporan Kerja',
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => CreateLaporanKerjaView());
              },
              icon: Icon(Hi.add01))
        ],
      ).appBar,
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        bool isLoading = controller.isLoading.value;
        final data = controller.rk;

        if (isLoading) {
          return Center(child: CustomLoading());
        }

        if (data.isEmpty) {
          return Empty(
            message: 'Tidak ada data apa pun.',
            onTap: () => controller.getData(),
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
                onRefresh: () => controller.getData(),
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
                          if (item.encryptedMinggu != null) {
                            Get.lazyPut(
                                () => HrdLaporanKerjaMingguController());
                            Get.to(
                              () => LaporanKerajMingguHrdView(
                                encryptedMinggu: item.encryptedMinggu!,
                              ),
                            );
                          } else {
                            Toast.show('Data minggu tidak tersedia');
                          }
                        },
                        margin: Ei.only(b: 10),
                        child: Container(
                          width: itemWidth,
                          padding: const EdgeInsets.all(10),
                          decoration: CustomDecoration.validator(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Periode || Week',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              5.height,
                              Text(
                                '${item.periode ?? '-'} || ${item.minggu ?? '-'}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
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
