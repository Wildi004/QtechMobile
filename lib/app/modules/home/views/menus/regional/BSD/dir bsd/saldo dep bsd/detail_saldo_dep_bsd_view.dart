import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/saldo_dep_bsd.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Saldo%20Dep%20Bsd/saldo_dep_bsd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class DetailSaldoDepBsdView extends GetView<SaldoDepBsdController> {
  final SaldoDepBsd? data;

  const DetailSaldoDepBsdView({super.key, this.data});

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
        title: 'Detail Saldo BSD',
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
