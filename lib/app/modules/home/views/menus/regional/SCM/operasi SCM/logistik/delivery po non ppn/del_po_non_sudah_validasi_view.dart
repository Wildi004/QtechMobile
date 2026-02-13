import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Del%20PO%20Non%20PPN/del_po_non_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/delivery%20po%20non%20ppn/del_po_non_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class DelPoNonSudahValidasiView extends GetView<DelPoNonController> {
  const DelPoNonSudahValidasiView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DelPoNonController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    final icons = [
      Hi.view,
    ];

    final options = DropOption.of(
      [
        'Info',
      ],
      icons: icons,
      focused: [1],
    );
    return Unfocuser(
      child: Obx(() {
        bool isLoading = controller.isLoading.value;
        final data = controller.listData;

        if (isLoading) {
          return Center(child: CustomLoading());
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
            Expanded(
              child: LzListView(
                padding: Ei.sym(
                  h: 20,
                ),
                onRefresh: () => controller.getData(),
                onScroll: (scroll) {
                  if (scroll.atBottom(100)) {
                    controller.onPaginate();
                  }
                },
                children: [
                  SizedBox(height: 10),
                  ...data.generate((item, i) {
                    return Droplist(
                      options: options,
                      builder: (key, action) {
                        return CustomScalaContainer(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              key:
                                  key, // penting supaya droplist tau element yg dibungkus
                              width: itemWidth,
                              padding: const EdgeInsets.all(10),
                              decoration: CustomDecoration.validator(),
                              child: Column(
                                crossAxisAlignment: Caa.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: Maa.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.noPo ?? 'Tidak Ada Kode Proyek',
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins().copyWith(
                                              color: Colors.white,
                                              fontWeight: Fw.bold),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          action.show((value) {
                                            if (value.index == 0) {
                                              Get.to(() => DelPoNonDetailView(
                                                      data: item))
                                                  ?.then((value) {});
                                            } else if (value.index == 1) {}
                                          });
                                        },
                                        icon: Icon(Hi.leftToRightListBullet),
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Nama Suplier : ',
                                          style: GoogleFonts.poppins().copyWith(
                                            color: Colors.white,
                                            fontWeight:
                                                Fw.bold, // hanya head yang bold
                                          ),
                                        ),
                                        TextSpan(
                                          text: item.noDelivery ?? '-',
                                          style: GoogleFonts.poppins().copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Shipment Date : ',
                                          style: GoogleFonts.poppins().copyWith(
                                            color: Colors.white,
                                            fontWeight: Fw.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: item.shipmentDate ?? '-',
                                          style: GoogleFonts.poppins().copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Received Date : ',
                                          style: GoogleFonts.poppins().copyWith(
                                            color: Colors.white,
                                            fontWeight: Fw.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: item.receivedDate ?? '-',
                                          style: GoogleFonts.poppins().copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  Obx(() =>
                      CustomLoading().lz.hide(!controller.isPaginate.value)),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
