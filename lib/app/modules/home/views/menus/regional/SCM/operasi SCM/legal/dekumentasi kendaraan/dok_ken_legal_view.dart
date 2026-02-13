import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20legal/dok_ken_legal.dart';
import 'package:qrm_dev/app/modules/home/controllers/LEGAL/Dokumentasi%20Kendaraan%20Legal/dok_ken_legal_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/dekumentasi%20kendaraan/create_dok_ken_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/dekumentasi%20kendaraan/dok_ken_detail_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/dekumentasi%20kendaraan/edit_dok_ken_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class DokKenLegalView extends GetView<DokKenLegalController> {
  const DokKenLegalView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DokKenLegalController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Dokumentasi Kendaraan',
        actions: [
          IconButton(
              onPressed: () {
                Get.dialog(CreateDokKenView()).then((data) {
                  if (data != null) {
                    controller.insertData(DokKenLegal.fromJson(data));
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
                          Get.to(() => DokKenDetailView(data: item))
                              ?.then((value) {});
                        },
                        margin: Ei.only(b: 10),
                        child: Container(
                          height: 70,
                          width: itemWidth,
                          padding: const EdgeInsets.all(10),
                          decoration: CustomDecoration.validator(),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.keterangan ?? '-',
                                  maxLines: 2,
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
                                      Get.to(() => EditDokKenView(data: item))
                                          ?.then((value) {
                                        if (value != null) {
                                          controller.updateData(
                                            DokKenLegal.fromJson(value),
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
