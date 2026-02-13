import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/arsip_dir_bsd.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Arsip%20Dir%20Bsd/arsip_bsd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/file%20download/download_file.dart';
import 'package:qrm_dev/app/widgets/file%20download/file_viewer.dart';

class ArsipBsdDetailView extends GetView<ArsipBsdController> {
  final ArsipDirBsd? data;

  const ArsipBsdDetailView({super.key, this.data});

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
                    label: 'Nama Arsip',
                    maxLines: 999,
                    model: forms.key('nama'),
                  ),
                  LzForm.input(
                    maxLines: 99,
                    enabled: false,
                    label: 'Tanggal Upload',
                    model: forms.key('tgl_upload'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'User',
                    model: forms.key('user_name'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Keterangan',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      10.height,
                      Html(
                        data: data?.keterangan ?? '',
                        style: {
                          "body": Style(
                            fontSize: FontSize(14),
                            margin: Margins.all(0),
                            padding: HtmlPaddings.all(0),
                          ),
                        },
                      ),
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
