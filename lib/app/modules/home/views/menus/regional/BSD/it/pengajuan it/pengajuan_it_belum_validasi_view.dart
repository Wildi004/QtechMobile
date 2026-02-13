import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/pengajuan_it/pengajuan_it.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Pengajuan%20It/pengajuan_it_belum_validasi_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/pengajuan%20it/detail_pengajuan_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/pengajuan%20it/edit_pengajuan_it_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_format.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class PengajuanItBelumValidasiView
    extends GetView<PengajuanItBelumValidasiController> {
  const PengajuanItBelumValidasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      Get.lazyPut(() => PengajuanItBelumValidasiController());
      bool isLoading = controller.isLoading.value; //
      final data = controller.listPengajuan;

      if (isLoading) {
        return Center(child: CustomLoading());
      }

      if (data.isEmpty) {
        return Empty(
          message: 'Data sudah validasi semua.',
          onTap: () => controller.getData(),
        );
      }

      return Column(
        children: [
          Padding(
            padding: Ei.sym(h: 20),
            child: Row(
              children: [
                Expanded(
                  child: SearchQuery.searchInput(
                      onSubmitted: controller.updateSearchQuery,
                      controller: controller.searchC,
                      hint: 'Search...'),
                ),
              ],
            ),
          ),
          10.height,
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
                ...data.generate((item, i) {
                  final bool hasNominal =
                      item.detail != null && item.detail!.isNotEmpty;

                  return ListItemAnimasi(
                    index: i,
                    beginOffset: const Offset(-0.3, 0),
                    child: CustomScalaContainer(
                      child: Touch(
                          onTap: () {
                            Get.to(() => DetailPengajuanItView(data: item))
                                ?.then((value) {
                              if (int.tryParse(item.noHide!) != null) {}
                            });
                          },
                          margin: Ei.only(b: 10),
                          child: Container(
                            width: itemWidth,
                            padding: const EdgeInsets.all(10),
                            decoration: CustomDecoration.validator(),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Intrinsic(
                                        children: [
                                          Text(
                                            item.createdName ?? 'tidak ada',
                                            style: CustomTextStyle.title(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: statusValidasiColor(
                                                  item.statusGmBsd),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              statusValidasiText(
                                                  item.statusGmBsd),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        item.noPengajuan ?? 'tidak ada',
                                        style: CustomTextStyle.subtitle(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            hasNominal
                                                ? Rupiah.rupiah(item.subTotal)
                                                : 'tidak ada data',
                                            style: CustomTextStyle.title(),
                                          ),
                                          Text(
                                            ' || ${item.tglPengajuan ?? 'tidak ada'}',
                                            style: CustomTextStyle.subtitle(),
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
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Hi.edit01,
                                      ),
                                      onPressed: () {
                                        Get.to(() =>
                                                EditPengajuanItView(data: item))
                                            ?.then((value) {
                                          if (value != null) {
                                            final form = Get.find<
                                                PengajuanItBelumValidasiController>();
                                            form.updateData(
                                                PengajuanIt.fromJson(value),
                                                item.noHide!);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                  );
                }),

                // animasi loading paginasi
                Obx(() => CustomLoading().lz.hide(!controller.isPaginate.value))
              ],
            ),
          ),
        ],
      );
    });
  }
}
