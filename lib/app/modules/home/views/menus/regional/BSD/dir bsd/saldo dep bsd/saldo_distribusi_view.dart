import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/saldo_dep_bsd.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Saldo%20Dep%20Bsd/saldo_distribusi_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class SaldoDistribusiView extends GetView<SaldoDistribusiController> {
  final SaldoDepBsd? data;
  const SaldoDistribusiView({super.key, this.data});
  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Form Distribusi Saldo BSD',
        actions: [
          IconButton(
              onPressed: () {
                controller.onSubmit(data?.id);
              },
              icon: Icon(Hi.tick03)),
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
                maxLines: 3),
            14.height,
            LzForm.select(
              hint: 'Departemen',
              label: 'Departemen',
              model: forms.key('dep'),
              onTap: () async {
                final data = await controller.getDep().overlay();
                controller.forms
                    .set('dep')
                    .options(data.labelValue('name', 'id'));
              },
            ),
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
                formatters: [Formatter.currency()],
                keyboard: Tit.number),
            20.height,
            Text('Saldo Kas Terakhir'),
            10.height,
            LzCard(
              children: [
                LzForm.input(
                  enabled: false,
                  label: 'Saldo BSD',
                  model: forms.key('saldo_akhir_bsd'),
                ),
                LzForm.input(
                  enabled: false,
                  label: 'Saldo IT',
                  model: forms.key('saldo_akhir_it'),
                ),
              ],
            ),
            15.height,
            Text('Ini untuk input ke jurnal umum'),
            10.height,
            akunCard(
              kodeKey: 'kode_akun_1',
              namaKey: 'nama_akun_1',
              perkiraanKey: 'perkiraan_1',
            ),
            akunCard(
              kodeKey: 'kode_akun_2',
              namaKey: 'nama_akun_2',
              perkiraanKey: 'perkiraan_2',
            ),
          ],
        ),
      ),
    );
  }

  Widget akunCard({
    required String kodeKey,
    required String namaKey,
    required String perkiraanKey,
  }) {
    return Obx(() {
      // ⛔️ TUNGGU SAMPAI OPTIONS ADA
      if (controller.kodeAkun.isEmpty) {
        return LzCard(
          children: const [
            Text('Memuat kode akun...'),
          ],
        );
      }

      return LzCard(
        children: [
          LzForm.select(
            label: 'Kode Akun',
            hint: 'Pilih Kode Akun',
            model: controller.forms.key(kodeKey),
            style: OptionPickerStyle(withSearch: true),
            options:
                controller.kodeAkun.map((e) => e.kodeAkun.toString()).toList(),
            values: controller.kodeAkun.map((e) => e.id.toString()).toList(),
            onChange: (value) => controller.setNamaAkun(value, namaKey),
          ),
          LzForm.input(
            label: 'Nama Akun',
            enabled: false,
            maxLines: 2,
            model: controller.forms.key(namaKey),
          ),
          LzForm.input(
            label: 'Nominal',
            keyboard: Tit.number,
            formatters: [Formatter.currency()],
          ),
          LzForm.select(
            label: 'Perkiraan',
            hint: 'Pilih Perkiraan',
            model: controller.forms.key(perkiraanKey),
            onTap: () async {
              final data = await controller.getType().overlay();

              controller.forms.set(perkiraanKey).options(
                    data
                        .map((e) => {
                              'label': e['name'],
                              'value': e['id'], // ← INI YANG DIKIRIM
                            })
                        .toList(),
                  );
            },
          ),
        ],
      );
    });
  }
}
