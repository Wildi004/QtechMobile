import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/surat_masuk/surat_masuk.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/home/controllers/LEGAL/Surat%20Menyurat%20Legal/surat_keluar_legal_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/file%20download/download_surat.dart';
import 'package:qrm_dev/app/widgets/file%20download/file_viewer.dart';

class DetailSuratKeluarLegalView extends GetView<SuratKeluarLegalController> {
  final SuratMasuk? data;

  const DetailSuratKeluarLegalView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SuratKeluarLegalController());
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Detail Surat',
        actions: [
          IconButton(
            onPressed: () {
              if (data?.imagePath != null && data!.imagePath!.isNotEmpty) {
                FileHelper.openFileWithTokenAndShowViewer(
                  fileUrl: data!.imagePath!,
                  getToken: () async => storage.read('token'),
                  viewerPage: (bytes, fileType) =>
                      DownloadSurat(fileBytes: bytes, fileType: fileType),
                );
              } else {
                Toast.show('File tidak tersedia');
              }
            },
            icon: const Icon(Hi.pdf01),
          )
        ],
      ).appBar,
      body: Column(
        children: [
          Expanded(
              child: LzListView(
            gap: 15,
            children: [
              LzForm.input(
                enabled: false,
                label: 'Nama Surat',
                maxLines: 99,
                model: forms.key('perihal'),
              ),
              Intrinsic(gap: 10, children: [
                LzForm.input(
                  enabled: false,
                  label: 'Sifat Surat',
                  maxLines: 99,
                  model: forms.key('sifat'),
                ),
                LzForm.input(
                  enabled: false,
                  label: 'Tanggal Surat',
                  maxLines: 99,
                  model: forms.key('tgl_surat'),
                ),
              ]),
              LzForm.input(
                enabled: false,
                label: 'Keterangan Surat',
                maxLines: 99,
                model: forms.key('keterangan'),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
