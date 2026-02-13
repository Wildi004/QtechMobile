import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/pengajuan%20global/pengajuan%20sudah%20validasi/pengajuan_sudah_validasi/pengajuan_sudah_validasi.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_pengajuan_controller/belum_validasi_pengajuan_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/pengajuan_hrd/detail_pengajuan_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/pengajuan_hrd/edit_pengajuan_hrd_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_format.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class BelumValidasiPengajuanView
    extends GetView<BelumValidasiPengajuanController> {
  const BelumValidasiPengajuanView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      Get.lazyPut(() => BelumValidasiPengajuanController());
      bool isLoading = controller.isLoading.value;
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
                SizedBox(width: 10),
              ],
            ),
          ),
          20.height,
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

                  return CustomScalaContainer(
                    child: Touch(
                        onTap: () {
                          Get.to(() => DetailPengajuanHrdView(data: item))
                              ?.then((value) {
                            if (int.tryParse(item.noHide!) != null) {
                              controller.updateData(
                                  PengajuanSudahValidasi.fromJson(value),
                                  (item.noHide!));
                            }
                          });
                        },
                        margin: Ei.only(b: 10),
                        child: Container(
                          width: itemWidth,
                          padding: const EdgeInsets.all(10),
                          decoration: hasNominal
                              ? CustomDecoration.orange()
                              : CustomDecoration.notValidator(),
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
                                            hasNominal
                                                ? Rupiah.rupiah(item.subTotal)
                                                : 'tidak ada data',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: hasNominal
                                                  ? Colors.white
                                                  : const Color.fromARGB(
                                                      137, 255, 255, 255),
                                              fontSize: 13,
                                            )),
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
                                children: [
                                  IconButton(
                                    icon: const Icon(Hi.edit01,
                                        color: Colors.white),
                                    onPressed: () {
                                      Get.to(() =>
                                              EditPengajuanHrdView(data: item))
                                          ?.then((value) {
                                        if (value != null) {
                                          final form = Get.find<
                                              BelumValidasiPengajuanController>();
                                          form.updateData(
                                            PengajuanSudahValidasi.fromJson(
                                                value),
                                            item.noHide!,
                                          );
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
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
