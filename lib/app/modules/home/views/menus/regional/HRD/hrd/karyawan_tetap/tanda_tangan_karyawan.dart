import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tetap.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/edit_ttd_karyawan_tetap_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/image_picker.dart';
import 'package:qrm_dev/app/widgets/token_image_widget.dart';

class TandaTanganKaryawan extends GetView<EditTtdKaryawanTetapController> {
  const TandaTanganKaryawan({super.key, this.data});
  final KaryawanTetap? data;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<EditTtdKaryawanTetapController>()) {
      Get.lazyPut(() => EditTtdKaryawanTetapController());
    }

    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.getDetailUser(data!.id!);
    }

    return Scaffold(
      appBar: CustomAppbar(title: 'Tanda Tangan').appBar,
      backgroundColor: Colors.white,
      body: LzListView(
        children: [
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: TokenImage(data?.image ?? '')),
                    const SizedBox(height: 15),
                    Text(
                      textAlign: TextAlign.center,
                      data?.name ?? '',
                      style: GoogleFonts.notoSerif().copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
          Obx(() {
            controller.isLoading.value;
            final e = controller.getKaryawan(data?.id);

            logg(e.toJson(), limit: 99999);

            return LzImage(
              data?.ttd ?? '',
              size: 100,
            );
          }),
          LzForm.input(
            hint: 'Masukan Tanda Tangan Karyawan',
            label: 'Pilih file',
            model: forms.key('ttd'),
            suffixIcon: Hi.image01,
            onTap: () {
              Pickers.image(then: (file) {
                if (file != null) {
                  forms.set('ttd', file.path);
                  controller.fileName.value = file.path;
                  controller.file = File(file.path);
                }
              });
            },
          ),
          Obx(() => controller.fileName.value.isEmpty
              ? const None()
              : Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Tanda Tangan Baru:',
                        style: TextStyle(fontWeight: Fw.bold)),
                    const SizedBox(height: 10),
                    LzImage(controller.file, size: 100),
                    const SizedBox(height: 10),
                  ],
                ).start),
          LzButton(
            text: data == null ? 'Submit' : 'Update',
            onTap: () {
              controller.onSubmitTtd(data?.id);
            },
          ).margin(all: 20),
        ],
      ),
    );
  }
}
