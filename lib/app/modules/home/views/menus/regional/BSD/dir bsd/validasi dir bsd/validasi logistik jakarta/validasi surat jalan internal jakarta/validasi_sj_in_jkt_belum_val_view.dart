import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/Logistik%20Jakarta/Surat%20Jalan%20Logistik%20Jkt/surat%20jalan%20internal%20jkt/surat_jalan_internal_jkt_belum_val_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/Logistik%20Jakarta/Surat%20Jalan%20Logistik%20Jkt/surat%20jalan%20internal%20jkt/surat_jalan_internal_jkt_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20jakarta/validasi%20surat%20jalan%20internal%20jakarta/form_validasi_sj_in_jkt_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/surat%20jalan%20logistik/surat%20jalan%20internal/surat_jalan_internal_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class ValidasiSjInJktBelumValView
    extends GetView<SuratJalanInternalJktBelumValController> {
  const ValidasiSjInJktBelumValView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    final icons = [
      Hi.checkList,
      Hi.eye,
    ];

    final options = DropOption.of(
      ['Validasi', 'Info'],
      icons: icons,
      focused: [1],
    );

    return Unfocuser(
      child: Obx(() {
        Get.lazyPut(() => SuratJalanInternalJktBelumValController());
        bool isLoading = controller.isLoading.value;
        final data = controller.listData;
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

                    return Droplist(
                        options: options,
                        builder: (key, action) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: CustomScalaContainer(
                              child: Container(
                                key: key,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  item.noPengajuan ??
                                                      'tidak ada',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  action.show((value) {
                                                    if (value.index == 0) {
                                                      Get.dialog(
                                                        FormValidasiSjInJktView(
                                                            data: item),
                                                      ).then((value) {
                                                        if (value == true) {
                                                          // pindah tab
                                                          final internal = Get.find<
                                                              SuratJalanInternalJktController>();
                                                          internal.tab.value =
                                                              1;

                                                          final belum = Get.find<
                                                              SuratJalanInternalJktBelumValController>();
                                                          belum.listData
                                                              .removeWhere((e) =>
                                                                  e.noHide ==
                                                                  item.noHide);

                                                          internal.listData
                                                              .clear();
                                                          internal.getData();
                                                        }
                                                      });
                                                    } else if (value.index ==
                                                        1) {
                                                      Get.to(() =>
                                                          SuratJalanInternalDetailView(
                                                              data:
                                                                  item))?.then(
                                                          (value) {
                                                        if (int.tryParse(
                                                                item.noHide!) !=
                                                            null) {}
                                                      });
                                                    }
                                                  });
                                                },
                                                icon: Icon(
                                                    Hi.leftToRightListBullet),
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                          10.height,
                                          Text(
                                            item.noBukti ?? 'tidak ada',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          10.height,
                                          Intrinsic(children: [
                                            Text(
                                              'Ditujukan :',
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              'Tgl :',
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ]),
                                          Intrinsic(children: [
                                            Text(
                                              item.ditujukan ?? 'tidak ada',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              item.tgl ?? 'tidak ada',
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
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }),
                  // animasi loading paginasi
                  Obx(() =>
                      CustomLoading().lz.hide(!controller.isPaginate.value))
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

String rupiah(dynamic number) {
  if (number == null) return 'Rp 0';

  // jika String → convert ke int
  if (number is String) {
    number = int.tryParse(number) ?? 0;
  }

  return NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  ).format(number);
}
