import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tetap.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/cetak_karyawan_tetap_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/karyawan_tetap_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/karyawan_tetap/create_karyawan_tetap_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/karyawan_tetap/setting_karyawan_tetap_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class KaryawanTetapViev extends StatelessWidget {
  final KaryawanTetapController controller = Get.put(KaryawanTetapController());

  KaryawanTetapViev({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar(
        title: 'Karyawan Tetap',
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => CreateKaryawanTetapView())?.then((data) {
                  if (data != null) {
                    controller.insertData(KaryawanTetap.fromJson(data));
                  }
                });
              },
              icon: Icon(
                Hi.add01,
                color: Colors.white,
              )),
          IconButton(
            icon: Icon(Hi.pdf01),
            onPressed: () {
              final controller = Get.put(CetakKaryawanController());
              controller.showStatusDialog();
            },
          )
        ],
      ).appBar,
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchQuery.searchInput(
                      onSubmitted: controller.updateSearchQuery,
                      controller: controller.searchC,
                      hint: 'Search...'),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: Obx(() {
                bool isLoading = controller.isLoading.value;
                final data = controller.listkaryawan;
                final itemWidth = MediaQuery.of(context).size.width - 30;

                if (isLoading) {
                  return Center(child: CustomLoading());
                }

                if (data.isEmpty) {
                  return Empty(
                    message: 'Tidak ada data apa pun.',
                    onTap: () => controller.getData(),
                  );
                }

                return LzListView(
                  padding: Ei.sym(v: 20),
                  onRefresh: () => controller.getData(),
                  onScroll: (scroll) {
                    if (scroll.atBottom(100)) {
                      controller.onPaginate();
                    }
                  },
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: data.map((data) {
                        // final int itemId = data.id ?? 0;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 60),
                                  child: Material(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(15),
                                    child: CustomScalaContainer(
                                      child: Touch(
                                        onTap: () {
                                          Get.to(
                                            () => SettingKaryawanTetapView(
                                                data: data),
                                          );
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08,
                                          width: itemWidth,
                                          padding: const EdgeInsets.all(10),
                                          decoration:
                                              CustomDecoration.validator(),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  data.name ?? 'tidak ada',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                LzImage(
                                  data.image,
                                  size: 50,
                                  previewable: true,
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      }).toList(),
                    ),
                    Obx(() =>
                        CustomLoading().lz.hide(!controller.isPaginate.value))
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

/*ks\
sPositioned(
                                  left: 0,
                                  top: 5,
                                  child: GestureDetector(
                                    onTap: () {
                                      final bytes =
                                          imageController.imageMap[itemId];
                                      if (bytes != null) {
                                        Get.dialog(
                                          Dialog(
                                            backgroundColor: Colors.transparent,
                                            child: InteractiveViewer(
                                              panEnabled: true,
                                              minScale: 0.5,
                                              maxScale: 3.0,
                                              child: Container(
                                                width: 300,
                                                height: 300,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: MemoryImage(bytes),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Obx(() {
                                      final bytes =
                                          imageController.imageMap[itemId];

                                      return SizedBox(
                                        width: 50,
                                        height: 50,
                                        // decoration: BoxDecoration(
                                        //   image: DecorationImage(
                                        //     image: bytes != null
                                        //         ? MemoryImage(bytes)
                                        //         : const AssetImage(
                                        //                 "assets/images/default.png")
                                        //             as ImageProvider,
                                        //     fit: BoxFit.cover,
                                        //   ),
                                        //   borderRadius:
                                        //       BorderRadius.circular(20),
                                        // ),
                                        child: TokenImage(imagePath ?? ''),
                                      );
                                    }),
                                  ),
                                ),
*/
