import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/surat_internal.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/surat_internal/controllers/surat_internal_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/file%20download/word/open_file_word.dart';

class DetailSuratInternalView extends GetView<SuratInternalController> {
  final SuratInternal? data;
  const DetailSuratInternalView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Surat Internal',
        actions: [
          IconButton(
            onPressed: () {
              if (data?.image != null && data!.image!.isNotEmpty) {
                OpenFileWord.openWordFile(
                  fileUrl: data!.image!,
                  getToken: () async => storage.read('token'),
                );
              } else {
                Toast.show('File Word tidak tersedia');
              }
            },
            icon: const Icon(Hi.pdf01), // ikon word
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
                    maxLines: 99,
                    label: 'Nama Surat',
                    model: forms.key('nama'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Tanggal Upload',
                          model: forms.key('tgl_upload'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Dibuat Oleh',
                          model: forms.key('user_name'),
                        ),
                      ),
                    ],
                  ),
                  LzForm.input(
                    enabled: false,
                    maxLines: 99,
                    label: 'Keterangan',
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
