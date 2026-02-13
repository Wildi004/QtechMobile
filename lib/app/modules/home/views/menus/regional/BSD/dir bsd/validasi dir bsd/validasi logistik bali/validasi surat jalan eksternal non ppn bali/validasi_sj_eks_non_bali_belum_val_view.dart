import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Surat%20Jalan%20Logistik/surat%20jalan%20eksternal%20non/surat_jalan_exst_non_belum_val_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Surat%20Jalan%20Logistik/surat%20jalan%20eksternal%20non/surat_jalan_exst_non_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20bali/validasi%20surat%20jalan%20eksternal%20non%20ppn%20bali/form_validasi_sj_eks_non_bali_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/surat%20jalan%20logistik/surat%20jalan%20eksternal%20non%20ppn/surat_jalan_exst_non_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class ValidasiSjEksNonBaliBelumValView
    extends GetView<SuratJalanExstNonBelumValController> {
  const ValidasiSjEksNonBaliBelumValView({super.key});

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
        Get.lazyPut(() => SuratJalanExstNonBelumValController());
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
                                decoration: CustomDecoration.validator(),
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
                                                  item.noPo ?? 'tidak ada',
                                                  style:
                                                      CustomTextStyle.title(),
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
                                                        FormValidasiSjEksNonBaliView(
                                                            data: item),
                                                      ).then((value) {
                                                        if (value == true) {
                                                          // pindah tab
                                                          final internal = Get.find<
                                                              SuratJalanExstNonController>();
                                                          internal.tab.value =
                                                              1;

                                                          final belum = Get.find<
                                                              SuratJalanExstNonBelumValController>();
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
                                                          SuratJalanExstNonDetailView(
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
                                              )
                                            ],
                                          ),
                                          10.height,
                                          Intrinsic(
                                            children: [
                                              Text(
                                                item.noBukti ?? 'tidak ada',
                                                style: CustomTextStyle.title(),
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
                                                      item.statusGmBali),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  statusValidasiText(
                                                      item.statusGmBali),
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
                                              'Ditujukan :',
                                              style: CustomTextStyle.subtitle(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              'Tgl :',
                                              style: CustomTextStyle.subtitle(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ]),
                                          Intrinsic(children: [
                                            Text(
                                              item.namaPerusahaan ??
                                                  'tidak ada',
                                              style: CustomTextStyle.subtitle(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              item.tgl ?? 'tidak ada',
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
