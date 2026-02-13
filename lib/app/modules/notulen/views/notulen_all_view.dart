import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/notulen/notulen.dart';
import 'package:qrm_dev/app/modules/notulen/views/detail_notulen.dart';
import 'package:qrm_dev/app/modules/notulen/views/form_notulen_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

import '../controllers/notulen_controller.dart';

class NotulenAllView extends GetView<NotulenController> {
  const NotulenAllView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      bool notLoad = controller.isLoading.value;
      final notulens = controller.not;

      if (notLoad) {
        return const Center(child: CustomLoading());
      }

      if (notulens.isEmpty) {
        return Empty(
          message: 'Tidak ada data apa pun.',
          onTap: () => controller.getNotulen(),
        );
      }

      return LzListView(
        padding: Ei.sym(
          v: 20,
        ),
        onRefresh: () => controller.getNotulen(),
        onScroll: (scroll) {
          if (scroll.atBottom(100)) controller.onPaginate();
        },
        children: [
          Row(
            children: [
              Expanded(
                child: SearchQuery.searchInput(
                  onChanged: controller.updateSearchQuery,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 20),

          ...notulens.generate((item, i) {
            return ListItemAnimasi(
              index: i,
              beginOffset: const Offset(-0.3, 0),
              child: Touch(
                onTap: () {
                  Get.to(() => DetailNotulen(data: item))?.then((value) {
                    if (value != null) {}
                  });
                },
                margin: Ei.only(b: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: itemWidth,
                  padding: const EdgeInsets.all(10),
                  decoration: CustomDecoration.validator(),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.judul ?? 'tidak ada',
                          style: CustomTextStyle.title(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      iosBlurActionGroup(
                        onEdit: () {
                          Get.to(() => FormNotulenView(data: item))
                              ?.then((value) {
                            if (value != null) {
                              controller.updateData(
                                Notulen.fromJson(value),
                                item.id!,
                              );
                            }
                          });
                        },
                        onDelete: () {
                          Get.defaultDialog(
                            title: 'Konfirmasi',
                            middleText:
                                'Apakah Anda yakin ingin menghapus data ini?',
                            textConfirm: 'Ya',
                            textCancel: 'Batal',
                            confirmTextColor: Colors.white,
                            buttonColor: Colors.blue,
                            onConfirm: () {
                              Get.back();
                              controller.delete(item.id!);
                            },
                          );
                        },
                      ),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          }),

          // animasi loading paginasi
          Obx(() => CustomLoading().lz.hide(!controller.isPaginate.value)),
        ],
      );
    });
  }
}
