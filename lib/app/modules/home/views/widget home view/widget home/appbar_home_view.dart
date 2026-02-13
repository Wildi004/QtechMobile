import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/modules/home/controllers/home_controller.dart';
import 'package:qrm_dev/app/modules/home/views/widget%20home%20view/widget%20home/widget%20animasi%20appbar/animasi_notifikasi.dart';
import 'package:qrm_dev/app/widgets/custom_sacala_view.dart';

class AppbarHomeView extends StatelessWidget {
  final HomeController controller;
  final Size size;

  const AppbarHomeView({
    super.key,
    required this.controller,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    var notificationCount = 99.obs;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LzImage(
          'icon.png',
          size: 40,
        ),
        Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                BellIcon(),
                Positioned(
                  right: -2,
                  top: -2,
                  child: Obx(() {
                    int count = notificationCount.value;
                    return count > 0
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '$count',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  }),
                ),
              ],
            ),
            10.width,
            CustomScaleView(
              child: InkWell(
                onTap: () {
                  context.confirm(
                    title: 'Konfirmasi Logout',
                    message: 'Apakah Anda yakin ingin keluar dari akun ini?',
                    onConfirm: () => controller.logout(),
                  );
                },
                child: LzImage(
                  'logout.png',
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
