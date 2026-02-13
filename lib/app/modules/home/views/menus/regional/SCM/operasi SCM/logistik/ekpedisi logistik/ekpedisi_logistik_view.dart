import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/ekpedisi.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Ekpedisi%20Logistik/ekpedisi_logistik_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/ekpedisi%20logistik/create_ekpedisi_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/ekpedisi%20logistik/ekpedisi_logistik_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class EkpedisiLogistikView extends GetView<EkpedisiLogistikController> {
  const EkpedisiLogistikView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EkpedisiLogistikController());
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
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Ekpedisi',
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => CreateEkpedisiView())?.then((data) {
                    if (data != null) {
                      controller.insertData(Ekpedisi.fromJson(data));
                    }
                  });
                },
                icon: Icon(Hi.add01))
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
              message: 'Tidak ada Surat Keluar.',
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
                                key: key,
                                width: itemWidth,
                                padding: const EdgeInsets.all(10),
                                decoration: CustomDecoration.validator(),
                                child: Column(
                                  crossAxisAlignment: Caa.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.nama ?? '-',
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins()
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontWeight: Fw.bold),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            action.show((value) {
                                              if (value.index == 0) {
                                                Get.to(() =>
                                                    EkpedisiLogistikDetailView(
                                                        data: item))?.then(
                                                    (value) {});
                                              } else if (value.index == 1) {
                                                Get.to(() => CreateEkpedisiView(
                                                    data: item))?.then((value) {
                                                  if (value != null) {
                                                    controller.updateData(
                                                      Ekpedisi.fromJson(value),
                                                      item.id!,
                                                    );
                                                  }
                                                });
                                              } else if (value.index == 2) {
                                                CustomDelete.show(
                                                  context: context,
                                                  title: 'Konfirmasi Hapus',
                                                  message:
                                                      'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                                  onConfirm: () {
                                                    controller
                                                        .deleteData(item.id!);
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
                                    Row(
                                      children: [
                                        const Icon(
                                          Hi.call02,
                                          color: Colors.white,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                ' ${item.noHp}',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: Fw.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Container(
                                                height: 1,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    15.height,
                                    Text(
                                      item.cp ?? '-',
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins().copyWith(
                                          color: Colors.white,
                                          fontWeight: Fw.bold),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Hi.call02,
                                          color: Colors.white,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                ' ${item.hpCp}',
                                                style: GoogleFonts.poppins()
                                                    .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: Fw.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Container(
                                                height: 1,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    15.height,
                                    Row(
                                      mainAxisAlignment: Maa.spaceBetween,
                                      children: [
                                        Text(
                                          ' ${item.jenis}',
                                          style: GoogleFonts.poppins().copyWith(
                                            color: Colors.white,
                                            fontWeight: Fw.bold,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: getStatusColor(
                                                item.status ?? 0),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: getStatusColor(
                                                    item.status ?? 0)),
                                          ),
                                          child: Text(
                                            getStatusLabel(item.status ?? 0),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: Fw.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
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
      ),
    );
  }
}

String getStatusLabel(int status) {
  switch (status) {
    case 0:
      return 'Warning';
    case 1:
      return 'Aktif';
    case 2:
      return '--';
    case 3:
      return '--';
    case 4:
      return '--';
    default:
      return 'Tidak diketahui';
  }
}

Color getStatusColor(int status) {
  switch (status) {
    case 0:
      return Colors.orange;
    case 1:
      return Colors.blue;
    case 2:
      return Colors.red;
    case 3:
      return Colors.green;

    case 4:
      return Colors.grey;
    default:
      return Colors.black54;
  }
}
