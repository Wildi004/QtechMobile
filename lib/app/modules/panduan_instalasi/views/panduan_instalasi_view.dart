import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/panduan_instalasi.dart';
import 'package:qrm_dev/app/modules/panduan_instalasi/controllers/panduan_instalasi_controller.dart';
import 'package:qrm_dev/app/modules/panduan_instalasi/views/create_panduan_instal_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';
import 'package:url_launcher/url_launcher.dart';

class PanduanInstalasiView extends GetView<PanduanInstalasiController> {
  const PanduanInstalasiView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PanduanInstalasiController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    final icons = [
      Hi.global,
      Hi.edit01,
      Hi.delete01,
    ];

    final options = DropOption.of(
      ['Kunjungi', 'Edit', 'Delete'],
      critical: ['Delete'],
      icons: icons,
      focused: [1],
    );

    return Unfocuser(
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Panduan Instalasi',
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => CreatePanduanInstalView())!.then((data) {
                  if (data != null && data is List) {
                    controller.insertData(
                      PanduanInstalasi.fromJson(data.first),
                    );
                  }
                });
              },
              icon: Icon(Hi.add01),
            )
          ],
        ).appBar,
        resizeToAvoidBottomInset: false,
        body: Obx(() {
          bool isLoading = controller.isLoading.value;
          final data = controller.listData;

          if (isLoading) {
            return Center(child: CustomLoading());
          }

          if (data.isEmpty) {
            return Empty(
              message: 'Tidak ada Data Akun.',
              onTap: () => controller.getData(),
            );
          }

          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                  padding: Ei.sym(h: 20),
                  onRefresh: () => controller.getData(),
                  onScroll: (scroll) {
                    if (scroll.atBottom(100)) {
                      controller.onPaginate();
                    }
                  },
                  children: [
                    SizedBox(height: 20),
                    ...data.generate((item, i) {
                      return Droplist(
                        options: options,
                        builder: (key, action) {
                          return ListItemAnimasi(
                            index: i,
                            beginOffset: const Offset(-0.3, 0),
                            child: CustomScalaContainer(
                              child: Touch(
                                key: key,
                                onTap: () {
                                  action.show((value) async {
                                    if (value.index == 0) {
                                      final url = item.link ?? '';
                                      if (url.isNotEmpty) {
                                        final uri = Uri.parse(url);
                                        if (await canLaunchUrl(uri)) {
                                          await launchUrl(
                                            uri,
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        } else {
                                          Get.snackbar(
                                            'Gagal',
                                            'Tidak dapat membuka website',
                                          );
                                        }
                                      }
                                      // } else if (value.index == 1) {
                                      //   Get.to(() =>
                                      //           CreateDataAkunView(data: item))
                                      //       ?.then((value) {
                                      //     if (value != null) {
                                      //       controller.updateData(
                                      //         DataAkun.fromJson(value),
                                      //         item.id!,
                                      //       );
                                      //     }
                                      //   });
                                    } else if (value.index == 2) {
                                      CustomDelete.show(
                                        context: context,
                                        title: 'Konfirmasi Hapus',
                                        message:
                                            'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                        onConfirm: () {
                                          controller.deleteData(item.id!);
                                        },
                                      );
                                    }
                                  });
                                },
                                margin: Ei.only(b: 10),
                                child: Container(
                                  width: itemWidth,
                                  padding: const EdgeInsets.all(20),
                                  decoration: CustomDecoration.validator(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item.nama ?? '-',
                                              maxLines: 99,
                                              overflow: TextOverflow.ellipsis,
                                              style: CustomTextStyle.title(),
                                            ),
                                          ),
                                          const Icon(Hi.menu01),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        item.tglUpload ?? '-',
                                        maxLines: 99,
                                        overflow: TextOverflow.ellipsis,
                                        style: CustomTextStyle.title(),
                                      ),
                                    ],
                                  ),
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
      ),
    );
  }
}
