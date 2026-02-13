import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/LEGAL/Laporan%20Kerja%20Legal/laporan_kerja_legal_tanggal_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';

import '../../../../../../../../../widgets/custom_search_query.dart';

class LaporanKerjaLegalTanggalView
    extends GetView<LaporanKerjaLegalTanggalController> {
  final String encryptedTglRencana;
  final String encryptedPic;

  const LaporanKerjaLegalTanggalView({
    super.key,
    required this.encryptedTglRencana,
    required this.encryptedPic,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadRkPic(encryptedTglRencana, encryptedPic);
    });

    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppbar(title: 'Laporan Pekerjaan').appBar,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: SearchQuery.searchInput(
                onChanged: controller.updateSearchQuery,
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CustomLoading());
                }

                if (controller.rkPicList.isEmpty) {
                  return const Center(child: Text('Tidak ada data.'));
                }

                final data = controller.rkPicList;

                return LzListView(
                  padding: Ei.sym(v: 10, h: 20),
                  children: [
                    Touch(
                      onTap: () {
                        CustomDelete.show(
                          context: context,
                          onConfirm: () {
                            controller.sendToTelegram(
                                encryptedTglRencana, encryptedPic);
                          },
                        );
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.centerLeft,
                        decoration: CustomDecoration.validator(),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: Maa.spaceBetween,
                          children: const [
                            Text(
                              'Laporkan Ke Grup',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: Fw.bold),
                            ),
                            Icon(Hi.telegram, color: Colors.white, size: 20),
                          ],
                        ),
                      ),
                    ),
                    30.height,
                    Column(
                      crossAxisAlignment: Caa.start,
                      children: [
                        Text(
                          data.isNotEmpty ? (data.first.picName ?? '-') : '-',
                          style: GoogleFonts.oswald()
                              .copyWith(fontWeight: Fw.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          height: 2,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          data.isNotEmpty
                              ? (data.first.tglRencana ?? '-')
                              : '-',
                        ),
                      ],
                    ),
                    20.height,
                    ...data.generate((item, i) {
                      return CustomScalaContainer(
                        child: Touch(
                          onTap: () {
                            // if (item.id != null) {
                            //   Get.lazyPut(
                            //       () => HrdLaporanKerjaDetailController());
                            //   Get.to(() => LaporanKerjaHrdDetail(id: item.id!));
                            // } else {
                            //   Toast.show('ID pekerjaan tidak tersedia');
                            // }
                          },
                          margin: Ei.only(b: 10),
                          child: LzCard(
                            padding: const EdgeInsets.all(10),
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.namaPekerjaan ?? 'Tidak ada',
                                    style: const TextStyle(fontWeight: Fw.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.prioritas == 1 ? 'High' : 'Normal',
                                        style: const TextStyle(),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: item.status == 1
                                              ? Colors.green
                                              : Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Touch(
                                          onTap: () {
                                            Get.snackbar('Info',
                                                'Sedang dalam tahap pengembangan');
                                          },
                                          child: Text(
                                            item.status == 1
                                                ? 'Selesai'
                                                : 'On Progress',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    })
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
