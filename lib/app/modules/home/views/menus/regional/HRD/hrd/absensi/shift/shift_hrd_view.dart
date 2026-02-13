import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/shift_building/shift.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_absen_controller/shift/shift_hrd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/absensi/shift/add_shift_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/absensi/shift/detail_shift_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/absensi/shift/form_shift_hrd_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class ShiftHrdView extends GetView<ShiftHrdController> {
  const ShiftHrdView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ShiftHrdController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        bool isLoading = controller.isLoading.value;
        final data = controller.shift;

        if (isLoading) {
          return Center(
            child: CustomLoading(),
          );
        }

        if (data.isEmpty) {
          return Empty(
            message: 'Tidak ada data apa pun.',
            onTap: () => controller.getData(),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
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
                        Get.dialog(
                          AddShiftHrdView(),
                          barrierDismissible: true,
                        ).then((data) {
                          if (data != null) {
                            controller.insertData(Shifts.fromJson(data));
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LzListView(
                padding: Ei.sym(
                  v: 10,
                ),
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
                          Get.to(() => DetailShiftHrdView(data: item))
                              ?.then((value) {});
                        },
                        margin: Ei.only(b: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width - 30,
                          padding: const EdgeInsets.all(10),
                          decoration: CustomDecoration.validator(),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.shiftName ?? 'tidak ada',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                                          return FormShiftHrdView(data: item);
                                        },
                                      ).then((value) {
                                        if (value != null) {
                                          controller.updateData(
                                              Shifts.fromJson(value),
                                              item.shiftId!);
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
                                          controller.delete(item.shiftId!);
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
