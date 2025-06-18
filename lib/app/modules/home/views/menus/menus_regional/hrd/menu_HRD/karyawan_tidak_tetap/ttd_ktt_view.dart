import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/karyawan_tidak.dart';
import 'package:qrm/app/modules/home/controllers/HRD/karyawan_tidak_tetap_controller/edit_ktt_controller.dart';
import 'package:qrm/app/widgets/image_picker.dart';
import 'package:qrm/app/widgets/token_image_widget.dart';

class TtdKttView extends GetView<EditKttController> {
  const TtdKttView({super.key, this.data});
  final KaryawanTidak? data;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<EditKttController>()) {
      Get.lazyPut(() => EditKttController());
    }
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Tanda Tangan',
          style: TextStyle(color: Colors.white, fontWeight: Fw.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: ['4CA1AF'.hex, '808080'.hex],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
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
                        child: TokenImage(data?.foto ?? '')),
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

          // Gambar tanda tangan dari database
          // Form unggah tanda tangan
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

          // Preview file yang baru dipilih
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

          // Tombol Submit / Update
          // LzButton(
          //   text: data == null ? 'Submit' : 'Update',
          //   onTap: () {
          //     controller.onSubmitTtd(data?.id);
          //   },
          // ).margin(all: 20),
        ],
      ),
    );
  }
}
