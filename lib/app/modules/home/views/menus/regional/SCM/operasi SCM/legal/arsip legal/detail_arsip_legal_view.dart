import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20legal/arsip_legal.dart';
import 'package:qrm_dev/app/modules/home/controllers/LEGAL/Arsip%20Legal/arsip_legal_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class DetailArsipLegalView extends GetView<ArsipLegalController> {
  final ArsipLegal? data;

  const DetailArsipLegalView({super.key, this.data});

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
                final imgUrl = forms.get('image') ?? '';

                if (imgUrl.isNotEmpty) {
                  controller.openFileWithTokenAndShowViewer(imgUrl);
                } else {
                  Get.snackbar('Info', 'Tidak ada gambar tersedia');
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
