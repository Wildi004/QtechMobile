import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Po%20Ppn/po_ppn_logistik_belum_validasi_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Po%20Ppn/po_ppn_logistik_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20bali/validasi%20po%20ppn/form_validasi_po_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/po%20ppn/po_ppn_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class ValidasiPoPpnBelumValView
    extends GetView<PoPpnLogistikBelumValidasiController> {
  const ValidasiPoPpnBelumValView({super.key});

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
        Get.lazyPut(() => PoPpnLogistikBelumValidasiController());
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
                                          Intrinsic(
                                            children: [
                                              Text(
                                                item.noPo ?? 'tidak ada',
                                                style: CustomTextStyle.title(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  action.show((value) {
                                                    if (value.index == 0) {
                                                      Get.to(
                                                        FormValidasiPoPpnView(
                                                            data: item),
                                                      )?.then((value) {
                                                        if (value == true) {
                                                          // pindah tab
                                                          final internal = Get.find<
                                                              PoPpnLogistikController>();
                                                          internal.tab.value =
                                                              1;

                                                          final belum = Get.find<
                                                              PoPpnLogistikBelumValidasiController>();
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
                                                              PoPpnDetailView(
                                                                  data: item))
                                                          ?.then((value) {
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
                                          Text(
                                            item.suplierName ?? 'tidak ada',
                                            style: CustomTextStyle.title(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          10.height,
                                          Intrinsic(children: [
                                            Text(
                                              'TGL PO :',
                                              style: CustomTextStyle.subtitle(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                color: statusValidasiColor(
                                                    item.statusDirKeuangan),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                statusValidasiText(
                                                    item.statusDirKeuangan),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ]),
                                          Intrinsic(children: [
                                            Text(
                                              item.tglPo ?? 'tidak ada',
                                              style: CustomTextStyle.subtitle(),
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

  if (number is String) {
    number = int.tryParse(number) ?? 0;
  }

  return NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  ).format(number);
}
