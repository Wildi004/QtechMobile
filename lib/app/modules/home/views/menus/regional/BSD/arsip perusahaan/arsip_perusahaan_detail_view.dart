import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/arsip_perusahaan.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/home/controllers/Arsip%20Perusahaan/arsip_perusahaan_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/file%20download/download_file.dart';
import 'package:qrm_dev/app/widgets/file%20download/file_viewer.dart';

class ArsipPerusahaanDetailView extends GetView<ArsipPerusahaanController> {
  final ArsipPerusahaan? data;

  const ArsipPerusahaanDetailView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    if (data != null) {
      final datas = data!.toJson();

      forms.fill(datas);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {});

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Detail Arsip',
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
              icon: Icon(Hi.pdf01))
        ],
      ).appBar,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: LzListView(
                gap: 10,
                children: [
                  LzForm.input(
                    enabled: false,
                    label: 'Nama Arsip',
                    maxLines: 9,
                    model: forms.key('nama'),
                  ),
                  LzForm.input(
                      enabled: false,
                      label: 'Tanggal Upload',
                      model: forms.key('tgl_upload')),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                            enabled: false,
                            label: 'Tanggal Berlaku',
                            model: forms.key('tgl_berlaku_dok')),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LzForm.input(
                            enabled: false,
                            label: 'Expired',
                            model: forms.key('expired_date')),
                      ),
                    ],
                  ),
                  LzForm.input(
                      enabled: false,
                      label: 'User',
                      model: forms.key('user_name')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
