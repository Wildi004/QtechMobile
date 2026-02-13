import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik%20jkt/alat_proyek_log_jkt.dart';
import 'package:qrm_dev/app/modules/home/controllers/Logistik%20Jakarta/Alat%20Proyek/alat_proyek_log_jkt_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/alat%20proyek%20logistik%20jkt/alat_proyek_log_jkt_detail_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/alat%20proyek%20logistik%20jkt/create_alat_proyek_log_jkt_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/alat%20proyek%20logistik%20jkt/edit_alat_proyek_log_jkt_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class AlatProyekLogJktView extends GetView<AlatProyekLogJktController> {
  const AlatProyekLogJktView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AlatProyekLogJktController());
    final itemWidth = MediaQuery.of(context).size.width - 30;
    final trainer = TrainerController();

    final trainerTargets = [
      Target(
        content: 'Klik di sini untuk menambahkan data aset baru.',
      ),
      Target(
        content: 'Gunakan tombol ini untuk mengedit data aset.',
        align: ContentAlign.bottom,
      ),
      Target(
        content: 'Gunakan tombol ini untuk menghapus data aset.',
        align: ContentAlign.bottom,
      ),
    ];

    return Trainer(
      controller: trainer,
      targets: trainerTargets,
      builder: (keys) {
        return Scaffold(
          appBar: CustomAppbar(
            title: 'Alat Proyek',
            actions: [
              IconButton(
                key: keys[0],
                onPressed: () {
                  Get.to(() => CreateAlatProyekLogJktView())?.then((data) {
                    if (data != null) {
                      controller.insertData(AlatProyekLogJkt.fromJson(data));
                    }
                  });
                },
                icon: Icon(Hi.add01),
              ),
            ],
          ).appBar,
          resizeToAvoidBottomInset: false,
          body: Obx(() {
            bool isLoading = controller.isLoading.value;
            final data = controller.listAset;

            if (isLoading) {
              return Center(child: CustomLoading());
            }

            if (data.isEmpty) {
              return Empty(
                message: 'tidak ada data.',
                onTap: () => controller.getData(),
              );
            }

            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                    padding: Ei.sym(v: 10, h: 20),
                    onRefresh: () => controller.getData(),
                    onScroll: (scroll) {
                      if (scroll.atBottom(100)) {
                        controller.onPaginate();
                      }
                    },
                    children: [
                      ...data.generate((item, i) {
                        return CustomScalaContainer(
                          child: Touch(
                            onTap: () {
                              Get.to(() =>
                                      AlatProyekLogJktDetailView(data: item))
                                  ?.then((value) {});
                            },
                            margin: Ei.only(b: 10),
                            child: Container(
                              width: itemWidth,
                              padding: const EdgeInsets.all(10),
                              decoration: CustomDecoration.validator(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: Maa.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.namaAlat ?? '-',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins().copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        getStatusLabel(item.status ?? 0),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: Fw.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: Maa.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.kodeAlat ?? '-',
                                          style: GoogleFonts.poppins().copyWith(
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: Fw.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            key: i == 0 ? keys[1] : null,
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              Get.to(() =>
                                                      EditAlatProyekLogJktView(
                                                          data: item))
                                                  ?.then((value) {
                                                if (value != null) {
                                                  controller.updateData(
                                                    AlatProyekLogJkt.fromJson(
                                                        value),
                                                    item.id!,
                                                  );
                                                }
                                              });
                                            },
                                            icon: Icon(Hi.edit01,
                                                color: Colors.white),
                                          ),
                                          IconButton(
                                            key: i == 0 ? keys[2] : null,
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              CustomDelete.show(
                                                title: 'Konfirmasi Hapus',
                                                message:
                                                    'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                                context: context,
                                                onConfirm: () {
                                                  controller
                                                      .deleteData(item.id!);
                                                },
                                              );
                                            },
                                            icon: Icon(Hi.delete02,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      Obx(() => CustomLoading()
                          .lz
                          .hide(!controller.isPaginate.value)),
                    ],
                  ),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}

String getStatusLabel(int status) {
  switch (status) {
    case 0:
      return 'Tersedia';
    case 1:
      return 'Terpakai';
    case 2:
      return 'Rusak';
    case 3:
      return 'Service';
    case 4:
      return 'Hilang';
    default:
      return 'Tidak diketahui';
  }
}
