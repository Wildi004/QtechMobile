import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/absence/controllers/card_absensi_controller.dart';
import 'package:qrm_dev/app/modules/absence/views/widget%20absensi/user_foto_absensi_view.dart';

class CardAbsensi extends GetView<CardAbsensiController> {
  const CardAbsensi({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CardAbsensiController());
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width * 0.9,
      padding: EdgeInsets.all(height * 0.02),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: height * 0.003),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            return Text(
              controller.currentTime.value,
              style: TextStyle(
                fontSize: height * 0.025,
                fontWeight: FontWeight.bold,
              ),
            );
          }),
          Obx(() => Text(
                controller.currentDate.value,
                style: TextStyle(fontSize: height * 0.014),
              )),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Obx(() {
              final absen = controller.absen.value;
              final timeIn = absen?.timeIn;
              final timeOut = absen?.timeOut;

              if ((timeIn == null || timeIn == '00:00:00') &&
                  (timeOut == null || timeOut == '00:00:00')) {
                return const SizedBox.shrink();
              }

              if (timeIn != null &&
                  timeIn != '00:00:00' &&
                  (timeOut == null || timeOut == '00:00:00')) {
                DateTime? jamAbsen;
                try {
                  final parts = timeIn.split(':');
                  jamAbsen = DateTime(
                    0,
                    1,
                    1,
                    int.parse(parts[0]),
                    int.parse(parts[1]),
                    int.parse(parts[2]),
                  );
                } catch (e) {
                  jamAbsen = null;
                }

                final jamPatokan = DateTime(0, 1, 1, 9, 0, 0);

                String keterangan = 'Tepat Waktu';
                Color warna = Colors.green;

                if (jamAbsen != null && jamAbsen.isAfter(jamPatokan)) {
                  final terlambat = jamAbsen.difference(jamPatokan).inMinutes;
                  keterangan = 'Terlambat $terlambat menit';
                  warna = Colors.red;
                }

                return Column(
                  children: [
                    Text(
                      timeIn,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: warna,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Text(
                          keterangan,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                );
              }

              if (timeOut != null && timeOut != '00:00:00') {
                return Column(
                  children: [
                    Text(
                      timeOut,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 75, 243, 33),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(3),
                        child: Text(
                          'Sampai jumpa besok 👋',
                          style: TextStyle(
                              color: Colors.black, fontWeight: Fw.bold),
                        ),
                      ),
                    )
                  ],
                );
              }

              return const SizedBox.shrink();
            }),
          ),

// Tombol dinamis
          // Tombol dinamis
          Obx(() {
            final absen = controller.absen.value;
            final timeIn = absen?.timeIn;
            final timeOut = absen?.timeOut;

            // kalau sudah absen pulang
            // kalau sudah absen pulang
            if (timeOut != null && timeOut != '00:00:00') {
              if (!controller.showButton.value) {
                return const SizedBox
                    .shrink(); // tombol disembunyikan sementara
              }

              // setelah muncul lagi, tombol kembali jadi "Absen Masuk"
              return LzButton(
                icon: Hi.logoutSquare01,
                text: 'Absen Masuk',
                onTap: () async {
                  final picker = ImagePicker();
                  final pickedFile = await picker.pickImage(
                    source: ImageSource.camera,
                    preferredCameraDevice: CameraDevice.front,
                  );

                  if (pickedFile != null) {
                    controller.checkUserLocation();
                    Get.to(PreviewUserLocation(File(pickedFile.path)));
                  }
                },
              );
            }

            // default: absen masuk / absen pulang
            String buttonText = 'Absen Masuk';
            if (timeIn != null &&
                timeIn != '00:00:00' &&
                (timeOut == null || timeOut == '00:00:00')) {
              buttonText = 'Absen Pulang';
            }

            return LzButton(
              icon: Hi.logoutSquare01,
              text: buttonText,
              onTap: () async {
                final picker = ImagePicker();
                final pickedFile = await picker.pickImage(
                  source: ImageSource.camera,
                );

                if (pickedFile != null) {
                  controller.checkUserLocation(
                    autoAbsen: true,
                    photo: File(pickedFile.path),
                  );

                  if (buttonText == 'Absen Pulang') {
                    controller.hideButtonTemporarily();
                  }
                }
              },
            );
          }),
        ],
      ),
    );
  }
}
