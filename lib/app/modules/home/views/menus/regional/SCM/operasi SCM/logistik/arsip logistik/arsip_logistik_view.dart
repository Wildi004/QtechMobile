import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/arsip_logistik.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Arsip%20logistik/arsip_logistik_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/arsip%20logistik/arsip_logistik_detail_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/arsip%20logistik/create_arsip_logistik_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class ArsipLogistikView extends GetView<ArsipLogistikController> {
  const ArsipLogistikView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ArsipLogistikController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Arsip',
        actions: [
          IconButton(
              onPressed: () {
                Get.dialog(CreateArsipLogistikView()).then((data) {
                  if (data != null) {
                    controller.insertData(ArsipLogistik.fromJson(data));
                  }
                });
              },
              icon: Icon(Hi.add01))
        ],
      ).appBar,
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        bool isLoading = controller.isLoading.value;
        final data = controller.listArsip;

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
                  SizedBox(height: 20),
                  ...data.generate((item, i) {
                    return CustomScalaContainer(
                      child: Touch(
                        onTap: () {
                          Get.to(() => ArsipLogistikDetailView(data: item))
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
                                  item.nama ?? '-',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins().copyWith(
                                      color: Colors.white, fontWeight: Fw.bold),
                                ),
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
