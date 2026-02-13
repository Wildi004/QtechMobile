import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/hrd_cuti.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_cuti_sudah_validasi_controller/hrd_cuti_sudah_validasi_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CutiHrdDetailView extends GetView<HrdCutiSudahValidasiController> {
  final HrdCuti? data;
  const CutiHrdDetailView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(title: 'Cuti Detail').appBar,
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
                    model: forms.key('user_name'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Tanggal Pengajuan',
                          model: forms.key('tgl_cuti'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'ID Karyawan',
                          model: forms.key('user_id'),
                        ),
                      ),
                    ],
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Departemen',
                    model: forms.key('dep_id'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Perihal',
                    model: forms.key('perihal'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Tanggal Mulai Cuti',
                          model: forms.key('cuti_from'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Tanggal Selesai Cuti',
                          model: forms.key('cuti_to'),
                        ),
                      ),
                    ],
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Lama Cuti',
                    model: forms.key('lama_cuti'),
                  ),
                  LzForm.input(
                    maxLines: 10,
                    enabled: false,
                    label: 'Keterangan',
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
