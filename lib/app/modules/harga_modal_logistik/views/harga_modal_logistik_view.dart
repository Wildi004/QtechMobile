import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/modal_logistik.dart';
import 'package:qrm_dev/app/modules/harga_modal_logistik/controllers/harga_modal_logistik_controller.dart';
import 'package:qrm_dev/app/modules/harga_modal_logistik/views/edit_harga_modal_view.dart';
import 'package:qrm_dev/app/modules/harga_modal_logistik/views/form_harga_modal_view.dart';
import 'package:qrm_dev/app/modules/harga_modal_logistik/views/modal_logistik_detail.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class HargaModalLogistikView extends StatelessWidget {
  final HargaModalLogistikController controller =
      Get.put(HargaModalLogistikController());

  HargaModalLogistikView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Harga Modal',
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => FormHargaModalView())?.then((data) {
                  if (data != null) {
                    controller.insertData(ModalLogistik.fromJson(data));
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
                const SizedBox(width: 10),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: Obx(() {
                bool isLoading = controller.isLoading.value;
                final logistik = controller.rxHargaModal;

                if (isLoading) {
                  return const Center(child: CustomLoading());
                }

                if (logistik.isEmpty) {
                  return Empty(
                    message: 'Tidak ada data apa pun.',
                    onTap: () => controller.getLogistik(),
                  );
                }

                return LzListView(
                  padding: Ei.sym(
                    v: 10,
                  ),
                  onRefresh: () => controller.getLogistik(),
                  onScroll: (scroll) {
                    if (scroll.atBottom(100)) controller.onPaginate();
                  },
                  children: [
                    ...logistik.generate((data, i) {
                      return ListItemAnimasi(
                        index: i,
                        beginOffset: const Offset(-0.3, 0),
                        child: Touch(
                          onTap: () {
                            Get.to(() => ModalLogistikDetail(data: data))
                                ?.then((value) {
                              if (value != null) {
                                controller.updateData(
                                  ModalLogistik.fromJson(value),
                                  data.id!,
                                );
                              }
                            });
                          },
                          margin: Ei.only(b: 10),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: itemWidth,
                            padding: const EdgeInsets.all(10),
                            decoration: CustomDecoration.validator(),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    data.nama ?? 'tidak ada',
                                    style: CustomTextStyle.title(),
                                  ),
                                ),
                                iosBlurActionGroup(
                                  onEdit: () {
                                    Get.to(() => EditHargaModalView(data: data))
                                        ?.then((value) {
                                      if (value != null) {
                                        controller.updateData(
                                          ModalLogistik.fromJson(value),
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
                                        controller.deleteData(data.id!);
                                      },
                                    );
                                  },
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
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
