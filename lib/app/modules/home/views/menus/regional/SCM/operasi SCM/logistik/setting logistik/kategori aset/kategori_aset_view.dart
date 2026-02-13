import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/kategori_aset.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Setting%20Logistik/form_kategori_aset_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Setting%20Logistik/kategori_aset_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/setting%20logistik/kategori%20aset/form_kategori_aset_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class KategoriAsetView extends GetView<KategoriAsetController> {
  const KategoriAsetView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => KategoriAsetController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Kategori Aset',
        actions: [
          IconButton(
              onPressed: () {
                final createController = Get.put(FormKategoriAsetController());
                createController.resetForm();
                Get.dialog(
                  FormKategoriAsetView(),
                  barrierDismissible: true,
                ).then((data) {
                  if (data != null) {
                    controller.insertData(KategoriAset.fromJson(data));
                  }
                });
              },
              icon: Icon(Hi.add01))
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
            message: 'Tidak ada Surat Keluar.',
            onTap: () => controller.getData(),
          );
        }

        return Column(
          children: [
            Padding(
              padding: Ei.sym(v: 20, h: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SearchQuery.searchInput(
                      onChanged: controller.updateSearchQuery,
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            Expanded(
              child: LzListView(
                padding: Ei.sym(h: 20),
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
                        margin: Ei.only(b: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: itemWidth,
                          padding: const EdgeInsets.all(15),
                          decoration: CustomDecoration.validator(),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.namaKategori ?? '-',
                                  style: GoogleFonts.poppins().copyWith(
                                      color: Colors.white, fontWeight: Fw.bold),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return FormKategoriAsetView(
                                              data: item);
                                        },
                                      ).then((value) {
                                        if (value != null) {
                                          controller.updateData(
                                              KategoriAset.fromJson(value),
                                              item.id!);
                                        }
                                      });
                                    },
                                    icon: Icon(Hi.edit01, color: Colors.white),
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
                                          controller.delete(item.id!);
                                        },
                                      );
                                    },
                                    icon:
                                        Icon(Hi.delete02, color: Colors.white),
                                  )
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
