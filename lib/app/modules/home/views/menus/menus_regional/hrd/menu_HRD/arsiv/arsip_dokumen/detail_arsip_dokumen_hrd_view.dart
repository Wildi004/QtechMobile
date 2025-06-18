import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/dokumen_hrd.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_arsip_dokumen_controller/arsip_dokumen_hrd_controller.dart';

class DetailArsipDokumenHrdView extends GetView<ArsipDokumenHrdController> {
  final DokumenHrd? data;
  const DetailArsipDokumenHrdView({super.key, this.data});

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
          'Arsip Dokumen Detail',
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
                  LzForm.input(
                    enabled: false,
                    label: 'Tanggal Upload',
                    model: forms.key('tgl_upload'),
                  ),
                  LzForm.input(
                      enabled: false,
                      label: 'keterangan',
                      model: forms.key('keterangan'),
                      maxLines: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
