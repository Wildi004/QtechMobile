import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/kasbon.dart';
import 'package:qrm_dev/app/modules/kasbon/controllers/kasbon_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class KasbonDetailView extends GetView<KasbonController> {
  final Kasbon? data;

  const KasbonDetailView({super.key, this.data});

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
        title: 'Detail Kasbon',
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
                    label: 'Keterangan',
                    maxLines: 9,
                    model: forms.key('keterangan'),
                  ),
                  LzForm.input(
                      enabled: false,
                      label: 'Jumlah Kasbon',
                      model: forms.key('jml')),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                            enabled: false,
                            label: 'Tanggal Pengajuan',
                            model: forms.key('tgl_kasbon')),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LzForm.input(
                            enabled: false,
                            label: 'Tanggal Diterima',
                            model: forms.key('tgl_terima')),
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
