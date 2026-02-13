import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/validasi%20cuti/validasi_cuti_belum_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20cuti/form_validasi_cuti_bsd_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class ValidasiCutiBelumValidasiView
    extends GetView<ValidasiCutiBelumController> {
  const ValidasiCutiBelumValidasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      Get.lazyPut(() => ValidasiCutiBelumController());
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
                          Get.to(() => FormValidasiCutiBsdView(data: item));
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
                                      item.userName ?? 'tidak ada',
                                      style: CustomTextStyle.title(),
                                    ),
                                    Text(
                                      item.keterangan ?? 'tidak ada',
                                      style: CustomTextStyle.subtitle(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    10.height,
                                    Intrinsic(children: [
                                      Text(
                                        'Dari :',
                                        style: CustomTextStyle.title(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Sampai :',
                                        style: CustomTextStyle.title(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ]),
                                    Intrinsic(children: [
                                      Text(
                                        item.cutiFrom ?? 'tidak ada',
                                        style: CustomTextStyle.subtitle(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        item.cutiTo ?? 'tidak ada',
                                        style: CustomTextStyle.subtitle(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ]),
                                    10.height,
                                    Intrinsic(children: [
                                      Text(
                                        'HRD :',
                                        style: CustomTextStyle.title(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Dir. BSD :',
                                        style: CustomTextStyle.title(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ]),
                                    Intrinsic(children: [
                                      Text(
                                        statusText(item.statusHrd),
                                        style: CustomTextStyle.subtitle(
                                          color: statusBgColor(item.statusHrd),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        statusText(item.statusDirKeuangan),
                                        style: CustomTextStyle.subtitle(
                                          color: statusBgColor(
                                              item.statusDirKeuangan),
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
  return NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  ).format(number);
}

String statusText(int? status) {
  switch (status) {
    case 0:
      return 'Pending';
    case 1:
      return 'ACC';
    case 2:
      return 'Tolak';
    default:
      return '-';
  }
}

Color statusBgColor(int? status) {
  switch (status) {
    case 0:
      return Colors.orange;
    case 1:
      return Colors.green;
    case 2:
      return Colors.red;
    default:
      return Colors.grey;
  }
}
