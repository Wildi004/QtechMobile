import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20legal/list_eproc.dart';
import 'package:qrm_dev/app/modules/home/controllers/LEGAL/List%20Eproc%20Legal/list_eproc_legal_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ListEprocDetailView extends GetView<ListEprocLegalController> {
  final ListEproc? data;

  const ListEprocDetailView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Detail List Eproc',
        actions: [
          IconButton(
            onPressed: () async {
              final url = data?.website ?? '';
              if (url.isNotEmpty) {
                final uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(
                    uri,
                    mode: LaunchMode.externalApplication,
                  );
                } else {
                  Get.snackbar(
                    'Gagal',
                    'Tidak dapat membuka website',
                  );
                }
              }
            },
            icon: const Icon(Hi.global),
          ),
        ],
      ).appBar,
      body: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Expanded(
              child: LzListView(
                gap: 10,
                children: [
                  LzForm.input(
                    enabled: false,
                    label: 'Nama Eproc',
                    maxLines: 999,
                    model: forms.key('nama_eproc'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Pembuat',
                    maxLines: 99,
                    model: forms.key('created_by_name'),
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
