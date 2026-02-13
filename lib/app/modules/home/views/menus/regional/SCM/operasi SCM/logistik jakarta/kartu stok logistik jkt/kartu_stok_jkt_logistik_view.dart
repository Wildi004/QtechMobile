import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/Logistik%20Jakarta/Kartu%20Stok%20Jkt/kartu_stok_logistik_jkt_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/kartu%20stok%20logistik%20jkt/kartu_stok_jkt_by_str_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class KartuStokJktLogistikView extends GetView<KartuStokLogistikJktController> {
  const KartuStokJktLogistikView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => KartuStokLogistikJktController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Kartu Stok',
        actions: [IconButton(onPressed: () {}, icon: Icon(Hi.add01))],
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
            message: 'Tidak Ada Data Kartu Stok.',
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
                          Get.to(() => KartuStokJktByStrView(
                                kodeStr: item.kodeStr,
                                data: item, // kirim data ke halaman berikut
                              ));
                        },
                        margin: Ei.only(b: 10),
                        child: Container(
                          width: itemWidth,
                          padding: const EdgeInsets.all(10),
                          decoration: CustomDecoration.validator(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.kodeMaterial ?? '-',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins().copyWith(
                                    color: Colors.white, fontWeight: Fw.bold),
                              ),
                              Text(
                                item.namaMaterial ?? '-',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins().copyWith(
                                    color: Colors.white, fontWeight: Fw.bold),
                              ),
                              Text(
                                item.namaPerusahaan ?? '-',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins().copyWith(
                                    color: Colors.white, fontWeight: Fw.bold),
                              ),
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
