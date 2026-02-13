import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/arsip_karyawan_hrd/arsip_karyawan_hrd.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/arsip_karyawan_hrd/detail.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_arsip_controller/arsip_karyawan_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/arsiv/arsip_karyawan/create_arsip_karyawan_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class ArsipKaryawanSettView extends GetView<ArsipKaryawanController> {
  final ArsipKaryawanHrd? data;

  const ArsipKaryawanSettView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ArsipKaryawanController());
    // final details = data?.detail ?? [];
    controller.detailsArsip.value = data?.detail ?? [];

    return Scaffold(
        appBar: CustomAppbar(
          title: data!.name ?? '',
        ).appBar,
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchQuery.searchInput(
                    onChanged: controller.updateSearchQuery,
                  ),
                ),
                SizedBox(width: 10),
                CustomScalaContainer(
                  child: LzButton(
                    icon: Hi.addSquare,
                    onTap: () {
                      if (data != null) {
                        Get.to(() =>
                                CreateArsipKaryawanView(userId: data!.userId))
                            ?.then((result) {
                          if (result != null) {
                            if (result is List && result.isNotEmpty) {
                              controller.insertData(
                                  ArsivKaryawanDetail.fromJson(result[0]));
                            } else if (result is Map<String, dynamic>) {
                              controller.insertData(
                                  ArsivKaryawanDetail.fromJson(result));
                            }
                          }
                        });
                      }
                    },
                  ),
                ),
              ],
            ).margin(all: 16),
            Expanded(child: Obx(() {
              final details = controller.detailsArsip;

              if (details.isEmpty) {
                return const Center(child: Text('Tidak ada detail'));
              }

              return LzListView(
                onRefresh: () => controller.getArsip(),
                padding: Ei.sym(v: 10, h: 20),
                children: details.generate((item, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomScalaContainer(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 54, 145, 220),
                                Color.fromARGB(255, 73, 173, 255),
                                Color.fromARGB(255, 14, 63, 210)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item.filename ?? 'No file',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Get.to(() => CreateArsipKaryawanView(
                                        userId: data!.userId,
                                        arsip: item,
                                      ))?.then((result) {
                                    if (result != null) {
                                      controller.updateData(
                                        ArsivKaryawanDetail.fromJson(result),
                                        item.id,
                                      );
                                    }
                                  });
                                },
                                icon:
                                    const Icon(Icons.edit, color: Colors.white),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if (item.filepath != null &&
                                      item.filepath!.isNotEmpty) {
                                    controller.openFileWithTokenAndShowViewer(
                                        item.filepath!);
                                  } else {
                                    Toast.show('File tidak tersedia');
                                  }
                                },
                                icon: const Icon(Icons.remove_red_eye,
                                    color: Colors.white),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  CustomDelete.show(
                                    title: 'Konfirmasi Hapus',
                                    message:
                                        'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                    context: context,
                                    onConfirm: () {
                                      controller.deletet(item.id!);
                                    },
                                  );
                                },
                                icon: Icon(Hi.delete02, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              );
            }))
          ],
        ));
  }
}
/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/arsip_karyawan_hrd/arsip_karyawan_hrd.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/arsip_karyawan_hrd/detail.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_arsip_controller/arsip_karyawan_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/hrd/arsiv/arsip_karyawan/create_arsip_karyawan_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class ArsipKaryawanSettView extends GetView<ArsipKaryawanController> {
  final ArsipKaryawanHrd? data;

  const ArsipKaryawanSettView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ArsipKaryawanController());

    // langsung set value awal
    controller.detailsArsip.value = data?.detail ?? [];

    final itemWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppbar(
        title: data?.name ?? '',
      ).appBar,
      body: Obx(() {
        final details = controller.detailsArsip;
        bool isLoading = controller.isLoading.value;
        if (isLoading) {
          return Center(child: CustomLoading());
        }
      if (details.isEmpty) {
          return Empty(
            message: 'Tidak ada data apa pun.',
            onTap: () => controller.getArsip(),
          );
        }

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchQuery.searchInput(
                    onChanged: controller.updateSearchQuery,
                  ),
                ),
                const SizedBox(width: 10),
                CustomScalaContainer(
                  child: LzButton(
                    icon: Hi.addSquare,
                    onTap: () {
                      if (data != null) {
                        Get.to(() => CreateArsipKaryawanView(
                              userId: data!.userId,
                            ))?.then((result) {
                          if (result != null) {
                            controller.insertData(
                              ArsivKaryawanDetail.fromJson(result),
                            );
                          }
                        });
                      }
                    },
                  ),
                ),
              ],
            ).margin(all: 16),

            // daftar file arsip
            Expanded(
              child: LzListView(
                padding: Ei.sym(v: 20, h: 20),
                onRefresh: () => controller.getDetails(data!.userId!),

                children: [
                  ...details.generate((item, i) {
                    return CustomScalaContainer(
                      child: Container(
                        margin: Ei.only(b: 10),
                        width: itemWidth,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 54, 145, 220),
                              Color.fromARGB(255, 73, 173, 255),
                              Color.fromARGB(255, 14, 63, 210),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.filename ?? 'No file',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Get.to(() => CreateArsipKaryawanView(
                                      userId: data!.userId,
                                      arsip: item,
                                    ))?.then((result) {
                                  if (result != null) {
                                    controller.updateData(
                                      ArsivKaryawanDetail.fromJson(result),
                                      item.id,
                                    );
                                  }
                                });
                              },
                              icon: const Icon(Icons.edit, color: Colors.white),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (item.filepath != null &&
                                    item.filepath!.isNotEmpty) {
                                  controller.openFileWithTokenAndShowViewer(
                                    item.filepath!,
                                  );
                                } else {
                                  Toast.show('File tidak tersedia');
                                }
                              },
                              icon: const Icon(Icons.remove_red_eye,
                                  color: Colors.white),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                CustomDelete.customDelete(
                                  context: context,
                                  onConfirm: () {
                                    controller.deletet(item.id!);
                                  },
                                );
                              },
                              icon: Icon(Hi.delete02, color: Colors.white),
                            ),
                          ],
                        ),
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
 */
