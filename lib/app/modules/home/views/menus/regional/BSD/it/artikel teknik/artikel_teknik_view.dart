import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Artikel%20Teknik/artikel_teknik_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/file%20download/download_file.dart';
import 'package:qrm_dev/app/widgets/file%20download/file_viewer.dart';

class ArtikelTeknikView extends StatelessWidget {
  final ArtikelTeknikController controller = Get.put(ArtikelTeknikController());

  ArtikelTeknikView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar(
        title: 'Artikel Teknik',
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
                                              if (data.file != null &&
                                                  data.file!.isNotEmpty) {
                                                FileHelper
                                                    .openFileWithTokenAndShowViewer(
                                                  fileUrl: data.file!,
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
                                      10.height,
                                      Intrinsic(children: [
                                        Text(
                                          'Tgl. Upload :',
                                          style: CustomTextStyle.title(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          data.tglUpload ?? 'tidak ada',
                                          style: CustomTextStyle.subtitle(),
                                        ),
                                      ]),
                                      10.height,
                                      Intrinsic(children: [
                                        Text(
                                          'HRD :',
                                          style: CustomTextStyle.title(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Dir. BSD :',
                                          style: CustomTextStyle.title(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ]),
                                      Intrinsic(children: [
                                        Text(
                                          statusText(data.statusValidasi),
                                          style: CustomTextStyle.subtitle(
                                            color: statusBgColor(
                                                data.statusValidasi),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          statusTextUp(data.statusUpload),
                                          style: CustomTextStyle.subtitle(
                                            color: statusBgColorUp(
                                                data.statusUpload),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ]),
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

String statusText(int? status) {
  switch (status) {
    case 0:
      return 'Pending';
    case 1:
      return 'Sudah Divalidasi';
    case 2:
      return 'Tolak';
    default:
      return '-';
  }
}

Color statusBgColor(int? status) {
  switch (status) {
    case 0:
      return Colors.orange;
    case 1:
      return Colors.green;
    case 2:
      return Colors.red;
    default:
      return Colors.grey;
  }
}

String statusTextUp(int? status) {
  switch (status) {
    case 0:
      return 'Pending';
    case 1:
      return 'Sudah Diupload';
    case 2:
      return 'Tolak';
    default:
      return '-';
  }
}

Color statusBgColorUp(int? status) {
  switch (status) {
    case 0:
      return Colors.orange;
    case 1:
      return Colors.green;
    case 2:
      return Colors.red;
    default:
      return Colors.grey;
  }
}
