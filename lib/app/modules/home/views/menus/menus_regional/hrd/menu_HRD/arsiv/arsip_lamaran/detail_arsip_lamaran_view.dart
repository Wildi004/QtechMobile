import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/arsip_lamaran.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_arsip_lamaran_controller/arsip_lamaran_controller.dart';

class DetailArsipLamaranView extends GetView<ArsipLamaranController> {
  final ArsipLamaran? data;
  const DetailArsipLamaranView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Arsip Lamaran Detail',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: ['4CA1AF'.hex, '808080'.hex],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: LzListView(
                gap: 20,
                children: [
                  LzForm.input(
                    enabled: false,
                    label: 'Nama Karyawan',
                    model: forms.key('nama'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Tanggal Lamar',
                          model: forms.key('tgl_lamaran'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Kantor',
                          model: forms.key('lokasi_kantor'),
                        ),
                      ),
                    ],
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Posisi',
                    model: forms.key('posisi'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Status',
                    model: forms.key('status'),
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
