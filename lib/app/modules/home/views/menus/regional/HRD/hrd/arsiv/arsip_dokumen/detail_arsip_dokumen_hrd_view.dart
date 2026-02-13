import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/dokumen_hrd.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_arsip_dokumen_controller/arsip_dokumen_hrd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/file%20download/download_file.dart';
import 'package:qrm_dev/app/widgets/file%20download/file_viewer.dart';

class DetailArsipDokumenHrdView extends GetView<ArsipDokumenHrdController> {
  final DokumenHrd? data;
  const DetailArsipDokumenHrdView({super.key, this.data});
  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Arsip Dokumen Detail',
        actions: [
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
      ).appBar,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: LzListView(
                gap: 20,
                children: [
                  LzForm.input(
                    enabled: false,
                    label: 'Nama',
                    maxLines: 99,
                    model: forms.key('nama'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Tanggal Upload',
                    model: forms.key('tgl_upload'),
                  ),
                  const Text('Keterangan : '),
                  LzCard(
                    children: [
                      Html(data: forms.get('keterangan') ?? ''),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
