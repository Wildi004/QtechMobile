import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/kendaraan_logistik.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Kendaraan%20Logistik/kendaraan_logistik_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/kendaraan%20logistik/create_kendaraan_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/kendaraan%20logistik/kendaraan_logistik_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class KendaraanLogistikView extends GetView<KendaraanLogistikController> {
  const KendaraanLogistikView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => KendaraanLogistikController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Kendaraan',
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => CreateKendaraanLogistikView())?.then((data) {
                if (data != null) {
                  controller.insertData(KendaraanLogistik.fromJson(data));
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
        final data = controller.data;

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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SearchQuery.searchInput(
                      onChanged: controller.updateSearchQuery,
                    ),
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
                          Get.to(() => KendaraanLogistikDetailView(data: item))
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
                                      item.namaAset ?? '-',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins().copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Touch(
                                    onTap: () {
                                      Get.snackbar('Status',
                                          getStatusLabel(item.status ?? 0));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: getStatusColor(item.status ?? 0),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: getStatusColor(
                                                item.status ?? 0)),
                                      ),
                                      child: Text(
                                        getStatusLabel(item.status ?? 0),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: Fw.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: Maa.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.namaKategori ?? '-',
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
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          CustomDelete.show(
                                            title: 'Konfirmasi Hapus',
                                            message:
                                                'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                            context: context,
                                            onConfirm: () {
                                              controller.deleteData(item.id!);
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

Color getStatusColor(int status) {
  switch (status) {
    case 0:
      return Colors.green;
    case 1:
      return Colors.blue;
    case 2:
      return Colors.red;
    case 3:
      return Colors.orange;
    case 4:
      return Colors.grey;
    default:
      return Colors.black54;
  }
}
