import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20legal/dok_ken_legal.dart';
import 'package:qrm_dev/app/modules/home/controllers/LEGAL/Dokumentasi%20Kendaraan%20Legal/dok_ken_legal_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class DokKenDetailView extends GetView<DokKenLegalController> {
  final DokKenLegal? data;

  const DokKenDetailView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    final image = data?.image;
    controller.setToken();

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Detail Dokumentasi Kendaraan',
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
                    maxLines: 99,
                    label: 'Keterangan',
                    model: forms.key('keterangan'),
                  ),
                  Intrinsic(gap: 10, children: [
                    LzForm.input(
                      enabled: false,
                      label: 'Tanggal pengurus',
                      model: forms.key('tgl_pengurusan'),
                    ),
                    LzForm.input(
                      enabled: false,
                      label: 'Tanggal Input',
                      model: forms.key('tgl_input'),
                    ),
                  ]),
                  LzForm.input(
                    enabled: false,
                    label: 'Tanggal Expired',
                    model: forms.key('tgl_exp'),
                  ),
                  LzForm.input(
                    maxLines: 99,
                    enabled: false,
                    label: 'Di Input Oleh',
                    model: forms.key('created_by_name'),
                  ),
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
            )
          ],
        ),
      ),
    );
  }
}
