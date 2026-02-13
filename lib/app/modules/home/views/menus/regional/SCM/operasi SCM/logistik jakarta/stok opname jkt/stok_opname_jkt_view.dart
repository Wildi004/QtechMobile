import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/stok_material.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/stok_opname/stok_opname.dart';
import 'package:qrm_dev/app/modules/home/controllers/Logistik%20Jakarta/Stok%20Opname%20Jkt/stok_opname_jkt_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/stok%20opname%20jkt/report_opname_jkt_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/stok%20material/create_stok_material_logistik_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class StokOpnameJktView extends GetView<StokOpnameJktController> {
  const StokOpnameJktView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => StokOpnameJktController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Stok Opname',
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => CreateStokMaterialLogistikView())?.then((data) {
                  if (data != null) {
                    controller
                        .insertData(StokMaterial.fromJson(data) as StokOpname);
                  }
                });
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
                        onTap: () {},
                        margin: Ei.only(b: 10),
                        child: Container(
                          width: itemWidth,
                          padding: const EdgeInsets.all(10),
                          decoration: CustomDecoration.validator(),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.jenisMaterial ?? '-',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins().copyWith(
                                      color: Colors.white, fontWeight: Fw.bold),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Hi.add01, color: Colors.white),
                                onPressed: () {
                                  Get.to(() =>
                                      ReportOpnameJktView(dataId: item.id));
                                },
                              ),
                              IconButton(
                                onPressed: () {
                                  CustomDelete.show(
                                    title: 'Konfirmasi Hapus',
                                    message:
                                        'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                    context: context,
                                    onConfirm: () {},
                                  );
                                },
                                icon: Icon(Hi.edit01, color: Colors.white),
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
