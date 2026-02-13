import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/validasi_alat/validasi_alat.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Validasi%20Alat%20Logistik/validasi_alat_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class ValidasiAlatDetailView extends GetView<ValidasiAlatController> {
  final ValidasiAlat? data;

  const ValidasiAlatDetailView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    if (data != null) {
      final datas = data!.toJson();

      // Ubah status jadi teks agar bisa ditampilkan di input
      datas['status'] = _statusText(data!.alat?.status ?? '-');
      datas['nama_alat'] = data!.alat?.namaAlat ?? '-';

      forms.fill(datas);
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Detail Validasi Alat',
      ).appBar,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: LzListView(
                gap: 15,
                children: [
                  LzForm.input(
                    enabled: false,
                    label: 'No Pengajuan',
                    model: forms.key('no_pengajuan'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Nama Alat',
                    model: forms.key('nama_alat'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Uraian Pekerjaan',
                    model: forms.key('uraian_pekerjaan'),
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

  /// Fungsi ubah status jadi teks
  String _statusText(dynamic status) {
    switch (status) {
      case 0:
        return 'Menunggu Validasi';
      case 1:
        return 'Disetujui';
      case 2:
        return 'Ditolak';
      default:
        return '-';
    }
  }
}
