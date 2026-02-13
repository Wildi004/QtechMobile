import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pemb_non_ppn/pemb_non_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/Logistik%20Jakarta/Pembelian%20Non%20PPN%20Logistik%20Jkt/pemb_jkt_non_ppn_belum_validasi_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/pembelian%20non%20ppn%20jkt/pemb_non_ppn_jkt_detail_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/pembelian%20non%20ppn%20logistik/edit_pemb_non_ppn_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class PembNonPpnJktBelumValidasiView
    extends GetView<PembJktNonPpnBelumValidasiController> {
  const PembNonPpnJktBelumValidasiView({super.key});

  @override
  Widget build(BuildContext context) {
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
        Get.lazyPut(() => PembJktNonPpnBelumValidasiController());
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
                    return Droplist(
                        options: options,
                        builder: (key, action) {
                          return CustomScalaContainer(
                            child: Touch(
                                margin: Ei.only(b: 10),
                                child: Container(
                                  key: key,
                                  width: itemWidth,
                                  padding: const EdgeInsets.all(10),
                                  decoration: CustomDecoration.notValidator(),
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
                                                    item.noPembelianNonppn ??
                                                        'tidak ada',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                        Get.to(() =>
                                                            PembNonPpnJktDetailView(
                                                                data:
                                                                    item))?.then(
                                                            (value) {
                                                          if (int.tryParse(item
                                                                  .noHide!) !=
                                                              null) {}
                                                        });
                                                      } else if (value.index ==
                                                          1) {
                                                        Get.to(() =>
                                                            EditPembNonPpnView(
                                                                data:
                                                                    item))?.then(
                                                            (value) {
                                                          if (value != null) {
                                                            final form = Get.find<
                                                                PembJktNonPpnBelumValidasiController>();
                                                            form.updateData(
                                                                PembNonPpn
                                                                    .fromJson(
                                                                        value),
                                                                item.noHide!);
                                                          }
                                                        });
                                                      } else if (value.index ==
                                                          2) {
                                                        CustomDelete.show(
                                                          title:
                                                              'Konfirmasi Hapus',
                                                          message:
                                                              'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                                          context: context,
                                                          onConfirm: () {
                                                            controller
                                                                .deleteData(item
                                                                    .noHide!);
                                                          },
                                                        );
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
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            10.height,
                                            Row(children: [
                                              Text(
                                                'No. Inv : ',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                item.noInvoice ?? 'tidak ada',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ]),
                                            Row(children: [
                                              Text(
                                                'TGL PO : ',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                item.tglBeli ?? 'tidak ada',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
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
