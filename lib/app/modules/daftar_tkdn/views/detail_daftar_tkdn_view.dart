import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/daftar_tkdn.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/daftar_tkdn/controllers/daftar_tkdn_controller.dart';
import 'package:qrm_dev/app/widgets/file%20download/download_file.dart';
import 'package:qrm_dev/app/widgets/file%20download/file_viewer.dart';

class DetailDaftarTkdnView extends GetView<DaftarTkdnController> {
  final DaftarTkdn? data;

  const DetailDaftarTkdnView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DaftarTkdnController());
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      title: Row(
        mainAxisAlignment: Maa.spaceBetween,
        children: [
          const Text(
            'Daftar TKDN',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () {
              if (data?.image != null && data!.image!.isNotEmpty) {
                FileHelper.openFileWithTokenAndShowViewer(
                  fileUrl: data!.image!,
                  getToken: () async => storage.read('token'),
                  viewerPage: (bytes, fileType) =>
                      DownloadFile(fileBytes: bytes, fileType: fileType),
                );
              } else {
                Toast.show('File tidak tersedia');
              }
            },
            icon: const Icon(Hi.pdf01),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LzForm.input(
              hint: 'Nama',
              maxLines: 99,
              enabled: false,
              label: 'Nama',
              model: forms.key('nama')),
          15.height,
          LzForm.input(
              label: 'Tanggal Upload',
              enabled: false,
              model: forms.key('tgl_upload')),
        ],
      ),
    );
  }
}
