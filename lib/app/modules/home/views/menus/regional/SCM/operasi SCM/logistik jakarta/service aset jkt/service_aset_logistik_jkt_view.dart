import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/service_aset/service_aset.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Service%20Aset%20Logistik/service_aset_logistik_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/Logistik%20Jakarta/Service%20Aset%20Logistik%20jkt/service_aset_logistik_jkt_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/service%20aset%20jkt/create_service_aset_logistik_jkt_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/service%20aset%20jkt/create_service_kendaraan_logiastik_jkt_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/service%20aset%20jkt/service_aset_detail_logistik_jkt_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/service%20aset/edit_service_aset_logistik_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/custom_show_menu.dart';

class ServiceAsetLogistikJktView
    extends GetView<ServiceAsetLogistikJktController> {
  const ServiceAsetLogistikJktView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ServiceAsetLogistikJktController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Service Aset',
        actions: [
          IconButton(
              onPressed: () {
                CustomShowMenu.showDialogWithOptions(
                  context,
                  title: 'Pilih Service',
                  options: [
                    DialogOption(
                        label: '+ Service Aset Lainnya',
                        onTap: () =>
                            Get.to(() => CreateServiceAsetLogistikJktView())
                                ?.then((data) {
                              if (data != null) {
                                controller
                                    .insertData(ServiceAset.fromJson(data));
                              }
                            })),
                    DialogOption(
                        label: '+ Service Aset Kendaraan',
                        onTap: () => Get.to(() =>
                                    CreateServiceKendaraanLogiastikJktView())
                                ?.then((data) {
                              if (data != null) {
                                controller
                                    .insertData(ServiceAset.fromJson(data));
                              }
                            })),
                  ],
                );
              },
              icon: Icon(Hi.add01))
        ],
      ).appBar,
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        bool isLoading = controller.isLoading.value;
        final data = controller.datas;

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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SearchQuery.searchInput(
                      onChanged: controller.updateSearchQuery,
                    ),
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
                  SizedBox(height: 10),
                  ...data.generate((item, i) {
                    return CustomScalaContainer(
                      child: Touch(
                        onTap: () {
                          Get.to(() =>
                                  ServiceAsetDetailLogistikJktView(data: item))
                              ?.then((value) {});
                        },
                        margin: Ei.only(b: 10),
                        child: Container(
                          width: itemWidth,
                          padding: const EdgeInsets.all(10),
                          decoration: CustomDecoration.validator(),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.detailAset?.namaAset ?? '-',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins().copyWith(
                                      color: Colors.white, fontWeight: Fw.bold),
                                ),
                              ),

                              IconButton(
                                icon:
                                    const Icon(Hi.edit01, color: Colors.white),
                                onPressed: () {
                                  Get.to(() => EditServiceAsetLogistikView(
                                      data: item))?.then((value) {
                                    if (value != null) {
                                      final form = Get.find<
                                          ServiceAsetLogistikController>();
                                      form.updateData(
                                        ServiceAset.fromJson(value),
                                        item.id!,
                                      );
                                    }
                                  });
                                },
                              ),
                              // IconButton(
                              //   padding: EdgeInsets.zero,
                              //   onPressed: () {
                              //     Get.to(() => EditServiceAsetLogistikView(
                              //         data: item))?.then((value) {
                              //       if (value != null) {
                              //         controller.updateData(
                              //           ServiceAset.fromJson(value),
                              //           item.id!,
                              //         );
                              //       }
                              //     });
                              //   },
                              //   icon: Icon(Hi.edit01, color: Colors.white),
                              // ),
                              IconButton(
                                  onPressed: () {
                                    CustomDelete.show(
                                      title: 'Konfirmasi Hapus',
                                      message:
                                          'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                      context: context,
                                      onConfirm: () {
                                        controller.deleteData(item.id!);
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Hi.delete02,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ),
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
    );
  }
}
