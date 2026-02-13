import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/standar_teknik/controllers/standar_teknik_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/file%20download/download_file.dart';
import 'package:qrm_dev/app/widgets/file%20download/file_viewer.dart';

class StandarTeknikView extends StatelessWidget {
  final StandarTeknikController controller = Get.put(StandarTeknikController());

  StandarTeknikView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar(
        title: 'Standarisasi Teknik',
        actions: [
          // IconButton(
          //     onPressed: () {
          //       Get.to(() => CreateBrosurView())?.then((data) {
          //         if (data != null) {
          //           controller.insertData(BrosurLogistik.fromJson(data));
          //         }
          //       });
          //     },
          //     icon: Icon(Hi.add01))
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
                        onChanged: controller.updateSearchQuery)),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: Obx(() {
                bool isLoading = controller.isLoading.value;
                final brosur = controller.rxbl;
                final itemWidth = MediaQuery.of(context).size.width - 30;

                if (isLoading) {
                  return Center(child: CustomLoading());
                }

                if (brosur.isEmpty) {
                  return Empty(
                    message: 'Tidak ada data apa pun.',
                    onTap: () => controller.getBrosur(),
                  );
                }

                return LzListView(
                    padding: Ei.sym(v: 20),
                    onRefresh: () => controller.getBrosur(),
                    onScroll: (scroll) {
                      if (scroll.atBottom(100)) {
                        controller.onPaginate();
                      }
                    },
                    children: [
                      Column(
                        children: brosur.map((data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                // onTap: () async {
                                //   final result = await Get.dialog(
                                //       DetailBrosurLogView(data: data));
                                //   if (result != null) {
                                //     controller.updateData(
                                //         BrosurLogistik.fromJson(result),
                                //         data.id!);
                                //   }
                                // },
                                child: Container(
                                  width: itemWidth,
                                  padding: const EdgeInsets.all(10),
                                  decoration: CustomDecoration.validator1(),
                                  child: Column(
                                    crossAxisAlignment: Caa.start,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              if (data.image != null &&
                                                  data.image!.isNotEmpty) {
                                                FileHelper
                                                    .openFileWithTokenAndShowViewer(
                                                  fileUrl: data.image!,
                                                  getToken: () async =>
                                                      storage.read('token'),
                                                  viewerPage: (bytes,
                                                          fileType) =>
                                                      DownloadFile(
                                                          fileBytes: bytes,
                                                          fileType: fileType),
                                                );
                                              } else {
                                                Toast.show(
                                                    'File tidak tersedia');
                                              }
                                            },
                                            icon: Icon(
                                              Hi.file02,
                                              size: 28,
                                              color: Colors.black,
                                            ),
                                          ),

                                          // TEXT
                                          Expanded(
                                            child: Text(
                                              data.judul ?? 'tidak ada',
                                              style: CustomTextStyle.title(),
                                            ),
                                          ),

                                          // DELETE
                                        ],
                                      ),
                                      Intrinsic(
                                        gap: 20,
                                        children: [
                                          Text(
                                            data.namaKategori ?? 'tidak ada',
                                            style: CustomTextStyle.subtitle(),
                                          ),
                                          Text(
                                            data.tglUpload ?? 'tidak ada',
                                            style: CustomTextStyle.subtitle(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        }).toList(),
                      ),
                      Obx(() =>
                          CustomLoading().lz.hide(!controller.isPaginate.value))
                    ]);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
