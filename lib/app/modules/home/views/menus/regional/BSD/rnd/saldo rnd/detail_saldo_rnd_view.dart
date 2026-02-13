import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20rnd/saldo_rnd.dart';
import 'package:qrm_dev/app/modules/home/controllers/RND/Saldo%20RND/saldo_rnd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class DetailSaldoRndView extends GetView<SaldoRndController> {
  final SaldoRnd? data;

  const DetailSaldoRndView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    if (data != null) {
      final json = data!.toJson();

      forms.fill({
        ...json,
        'debit': controller.formatRp(json['debit']),
        'kredit': controller.formatRp(json['kredit']),
        'saldo': controller.formatRp(json['saldo']),
      });
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Detail Saldo RND',
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
                    maxLines: 999,
                    model: forms.key('keterangan'),
                  ),
                  Intrinsic(
                    gap: 10,
                    children: [
                      LzForm.input(
                        maxLines: 99,
                        enabled: false,
                        label: 'Tanggal Terima',
                        model: forms.key('tgl_terima'),
                      ),
                      LzForm.input(
                        maxLines: 99,
                        enabled: false,
                        label: 'Departemen',
                        model: forms.key('dep'),
                      ),
                    ],
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Validator',
                    model: forms.key('user_name'),
                  ),
                  Intrinsic(
                    gap: 10,
                    children: [
                      LzForm.input(
                        maxLines: 99,
                        enabled: false,
                        label: 'Debit',
                        model: forms.key('debit'),
                      ),
                      LzForm.input(
                        maxLines: 99,
                        enabled: false,
                        label: 'Kredit',
                        model: forms.key('kredit'),
                      ),
                    ],
                  ),
                  LzForm.input(
                    maxLines: 99,
                    enabled: false,
                    label: 'Saldo',
                    model: forms.key('saldo'),
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
