import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/arsip_lamaran.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_arsip_lamaran_controller/arsip_lamaran_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/file%20download/download_file.dart';
import 'package:qrm_dev/app/widgets/file%20download/file_viewer.dart';

class DetailArsipLamaranView extends GetView<ArsipLamaranController> {
  final ArsipLamaran? data;
  const DetailArsipLamaranView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Arsip Lamaran Detail',
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
                    label: 'Nama Karyawan',
                    model: forms.key('nama'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Tanggal Lamar',
                          model: forms.key('tgl_lamaran'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Kantor',
                          model: forms.key('lokasi_kantor'),
                        ),
                      ),
                    ],
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Posisi',
                    model: forms.key('posisi'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Status',
                    model: forms.key('status'),
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
