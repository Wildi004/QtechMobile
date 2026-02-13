import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/supplier.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Supplier%20Logistik/supplier_logistik_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/supplier%20logistik/create_supplier_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/supplier%20logistik/supplier_logistik_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class SupplierLogistikView extends GetView<SupplierLogistikController> {
  const SupplierLogistikView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SupplierLogistikController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Supplier',
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => CreateSupplierLogistikView())?.then((data) {
                  if (data != null) {
                    controller.insertData(Supplier.fromJson(data));
                  }
                });
              },
              icon: Icon(Hi.add01))
        ],
      ).appBar,
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        bool isLoading = controller.isLoading.value;
        final data = controller.data;

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
                  SizedBox(height: 20),
                  ...data.generate((item, i) {
                    return CustomScalaContainer(
                      child: Touch(
                        onTap: () {
                          Get.to(() => SupplierLogistikDetailView(data: item))
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
                                  item.namaPerusahaan ?? '-',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins().copyWith(
                                      color: Colors.white, fontWeight: Fw.bold),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      Get.to(() => CreateSupplierLogistikView(
                                          data: item))?.then((value) {
                                        if (value != null) {
                                          controller.updateData(
                                            Supplier.fromJson(value),
                                            item.id!,
                                          );
                                        }
                                      });
                                    },
                                    icon: Icon(Hi.edit01, color: Colors.white),
                                  ),
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
                                      )),
                                ],
                              )
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
