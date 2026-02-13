import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/data_mandor/data_mandor.dart';
import 'package:qrm_dev/app/modules/data_mandor/controllers/data_mandor_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class DetailDataMandorView extends GetView<DataMandorController> {
  final DataMandor? data;
  const DetailDataMandorView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DataMandorController());
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Data Mandor',
      ).appBar,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: LzListView(
                gap: 15,
                children: [
                  LzForm.input(
                    enabled: false,
                    label: 'Nama',
                    model: forms.key('nama'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Alamat KTP',
                    model: forms.key('alamat_ktp'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'No HP',
                    model: forms.key('no_hp'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Alamat Domisili',
                    model: forms.key('alamat_domisili'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'No KTP',
                    model: forms.key('ktp'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Status',
                          model: forms.key('status'),
                        ),
                      ),
                      10.width,
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Rating',
                          model: forms.key('rating'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Harga',
                          model: forms.key('harga'),
                        ),
                      ),
                      10.width,
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Nilai Total',
                          model: forms.key('nilai_total'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Ketepatan Waktu',
                          model: forms.key('ketepatan_waktu'),
                        ),
                      ),
                      10.width,
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Kualitas Pekerjaan',
                          model: forms.key('kualitas_pekerjaan'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Kepatuhan Safety',
                          model: forms.key('kepatuhan_safety'),
                        ),
                      ),
                      10.width,
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Komunikasi',
                          model: forms.key('komunikasi'),
                        ),
                      ),
                    ],
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Spesialis',
                    model: forms.key('spesialis'),
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
