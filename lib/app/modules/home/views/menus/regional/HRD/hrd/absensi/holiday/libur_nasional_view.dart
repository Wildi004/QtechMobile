import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/holiday.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_absen_controller/holiday/holiday_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/absensi/holiday/create_holiday_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/absensi/holiday/update_holiday_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class LiburNasionalView extends GetView<HolidayController> {
  const LiburNasionalView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HolidayController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        bool isLoading = controller.isLoading.value;
        final data = controller.holiday;

        if (isLoading) {
          return Center(child: CustomLoading());
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
              padding: Ei.sym(v: 10),
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
                          CreateHolidayView(),
                          barrierDismissible: true,
                        ).then((data) {
                          if (data != null) {
                            controller.insertData(Holiday.fromJson(data));
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
                padding: Ei.sym(v: 10),
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
                          padding: const EdgeInsets.all(10),
                          decoration: CustomDecoration.validator(),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.description ?? 'tidak ada',
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
                                          return UpdateHolidayView(data: item);
                                        },
                                      ).then((value) {
                                        if (value != null) {
                                          controller.updateData(
                                              Holiday.fromJson(value),
                                              item.holidayId!);
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
                                          controller.delete(item.holidayId!);
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

                  // Loader saat paginate
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
