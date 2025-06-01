import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/karyawan_tetap.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/edit_karyawan_controller.dart';
import 'package:qrm/app/widgets/image_picker.dart';

class TandaTanganKaryawan extends GetView<EditKaryawanController> {
  const TandaTanganKaryawan({super.key, this.data});
  final KaryawanTetap? data;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<EditKaryawanController>()) {
      Get.lazyPut(() => EditKaryawanController());
    }
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: AppBar(
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
                    Container(
                      width: 130,
                      height: 130,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: data?.image != null
                          ? ClipOval(
                              child: Image.network(
                                'https://laravel.apihbr.link/storage/${data?.image}',
                                width: 130,
                                height: 130,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.blue,
                                    child: const Icon(Icons.person,
                                        size: 50, color: Colors.white),
                                  );
                                },
                              ),
                            )
                          : Container(
                              color: Colors.blue,
                              alignment: Alignment.center,
                              child: const Icon(Icons.person,
                                  size: 50, color: Colors.white),
                            ),
                    ),
                    const SizedBox(height: 15),

                    // Nama
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
          if (data?.ttd != null && data!.ttd!.isNotEmpty)
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text('Tanda Tangan Sebelumnya',
                      style: TextStyle(fontWeight: Fw.bold)),
                  const SizedBox(height: 10),
                  Image.network(
                    'https://laravel.apihbr.link/storage/${data?.ttd}',
                    width: 150,
                    height: 100,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        width: 150,
                        height: 100,
                        alignment: Alignment.center,
                        child: const Icon(Icons.image_not_supported,
                            color: Colors.grey),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

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
