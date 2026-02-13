import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/arsip_perusahaan.dart';
import 'package:qrm_dev/app/modules/home/controllers/Arsip%20Perusahaan/arsip_perusahaan_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/arsip%20perusahaan/arsip_perusahaan_detail_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/arsip%20perusahaan/create_arsip_perusahaan_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class ArsipPerusahaanView extends GetView<ArsipPerusahaanController> {
  const ArsipPerusahaanView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ArsipPerusahaanController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    final icons = [
      Hi.eye,
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
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Arsip Perusahaan',
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => CreateArsipPerusahaanView())?.then((data) {
                  if (data != null) {
                    controller.insertData(ArsipPerusahaan.fromJson(data));
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
                      return ListItemAnimasi(
                        index: i,
                        beginOffset: const Offset(-0.3, 0),
                        child: Droplist(
                          options: options,
                          builder: (key, action) {
                            return CustomScalaContainer(
                              child: Touch(
                                key: key,
                                onTap: () {
                                  action.show((value) async {
                                    if (value.index == 0) {
                                      Get.to(() => ArsipPerusahaanDetailView(
                                          data: item));
                                    } else if (value.index == 1) {
                                      // edit data
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
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.nama ?? '-',
                                          maxLines: 99,
                                          overflow: TextOverflow.ellipsis,
                                          style: CustomTextStyle.title(),
                                        ),
                                      ),
                                      Icon(
                                        Hi.menu01,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
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
