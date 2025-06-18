import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/karyawan_tetap.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/edit_karyawan_controller.dart';
import 'package:qrm/app/widgets/image_picker.dart';
import 'package:qrm/app/widgets/token_image_widget.dart';

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

          FutureBuilder<Uint8List>(
            future: loadTtdImage(data?.ttd),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Icon(Icons.broken_image, size: 50);
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('Tanda tangan tidak tersedia');
              } else {
                return Image.memory(
                  snapshot.data!,
                  width: 100,
                  height: 50,
                  fit: BoxFit.contain,
                );
              }
            },
          ),

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

Future<Uint8List> loadTtdImage(String? path) async {
  if (path == null || path.isEmpty) return Uint8List(0);

  final token = GetStorage().read('token') ?? '';
  final url = 'https://laravel.apihbr.link$path';

  final response = await HttpClient().getUrl(Uri.parse(url)).then((req) {
    req.headers.add('Authorization', 'Bearer $token');
    return req.close();
  });

  final bytes = await consolidateHttpClientResponseBytes(response);
  return bytes;
}
