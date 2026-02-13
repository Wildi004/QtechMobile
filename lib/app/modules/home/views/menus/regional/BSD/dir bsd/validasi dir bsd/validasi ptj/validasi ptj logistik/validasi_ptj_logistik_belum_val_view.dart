import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/Validasi%20PTJ/validasi%20ptj%20logistik/validasi_ptj_logistik_belum_val_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/Validasi%20PTJ/validasi%20ptj%20logistik/validasi_ptj_logistik_sudah_val_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20ptj/validasi%20ptj%20logistik/form_validasi_ptj_logistik_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_format.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class ValidasiPtjLogistikBelumValView
    extends GetView<ValidasiPtjLogistikBelumValController> {
  const ValidasiPtjLogistikBelumValView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      Get.lazyPut(() => ValidasiPtjLogistikBelumValController());
      bool isLoading = controller.isLoading.value; //
      final data = controller.listPtj;
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
                      item.detailPtj != null && item.detailPtj!.isNotEmpty;
                  return CustomScalaContainer(
                    child: Touch(
                        onTap: () {
                          Get.to(() => FormValidasiPtjLogistikView(data: item))
                              ?.then((value) {
                            if (value == true) {
                              final internal = Get.find<
                                  ValidasiPtjLogistikSudahValController>();
                              internal.tab.value = 1;

                              final belum = Get.find<
                                  ValidasiPtjLogistikBelumValController>();
                              belum.listPtj
                                  .removeWhere((e) => e.noHide == item.noHide);

                              internal.listPtj.clear();
                              internal.getData();
                            }
                          });
                        },
                        margin: Ei.only(b: 10),
                        child: Container(
                          width: itemWidth,
                          padding: EdgeInsets.all(10),
                          decoration: CustomDecoration.validator(),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: Maa.spaceBetween,
                                      children: [
                                        Text(
                                          item.noPtj ?? 'tidak ada',
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
                                    10.height,
                                    Text(
                                      item.createdName ?? 'tidak ada',
                                      style: CustomTextStyle.title(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Intrinsic(children: [
                                      Text(
                                        'Tgl. Pengajuan :',
                                        style: CustomTextStyle.title(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Total Penggunaan :',
                                        style: CustomTextStyle.title(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ]),
                                    Intrinsic(children: [
                                      Text(
                                        item.tglPtj ?? 'tidak ada',
                                        style: CustomTextStyle.subtitle(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        hasNominal
                                            ? Rupiah.rupiah(
                                                num.tryParse(item.total ?? '0'))
                                            : 'tidak ada data',
                                        style: CustomTextStyle.subtitle(),
                                      ),
                                    ])
                                  ],
                                ),
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
