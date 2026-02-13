import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/absence/controllers/card_absensi_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class PreviewUserLocation extends GetView<CardAbsensiController> {
  final File photo;
  const PreviewUserLocation(this.photo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Absensi').appBar,
      body: Center(
          child: Column(
        mainAxisAlignment: Maa.center,
        spacing: 25,
        children: [
          LzImage(
            photo,
            size: 200,
            previewable: true,
          ),
          // loading indicator
          Obx(() {
            bool loading = controller.isLoadingLocation.value;
            if (loading) {
              return Row(
                spacing: 15,
                mainAxisAlignment: Maa.center,
                children: [
                  LzLoader(),
                  Text('Memeriksa lokasi...'),
                ],
              );
            }
            // tampilkan hasil pesan lokasi
            return Column(
              spacing: 20,
              children: [
                Text(controller.distanceMessage),
                InkTouch(
                  onTap: () {
                    controller.checkUserLocation(autoAbsen: true, photo: photo);
                  },
                  padding: Ei.sym(v: 10, h: 20),
                  child: Text('Periksa Ulang Lokasi'),
                ),
              ],
            );
          })
        ],
      )),
    );
  }
}
