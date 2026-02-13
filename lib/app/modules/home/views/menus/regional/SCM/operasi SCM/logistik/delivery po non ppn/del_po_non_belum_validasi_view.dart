import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_po_non_ppn/del_po_non_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Del%20PO%20Non%20PPN/del_po_non_belum_validasi_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/delivery%20po%20non%20ppn/del_po_non_detail_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/delivery%20po%20non%20ppn/edit_del_po_non_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class DelPoNonBelumValidasiView
    extends GetView<DelPoNonBelumValidasiController> {
  const DelPoNonBelumValidasiView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DelPoNonBelumValidasiController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    final icons = [
      Hi.view,
      Hi.edit01,
      Hi.delete01,
    ];

    final options = DropOption.of(
      ['Info', 'Edit', 'Delete'],
      critical: ['Delete'],
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
                                                  data: item))?.then((value) {
                                                if (int.tryParse(
                                                        item.noHide!) !=
                                                    null) {}
                                              });
                                            } else if (value.index == 1) {
                                              Get.to(() => EditDelPoNonView(
                                                  data: item))?.then((value) {
                                                if (value != null) {
                                                  final form = Get.find<
                                                      DelPoNonBelumValidasiController>();
                                                  form.updateData(
                                                      DelPoNonPpn.fromJson(
                                                          value),
                                                      item.noHide!);
                                                }
                                              });
                                            } else if (value.index == 2) {
                                              CustomDelete.show(
                                                title: 'Konfirmasi Hapus',
                                                message:
                                                    'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                                context: context,
                                                onConfirm: () {
                                                  controller.deleteData(
                                                      item.noHide ?? '');
                                                },
                                              );
                                            }
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
