import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/role_akses_1/controllers/detail_role_akses_1_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class DetailRoleAkses1View extends GetView<DetailRoleAkses1Controller> {
  const DetailRoleAkses1View({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DetailRoleAkses1Controller());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Detail',
       
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
                  }
                },
                children: [
                  SizedBox(height: 20),
                  ...data.generate((item, i) {
                    return ListItemAnimasi(
                      index: i,
                      beginOffset: const Offset(-0.3, 0),
                      child: Droplist(
                        builder: (key, action) {
                          return CustomScalaContainer(
                            child: Touch(
                              key: key,
                              onTap: () {},
                              margin: Ei.only(b: 10),
                              child: Container(
                                width: itemWidth,
                                padding: const EdgeInsets.all(20),
                                decoration: CustomDecoration.validator(),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.menu ?? '-',
                                        maxLines: 99,
                                        overflow: TextOverflow.ellipsis,
                                        style: CustomTextStyle.title(),
                                      ),
                                    ),
                                    Obx(() => Checkbox(
                                          value:
                                              controller.checkState[item.id] ??
                                                  false,
                                          onChanged: (value) {
                                            controller.checkState[item.id!] =
                                                value ?? false;
                                          },
                                          visualDensity: VisualDensity.compact,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                 
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
