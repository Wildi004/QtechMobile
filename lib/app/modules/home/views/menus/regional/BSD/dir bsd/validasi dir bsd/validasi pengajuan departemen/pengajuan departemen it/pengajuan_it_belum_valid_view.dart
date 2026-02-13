import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Pengajuan%20It/pengajuan_it_belum_validasi_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20pengajuan%20departemen/pengajuan%20departemen%20it/form_validasi_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/pengajuan%20it/detail_pengajuan_it_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class PengajuanItBelumValidView
    extends GetView<PengajuanItBelumValidasiController> {
  const PengajuanItBelumValidView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PengajuanItBelumValidasiController());
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
                                  decoration: CustomDecoration.validator(),
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
                                              style: CustomTextStyle.title(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              action.show((value) {
                                                if (value.index == 0) {
                                                  Get.to(() =>
                                                          DetailPengajuanItView(
                                                              data: item))
                                                      ?.then((value) {
                                                    if (int.tryParse(
                                                            item.noHide!) !=
                                                        null) {}
                                                  });
                                                } else if (value.index == 1) {
                                                  Get.to(() =>
                                                          FormValidasiItView(
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
                                          )
                                        ],
                                      ),
                                      Intrinsic(
                                        children: [
                                          Text(
                                            item.tglPengajuan ?? 'tidak ada',
                                            style: CustomTextStyle.subtitle(),
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
                                      10.height,
                                      Intrinsic(children: [
                                        Text(
                                          'pemohon :',
                                          style: CustomTextStyle.subtitle(),
                                        ),
                                        Text(
                                          'Departemen :',
                                          style: CustomTextStyle.subtitle(),
                                        ),
                                      ]),
                                      Intrinsic(children: [
                                        Text(
                                          item.createdName ?? 'tidak ada',
                                          style: CustomTextStyle.subtitle(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          item.depName ?? 'tidak ada',
                                          style: CustomTextStyle.subtitle(),
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
