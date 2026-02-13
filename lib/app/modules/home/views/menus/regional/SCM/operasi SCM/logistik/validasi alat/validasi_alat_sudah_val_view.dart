import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Validasi%20Alat%20Logistik/validasi_alat_controller.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class ValidasiAlatSudahValView extends GetView<ValidasiAlatController> {
  const ValidasiAlatSudahValView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ValidasiAlatController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    final icons = [
      Hi.view,
      Hi.edit01,
      Hi.edit01,
      Hi.delete01,
    ];

    final options = DropOption.of(
      ['Info', 'Edit', 'Kode Proyek', 'Delete'],
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
                                          item.noPengajuan ??
                                              'Tidak Ada Kode Proyek',
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
                                              // Get.to(() => PoPpnDetailView(
                                              //     data: item))?.then((value) {
                                              //   if (int.tryParse(
                                              //           item.noHide!) !=
                                              //       null) {}
                                              // });
                                              // } else if (value.index == 1) {
                                              //   Get.to(() =>
                                              //           EditPoPpnLogistikView(
                                              //               data: item))
                                              //       ?.then((value) {
                                              //     if (value != null) {
                                              //       final form = Get.find<
                                              //           PoPpnLogistikBelumValidasiController>();
                                              //       form.updateData(
                                              //           PoPpn.fromJson(value),
                                              //           item.noHide!);
                                              //     }
                                              //   });
                                            } else if (value.index == 2) {
                                            } else if (value.index == 3) {
                                              // CustomDelete.show(
                                              //   title: 'Konfirmasi Hapus',
                                              //   message:
                                              //       'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                              //   context: context,
                                              //   onConfirm: () {
                                              //     controller.deleteData(
                                              //         item.noHide ?? '');
                                              //   },
                                              // );
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
                                          text: 'Nama alat : ',
                                          style: GoogleFonts.poppins().copyWith(
                                            color: Colors.white,
                                            fontWeight:
                                                Fw.bold, // hanya head yang bold
                                          ),
                                        ),
                                        TextSpan(
                                          text: item.alat?.namaAlat ?? '-',
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
                                          text: 'Status : ',
                                          style: GoogleFonts.poppins().copyWith(
                                            color: Colors.white,
                                            fontWeight: Fw.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: item.alat?.status.toString(),
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
                                          text: 'Lama Pakai : ',
                                          style: GoogleFonts.poppins().copyWith(
                                            color: Colors.white,
                                            fontWeight: Fw.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '${item.fromDate ?? '-'} - ${item.toDate ?? '-'} (${item.lamaHari ?? 0} hari)',
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
