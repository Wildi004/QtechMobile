import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/data_kontrak.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/home/controllers/Data%20Kontrak/data_kontrak_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/file%20download/download_file.dart';
import 'package:qrm_dev/app/widgets/file%20download/file_viewer.dart';

class DataKontrakDetailView extends GetView<DataKontrakController> {
  final DataKontrak? data;

  const DataKontrakDetailView({super.key, this.data});

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
        title: 'Detail Data Kontrak',
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            icon: Icon(Hi.pdf01), // ikon utama di AppBar
            onSelected: (value) {
              if (value == 'file1') {
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
              } else if (value == 'file2') {
                Toast.show('Lampiran 1 belum tersedia');
              } else if (value == 'file3') {
                Toast.show('Lampiran 2 belum tersedia');
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'file1',
                child: Row(
                  children: [
                    Icon(Hi.pdf01, color: Colors.red),
                    const SizedBox(width: 8),
                    const Text('File Kontrak'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'file2',
                child: Row(
                  children: [
                    Icon(Hi.pdf01, color: Colors.orange),
                    const SizedBox(width: 8),
                    const Text('BAPP'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'file3',
                child: Row(
                  children: [
                    Icon(Hi.pdf01, color: Colors.blue),
                    const SizedBox(width: 8),
                    const Text('BAST'),
                  ],
                ),
              ),
            ],
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
                    maxLines: 9,
                    model: forms.key('nama'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                            enabled: false,
                            label: 'Tanggal Kontrak',
                            model: forms.key('tgl_kontrak')),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LzForm.input(
                            enabled: false,
                            label: 'Tanggal Selesai',
                            model: forms.key('tgl_selesai')),
                      ),
                    ],
                  ),
                  Intrinsic(
                    gap: 10,
                    children: [
                      LzForm.input(
                          enabled: false,
                          label: 'In / Out',
                          model: forms.key('in_out')),
                      LzForm.input(
                          enabled: false,
                          label: 'Durasi',
                          model: forms.key('lama_hari')),
                    ],
                  ),
                  Intrinsic(
                    gap: 10,
                    children: [
                      LzForm.input(
                          enabled: false,
                          label: 'Status',
                          model: forms.key('status_kontrak')),
                      LzForm.input(
                          enabled: false,
                          label: 'Tanggal Distribusi',
                          model: forms.key('tgl_distribusi')),
                    ],
                  ),
                  LzForm.input(
                      enabled: false,
                      label: 'Nilai Kontrak (Rp)',
                      model: forms.key('nilai_kontrak')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
