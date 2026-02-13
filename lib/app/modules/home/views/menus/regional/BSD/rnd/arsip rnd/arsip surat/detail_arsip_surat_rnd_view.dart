import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/arsip_surat_keluar_bsd.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/home/controllers/RND/Arsip%20RND/arsip_surat_keluar_rnd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/file%20download/download_file.dart';
import 'package:qrm_dev/app/widgets/file%20download/file_viewer.dart';

class DetailArsipSuratRndView extends GetView<ArsipSuratKeluarRndController> {
  final ArsipSuratKeluarBsd? data;

  const DetailArsipSuratRndView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

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
                gap: 10,
                children: [
                  LzForm.input(
                    enabled: false,
                    label: 'Perihal',
                    maxLines: 999,
                    model: forms.key('perihal'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Sifat',
                    maxLines: 999,
                    model: forms.key('sifat'),
                  ),
                  Intrinsic(gap: 10, children: [
                    LzForm.input(
                      enabled: false,
                      label: 'Tanggal Upload',
                      model: forms.key('tgl_upload'),
                    ),
                    LzForm.input(
                      enabled: false,
                      label: 'Tanggal Surat',
                      model: forms.key('tgl_surat'),
                    ),
                  ]),
                  LzForm.input(
                    enabled: false,
                    label: 'User',
                    maxLines: 999,
                    model: forms.key('user_name'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Keterangan',
                    maxLines: 999,
                    model: forms.key('keterangan'),
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
