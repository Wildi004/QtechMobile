import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Invoice%20Delivery%20Pembelian%20Non%20PPN/inv_del_pemb_non_ppn_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/invoice%20delivery%20pembelian%20logistik/invoice%20deliveri%20pembelian%20non%20ppn/inv_del_pemb_non_ppn_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class ValidasiInvDelPembNonPpnSudahValView
    extends GetView<InvDelPembNonPpnController> {
  const ValidasiInvDelPembNonPpnSudahValView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      Get.lazyPut(() => InvDelPembNonPpnController());
      bool isLoading = controller.isLoading.value; //
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
                  return CustomScalaContainer(
                    child: Touch(
                        onTap: () {
                          Get.to(() => InvDelPembNonPpnDetailView(data: item))
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.noDelivery ?? 'tidak ada',
                                      style: CustomTextStyle.title(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    10.height,
                                    Intrinsic(
                                      children: [
                                        Text(
                                          item.suplierName ?? 'tidak ada',
                                          style: CustomTextStyle.subtitle(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: statusValidasiColor(
                                                item.statusGm),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            statusValidasiText(item.statusGm),
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
                                        'Tgl. Inv :',
                                        style: CustomTextStyle.subtitle(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Tgl. Dibuat :',
                                        style: CustomTextStyle.subtitle(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ]),
                                    Intrinsic(children: [
                                      Text(
                                        item.tglInv ?? 'tidak ada',
                                        style: CustomTextStyle.subtitle(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        item.tglDibuat ?? 'tidak ada',
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
