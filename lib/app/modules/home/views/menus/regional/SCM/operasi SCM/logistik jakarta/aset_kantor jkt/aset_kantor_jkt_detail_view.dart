import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik%20jkt/aset_kantor_log_jkt.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/aset_kantor_controller/image_token_aset.dart';
import 'package:qrm_dev/app/modules/home/controllers/Logistik%20Jakarta/Aset%20Kantor/aset_kantor_log_jkt_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_rupiah.dart';

class AsetKantorJktDetailView extends GetView<AsetKantorLogJktController> {
  final AsetKantorLogJkt? data;

  const AsetKantorJktDetailView({super.key, this.data});

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
        title: 'Detail Aset Kantor',
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
                    label: 'Kode Aset',
                    model: forms.key('kode_aset'),
                  ),
                  LzForm.input(
                    maxLines: 99,
                    enabled: false,
                    label: 'Nama Aset',
                    model: forms.key('nama_aset'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Jenis Aset',
                    model: forms.key('nama_kategori'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                            enabled: false,
                            label: 'Jumlah Aset',
                            model: forms.key('jumlah')),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LzForm.input(
                            enabled: false,
                            formatters: [Formatter.currency()],
                            label: 'Harga',
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
                        label: 'Status Aset',
                        model: forms.key('status_label')),
                  ]),
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
