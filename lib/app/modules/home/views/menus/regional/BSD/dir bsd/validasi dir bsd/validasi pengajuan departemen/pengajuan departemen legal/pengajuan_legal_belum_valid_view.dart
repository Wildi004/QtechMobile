import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/LEGAL/Pengajuan%20Legal/pengajuan_legal_belum_validasi_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20pengajuan%20departemen/pengajuan%20departemen%20legal/form_validasi_legal_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/pengajuan%20legal/pengajuan_legal_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class PengajuanLegalBelumValidView
    extends GetView<PengajuanLegalBelumValidasiController> {
  const PengajuanLegalBelumValidView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PengajuanLegalBelumValidasiController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    final icons = [
      Hi.view,
      Hi.checkList,
    ];
    final options = DropOption.of(
      [
        'Info',
        'Validasi',
      ],
      icons: icons,
      focused: [1],
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Get.back(result: true);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Unfocuser(
          child: Obx(() {
            bool isLoading = controller.isLoading.value;
            final data = controller.listPengajuan;

            if (isLoading) {
              return const Center(child: CustomLoading());
            }

            if (data.isEmpty) {
              return Empty(
                message: 'Tidak ada data.',
                onTap: () => controller.getData(),
              );
            }

            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: SearchQuery.searchInput(
                          onSubmitted: controller.updateSearchQuery,
                          controller: controller.searchC,
                          hint: 'Search...',
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
                        final bool hasNominal =
                            item.detail != null && item.detail!.isNotEmpty;
                        return Droplist(
                          options: options,
                          builder: (key, action) {
                            return CustomScalaContainer(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Container(
                                  key: key,
                                  width: itemWidth,
                                  padding: const EdgeInsets.all(10),
                                  decoration: hasNominal
                                      ? CustomDecoration.orange()
                                      : CustomDecoration.notValidator(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.noPengajuan ?? 'tidak ada',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              action.show((value) {
                                                if (value.index == 0) {
                                                  Get.to(() =>
                                                      PengajuanLegalDetailView(
                                                          data: item))?.then(
                                                      (value) {
                                                    if (int.tryParse(
                                                            item.noHide!) !=
                                                        null) {}
                                                  });
                                                } else if (value.index == 1) {
                                                  Get.to(() =>
                                                          FormValidasiLegalView(
                                                              data: item))
                                                      ?.then((value) {
                                                    if (value == true) {
                                                      controller.listPengajuan
                                                          .clear();
                                                      controller.getData();
                                                    }
                                                  });
                                                } else if (value.index == 2) {}
                                              });
                                            },
                                            icon:
                                                Icon(Hi.leftToRightListBullet),
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                      Text(
                                        item.tglPengajuan ?? 'tidak ada',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      10.height,
                                      Intrinsic(children: [
                                        const Text(
                                          'pemohon :',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        const Text(
                                          'Departemen :',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ]),
                                      Intrinsic(children: [
                                        Text(
                                          item.createdName ?? 'tidak ada',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          item.depName ?? 'tidak ada',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ])
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                      Obx(() => CustomLoading()
                          .lz
                          .hide(!controller.isPaginate.value)),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
