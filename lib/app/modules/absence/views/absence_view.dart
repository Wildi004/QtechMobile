// ignore_for_file: library_private_types_in_public_api
import 'dart:ui';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:flutter/material.dart';
import 'package:qrm_dev/app/modules/absence/controllers/absence_controller.dart';
import 'package:qrm_dev/app/modules/absence/views/widget%20absensi/all_info_absen.dart';
import 'package:qrm_dev/app/modules/absence/views/widget%20absensi/card_absensi.dart';
import 'package:qrm_dev/app/modules/absence/views/widget%20absensi/card_info_absen.dart';
import 'package:qrm_dev/app/modules/absence/views/widget%20absensi/title_absensi.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class AbsenceView extends GetView<AbsenceController> {
  const AbsenceView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AbsenceController());
    return Scaffold(
      appBar: CustomAppbar(title: 'Absensi').appBar,
      body: Stack(
        children: [
          Center(
            child: LzListView(
              onRefresh: () => controller.onPageInit(refresh: true),
              padding: Ei.sym(
                h: MediaQuery.of(context).size.height * 0.035,
                v: MediaQuery.of(context).size.height * 0.02,
              ),
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TitleAbsensi(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.019,
                          ),
                          const CardAbsensi(),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CardInfoAbsen(),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.011,
                            ),
                            AllInfoAbsen(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Obx(() {
            if (!controller.isLoading.value) return const SizedBox();
            return Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.white.withValues(alpha: 0.4),
                  child: const Center(
                    child: CustomLoading(),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
