import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/job_desk.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/job_desk/controllers/job_desk_controller.dart';
import 'package:qrm_dev/app/modules/job_desk/views/create_job_view.dart';
import 'package:qrm_dev/app/modules/job_desk/views/update_job_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/file%20download/download_file.dart';
import 'package:qrm_dev/app/widgets/file%20download/file_viewer.dart';

class JobDeskView extends StatelessWidget {
  final JobDeskController controller = Get.put(JobDeskController());
  JobDeskView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Job Desc',
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => CreateJobView())?.then((data) {
                  if (data != null) {
                    controller.insertData(JobDesk.fromJson(data));
                  }
                });
              },
              icon: Icon(Hi.add01))
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

            // List Data
            Expanded(
              child: Obx(() {
                bool isLoading = controller.isLoading.value;
                final jobdesk = controller.rxJd;
                final itemWidth = MediaQuery.of(context).size.width - 30;

                if (isLoading) {
                  return Center(child: CustomLoading());
                }
                if (jobdesk.isEmpty) {
                  return Empty(
                    message: 'Tidak ada data.',
                    onTap: () => controller.getJob(),
                  );
                }

                return LzListView(
                    padding: Ei.sym(v: 20),
                    onRefresh: () => controller.getJob(),
                    onScroll: (scroll) {
                      if (scroll.atBottom(100)) {
                        controller.onPaginate();
                      }
                    },
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: jobdesk.map((data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Touch(
                                onTap: () {
                                  if (data.image != null &&
                                      data.image!.isNotEmpty) {
                                    FileHelper.openFileWithTokenAndShowViewer(
                                      fileUrl: data.image!,
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
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  width: itemWidth,
                                  padding: const EdgeInsets.all(10),
                                  decoration: CustomDecoration.validator(),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data.roleName ?? 'tidak ada data',
                                          style: CustomTextStyle.title(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      // Row(
                                      //   mainAxisSize: MainAxisSize.min,
                                      //   children: [
                                      //     IconButton(
                                      //       padding: EdgeInsets.zero,
                                      //       onPressed: () {
                                      //         Get.to(() =>
                                      //                 UpdateJobView(data: data))
                                      //             ?.then((value) {
                                      //           if (value != null) {
                                      //             controller.updateData(
                                      //                 JobDesk.fromJson(value),
                                      //                 data.id!);
                                      //           }
                                      //         });
                                      //       },
                                      //       icon: Icon(Hi.edit01,
                                      //           color: Colors.white),
                                      //     ),
                                      //     IconButton(
                                      //       padding: EdgeInsets.zero,
                                      //       onPressed: () {
                                      //         CustomDelete.show(
                                      //           title: 'Konfirmasi Hapus',
                                      //           message:
                                      //               'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                      //           context: context,
                                      //           onConfirm: () {
                                      //             controller
                                      //                 .deletetJob(data.id!);
                                      //           },
                                      //         );
                                      //       },
                                      //       icon: Icon(Hi.delete02,
                                      //           color: Colors.white),
                                      //     )
                                      //   ],
                                      // ),
                                      // ),
                                      iosBlurActionGroup(
                                        onEdit: () {
                                          Get.to(() =>
                                                  UpdateJobView(data: data))
                                              ?.then((value) {
                                            if (value != null) {
                                              controller.updateData(
                                                JobDesk.fromJson(value),
                                                data.id!,
                                              );
                                            }
                                          });
                                        },
                                        onDelete: () {
                                          Get.defaultDialog(
                                            title: 'Konfirmasi',
                                            middleText:
                                                'Apakah Anda yakin ingin menghapus data ini?',
                                            textConfirm: 'Ya',
                                            textCancel: 'Batal',
                                            confirmTextColor: Colors.white,
                                            buttonColor: Colors.blue,
                                            onConfirm: () {
                                              Get.back();
                                              controller.delete(data.id!);
                                            },
                                          );
                                        },
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
