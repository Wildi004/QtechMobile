import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/dokumen_hrd.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_arsip_dokumen_controller/arsip_dokumen_hrd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/arsiv/arsip_dokumen/detail_arsip_dokumen_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/arsiv/arsip_dokumen/form_arsip_dokumen_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class ArsipDokumenHrdView extends GetView<ArsipDokumenHrdController> {
  const ArsipDokumenHrdView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      Get.lazyPut(() => ArsipDokumenHrdController());
      bool depLoad = controller.isLoading.value;

      final data = controller.listDoc;

      if (depLoad) {
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
            padding: Ei.sym(v: 10),
            child: Row(
              children: [
                Expanded(
                  child: SearchQuery.searchInput(
                      onSubmitted: controller.updateSearchQuery,
                      controller: controller.searchC,
                      hint: 'Search...'),
                ),
                SizedBox(width: 10),
                CustomScalaContainer(
                  child: LzButton(
                    icon: Hi.addSquare,
                    onTap: () {
                      Get.to(() => FormArsipDokumenView())?.then((data) {
                        if (data != null) {
                          controller.insertData(DokumenHrd.fromJson(data));
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: LzListView(
              padding: Ei.sym(v: 10),
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
                        Get.to(() => DetailArsipDokumenHrdView(data: item))
                            ?.then((value) {
                          if (value != null) {
                            controller.updateData(
                                DokumenHrd.fromJson(value), item.id!);
                          }
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
                                item.nama ?? 'tidak ada',
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
                                            FormArsipDokumenView(data: item))
                                        ?.then((value) {
                                      if (value != null) {
                                        controller.updateData(
                                            DokumenHrd.fromJson(value),
                                            item.id!);
                                      }
                                    });
                                  },
                                  icon: Icon(Hi.edit01, color: Colors.white),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    CustomDelete.show(
                                      title: 'Konfirmasi Hapus',
                                      message:
                                          'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                      context: context,
                                      onConfirm: () {
                                        controller.delete(item.id!);
                                      },
                                    );
                                  },
                                  icon: Icon(Hi.delete02, color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                Obx(() => CustomLoading().lz.hide(!controller.isPaginate.value))
              ],
            ),
          ),
        ],
      );
    });
  }
}
