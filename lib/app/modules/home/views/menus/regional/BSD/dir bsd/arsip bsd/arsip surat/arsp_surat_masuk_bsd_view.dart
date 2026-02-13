import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Arsip%20Dir%20Bsd/arsip_surat_masuk_bsd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/file%20download/download_file.dart';
import 'package:qrm_dev/app/widgets/file%20download/file_viewer.dart';

class ArspSuratMasukBsdView extends StatelessWidget {
  final ArsipSuratMasukBsdController controller =
      Get.put(ArsipSuratMasukBsdController());

  ArspSuratMasukBsdView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isLoading = controller.isLoading.value;
      final brosur = controller.data;
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
                padding: Ei.sym(v: 20, h: 20),
                onRefresh: () => controller.getBrosur(),
                onScroll: (scroll) {
                  if (scroll.atBottom(100)) {
                    controller.onPaginate();
                  }
                },
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: brosur.map((data) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: itemWidth,
                              padding: const EdgeInsets.all(10),
                              decoration: CustomDecoration.validator1(),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (data.suratKeluarImage != null &&
                                          data.suratKeluarImage!.isNotEmpty) {
                                        FileHelper
                                            .openFileWithTokenAndShowViewer(
                                          fileUrl: data.suratKeluarImage!,
                                          getToken: () async =>
                                              storage.read('token'),
                                          viewerPage: (bytes, fileType) =>
                                              DownloadFile(
                                                  fileBytes: bytes,
                                                  fileType: fileType),
                                        );
                                      } else {
                                        Toast.show('File tidak tersedia');
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
                                      data.kodeSurat ?? 'tidak ada',
                                      style: CustomTextStyle.title(),
                                    ),
                                  ),

                                  // DELETE
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
                ]),
          ),
        ],
      );
    });
  }
}
