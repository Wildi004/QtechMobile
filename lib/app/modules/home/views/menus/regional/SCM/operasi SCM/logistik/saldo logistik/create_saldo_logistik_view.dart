import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/saldo_logistik.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Saldo%20Logistik/create_saldo_logistik_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreateSaldoLogistikView extends GetView<CreateSaldoLogistikController> {
  final SaldoLogistik? data;

  const CreateSaldoLogistikView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      forms.set('dep', data!.dep ?? '');
      logg('Dep dari data: ${data!.dep}');
    } else {
      forms.set('dep', 'BSD');
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Form Distribusi Saldo',
        actions: [
          IconButton(
              onPressed: () {
                controller.onSubmit(data?.id);
              },
              icon: Icon(Hi.tick03))
        ],
      ).appBar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LzForm.input(
              hint: 'Keterangan',
              label: 'Keterangan',
              model: forms.key('keterangan'),
            ),
            14.height,
            LzForm.input(
                hint: 'Departemen',
                label: 'Departemen',
                model: forms.key('dep'),
                enabled: false),
            14.height,
            LzForm.input(
              label: 'Tanggal Terima',
              hint: 'Format: YYYY-MM-DD',
              model: forms.key('tgl_terima'),
              suffixIcon: Hi.calendar02,
              onTap: () {
                LzPicker.date(context,
                    minDate: DateTime(1900),
                    initDate: forms.get('tgl_terima').toDate(),
                    onSelect: (date) {
                  forms.set('tgl_terima', date.format());
                });
              },
            ),
            14.height,
            LzForm.input(
              hint: 'Jumlah',
              label: 'Jumlah',
              model: forms.key('kredit'),
            ),
            20.height,
          ],
        ),
      ),
    );
  }
}
