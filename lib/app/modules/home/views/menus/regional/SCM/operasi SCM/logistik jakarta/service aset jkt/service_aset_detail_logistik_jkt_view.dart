import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/service_aset/service_aset.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/home/controllers/Logistik%20Jakarta/Service%20Aset%20Logistik%20jkt/service_aset_logistik_jkt_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_rupiah.dart';
import 'package:qrm_dev/app/widgets/file%20download/download_file.dart';
import 'package:qrm_dev/app/widgets/file%20download/file_viewer.dart';

class ServiceAsetDetailLogistikJktView
    extends GetView<ServiceAsetLogistikJktController> {
  final ServiceAset? data;

  const ServiceAsetDetailLogistikJktView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    if (data != null) {
      final datas = data!.toJson();

      forms.set('aset_name', data!.detailAset?.namaAset ?? '');
      datas['biaya'] = CurrencyHelper.formatRupiah(data!.biaya);

      forms.fill(datas);
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Detail Service Aset',
        actions: [
          IconButton(
            onPressed: () {
              if (data?.nota != null && data!.nota!.isNotEmpty) {
                FileHelper.openFileWithTokenAndShowViewer(
                  fileUrl: data!.nota!,
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
                    label: 'Nama Aset',
                    maxLines: 999,
                    model: forms.key('aset_name'),
                  ),
                  Intrinsic(
                    gap: 10,
                    children: [
                      LzForm.input(
                        maxLines: 99,
                        enabled: false,
                        label: 'Tanggal Service',
                        model: forms.key('tgl_service'),
                      ),
                      LzForm.input(
                        enabled: false,
                        label: 'Biaya',
                        maxLines: 999,
                        model: forms.key('biaya'),
                      ),
                    ],
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Di Service Oleh',
                    maxLines: 999,
                    model: forms.key('diservice_oleh_name'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Tempat Service',
                    maxLines: 999,
                    model: forms.key('tempat_service'),
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
