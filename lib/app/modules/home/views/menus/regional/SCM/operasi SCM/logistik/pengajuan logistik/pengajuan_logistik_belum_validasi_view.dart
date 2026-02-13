import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pengajuan_logistik/pengajuan_logistik.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Pengajuan%20Logistik/pengajuan_logistik_belum_validasi_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/pengajuan%20logistik/edit_pengajuan_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/pengajuan%20logistik/pengajuan_logistik_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_format.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class PengajuanLogistikBelumValidasiView
    extends GetView<PengajuanLogistikBelumValidasiController> {
  const PengajuanLogistikBelumValidasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      Get.lazyPut(() => PengajuanLogistikBelumValidasiController());
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

                  return CustomScalaContainer(
                    child: Touch(
                        onTap: () {
                          Get.to(() => PengajuanLogistikDetailView(data: item))
                              ?.then((value) {
                            if (int.tryParse(item.noHide!) != null) {}
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
                                      Get.to(() => EditPengajuanLogistikView(
                                          data: item))?.then((value) {
                                        if (value != null) {
                                          final form = Get.find<
                                              PengajuanLogistikBelumValidasiController>();
                                          form.updateData(
                                              PengajuanLogistik.fromJson(value),
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
