import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/kendaraan_logistik.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/aset_kantor_controller/image_token_aset.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Kendaraan%20Logistik/kendaraan_logistik_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_rupiah.dart';

class KendaraanLogistikDetailView extends GetView<KendaraanLogistikController> {
  final KendaraanLogistik? data;

  const KendaraanLogistikDetailView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;
    final imageC = Get.put(ImageFileTokenController());
    final image = data?.image;
    final qr = data?.qrCode;

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
      if (data?.qrCode != null && data!.qrCode!.isNotEmpty) {
        imageC.loadImage(data!.qrCode!);
      }
    });

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Detail Kendaraan',
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
                    model: forms.key('kode_aset'),
                  ),
                  LzForm.input(
                    maxLines: 99,
                    enabled: false,
                    label: 'Nama Alat',
                    model: forms.key('nama_aset'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'No Pol',
                    model: forms.key('no_pol'),
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
                            label: 'Tanggal Samsat',
                            model: forms.key('tgl_samsat')),
                      ),
                    ],
                  ),
                  Intrinsic(gap: 10, children: [
                    LzForm.input(
                        enabled: false,
                        label: 'Harga',
                        model: forms.key('harga_perolehan')),
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
                      10.width,
                      LzImage(qr,
                          radius: 50,
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
