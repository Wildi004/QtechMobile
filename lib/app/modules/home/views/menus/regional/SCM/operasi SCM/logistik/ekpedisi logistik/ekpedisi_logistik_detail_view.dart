import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/ekpedisi.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Ekpedisi%20Logistik/ekpedisi_logistik_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class EkpedisiLogistikDetailView extends GetView<EkpedisiLogistikController> {
  final Ekpedisi? data;

  const EkpedisiLogistikDetailView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    if (data != null) {
      final datas = data!.toJson();
      if (datas['status'] != null) {
        final statusValue = int.tryParse(datas['status'].toString()) ?? -1;
        datas['status'] = getStatusLabel(statusValue);
      }
      forms.fill(datas);
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Detail Ekpedisi',
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
                    label: 'Nama',
                    model: forms.key('nama'),
                    maxLines: 99,
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'No HP',
                    maxLines: 99,
                    model: forms.key('no_hp'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'CP',
                    maxLines: 99,
                    model: forms.key('cp'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'HP CP',
                    maxLines: 99,
                    model: forms.key('hp_cp'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Alamat',
                    maxLines: 99,
                    model: forms.key('alamat'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Jenis',
                    maxLines: 99,
                    model: forms.key('jenis'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Status',
                    maxLines: 99,
                    model: forms.key('status'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Keterangan',
                    maxLines: 99,
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

String getStatusLabel(int status) {
  switch (status) {
    case 0:
      return 'Warning';
    case 1:
      return 'Aktif';
    case 2:
      return '--';
    case 3:
      return '--';
    case 4:
      return '--';
    default:
      return 'Tidak diketahui';
  }
}
