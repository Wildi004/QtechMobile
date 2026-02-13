import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik%20jkt/alat_proyek_log_jkt.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/aset_kantor_controller/image_token_aset.dart';
import 'package:qrm_dev/app/modules/home/controllers/Logistik%20Jakarta/Alat%20Proyek/alat_proyek_log_jkt_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_rupiah.dart';

class AlatProyekLogJktDetailView extends GetView<AlatProyekLogJktController> {
  final AlatProyekLogJkt? data;

  const AlatProyekLogJktDetailView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;
    final imageC = Get.put(ImageFileTokenController());
    final image = data?.image;
    controller.setToken();

    if (data != null) {
      final datas = data!.toJson();
      datas['harga_perolehan'] =
          CurrencyHelper.formatRupiah(data!.hargaPerolehan);
      forms.fill(datas);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (data?.image != null && data!.image!.isNotEmpty) {
        imageC.loadImage(data!.image!);
      }
    });

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Detail Alat Proyek',
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
                    label: 'Kode Alat',
                    model: forms.key('kode_alat'),
                  ),
                  LzForm.input(
                    maxLines: 99,
                    enabled: false,
                    label: 'Nama Alat',
                    model: forms.key('nama_alat'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Type',
                    model: forms.key('type'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                            enabled: false,
                            label: 'Jumlah Alat',
                            model: forms.key('jumlah')),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LzForm.input(
                            enabled: false,
                            label: 'Harga Perolehan',
                            model: forms.key('harga_perolehan')),
                      ),
                    ],
                  ),
                  Intrinsic(gap: 10, children: [
                    LzForm.input(
                        enabled: false,
                        label: 'Tanggal Beli',
                        model: forms.key('tgl_beli')),
                    LzForm.input(
                        enabled: false,
                        label: 'Tanggal Service',
                        model: forms.key('tgl_service')),
                  ]),
                  LzForm.input(
                      enabled: false,
                      label: 'Status Alat',
                      model: forms.key('status')),
                  LzForm.input(
                      enabled: false,
                      label: 'Di Input Oleh',
                      model: forms.key('created_by_name')),
                  LzForm.input(
                      enabled: false,
                      label: 'Keterangan',
                      model: forms.key('keterangan')),
                  Row(
                    children: [
                      LzImage(image,
                          radius: 40,
                          fit: BoxFit.contain,
                          previewable: true,
                          size: 100,
                          headers: {
                            'Authorization': 'Bearer ${controller.token}'
                          }),
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
