import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/hrd_cuti.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_cuti_sudah_validasi_controller/hrd_cuti_belum_validasi_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/cuti/cuti_hrd_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';

import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class BelumValidasiView extends GetView<HrdCutiBelumValidasiController> {
  const BelumValidasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      Get.lazyPut(() => HrdCutiBelumValidasiController());
      bool isLoading = controller.isLoading.value;
      final data = controller.cuti;

      if (isLoading) {
        return Center(child: CustomLoading());
      }

      if (data.isEmpty) {
        return Empty(
          message: 'Tidak ada data apa pun.',
          onTap: () => controller.getData(),
        );
      }

      return Padding(
        padding: Ei.sym(h: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchQuery.searchInput(
                    onChanged: controller.updateSearchQuery,
                  ),
                ),
                SizedBox(width: 10),
                // LzButton(
                //   icon: Hi.addSquare,
                //   onTap: () {

                //   },
                // ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: LzListView(
                padding: Ei.sym(
                  v: 20,
                ),
                onRefresh: () => controller.getData(),
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
                          Get.to(() => CutiHrdDetailView(data: item))
                              ?.then((value) {
                            if (value != null) {
                              controller.updateData(
                                  HrdCuti.fromJson(value), item.id!);
                            }
                          });
                        },
                        margin: Ei.only(b: 10),
                        child: Container(
                          width: itemWidth,
                          padding: const EdgeInsets.all(10),
                          decoration: CustomDecoration.notValidator(),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.userName ?? 'tidak ada',
                                      style: GoogleFonts.notoSerif().copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      item.perihal ?? 'tidak ada',
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
                                          item.cutiFrom ?? 'tidak ada',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          ' - ${item.cutiTo ?? 'tidak ada'}',
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
        ),
      );
    });
  }
}
