import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/pas_bandara_hrd/detail_orang.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/pas%20bandara%20controller/detail_orang_pasban_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/pas%20bandara/show%20dialog%20pasban/foto_pasband_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class DetailOrangPasBandaraView extends StatelessWidget {
  final DetailOrang data;
  const DetailOrangPasBandaraView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailOrangPasbanController());
    controller.fillForm(data);
    final forms = controller.forms;

    final fotoDiri = data.fotoDiri;
    final fotoKk = data.fotoKk;
    final fotoKtp = data.fotoKtp;
    final fotoSkck = data.fotoSkck;

    controller.setToken();

    return Scaffold(
      appBar: CustomAppbar(title: 'Informasi Pengajuan Pass Bandara (Orang)')
          .appBar,
      body: LzListView(
        autoCache: true,
        gap: 15,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Indentitas Diri',
            style: GoogleFonts.poppins()
                .copyWith(fontWeight: Fw.bold, fontSize: 20),
          ),
          LzForm.input(label: 'Nama', enabled: false, model: forms.key('nama')),
          LzForm.input(
              label: 'Alamat S1',
              enabled: false,
              model: forms.key('alamat_s1')),
          LzForm.input(
              label: 'No. Identitas Diri (KTP/SIM)',
              enabled: false,
              maxLines: 99,
              model: forms.key('ktp')),
          LzForm.input(
              label: 'Tempat, Tanggal Lahir',
              enabled: false,
              maxLines: 99,
              model: forms.key('ttl')),
          LzForm.input(
              label: 'Agama',
              enabled: false,
              maxLines: 99,
              model: forms.key('agama')),
          LzForm.input(
              label: 'Alamat',
              enabled: false,
              maxLines: 99,
              model: forms.key('alamat')),
          LzForm.input(
              label: 'Nomor Telp / HP',
              enabled: false,
              maxLines: 99,
              model: forms.key('no_telp')),
          LzForm.input(
              label: 'Nama Instansi / Perusahaan',
              enabled: false,
              maxLines: 99,
              model: forms.key('nama_instansi')),
          LzForm.input(
              label: 'Alamat Instansi / Perusahaan',
              enabled: false,
              maxLines: 99,
              model: forms.key('alamat_instansi')),
          LzForm.input(
              label: 'No. Telp & Fax Instansi / Perusahaan',
              enabled: false,
              maxLines: 99,
              model: forms.key('no_telp_fax_instansi')),
          LzForm.input(
              label: 'Posisi / Jabatan',
              enabled: false,
              maxLines: 99,
              model: forms.key('posisi')),
          LzForm.input(
              label: 'Status Pekerjaan',
              enabled: false,
              maxLines: 99,
              model: forms.key('status')),
          LzForm.input(
              label: 'Masa Kerja',
              enabled: false,
              maxLines: 99,
              model: forms.key('masa_kerja')),
          LzForm.input(
              label: 'Tempat Kerja Sebelumnya',
              enabled: false,
              maxLines: 99,
              model: forms.key('tempat_kerja_sebelumnya')),
          LzForm.input(
              label: 'Komentar GM',
              enabled: false,
              maxLines: 99,
              model: forms.key('komentar')),
          20.height,
          Text(
            'Informasi Keluarga',
            style: GoogleFonts.poppins()
                .copyWith(fontWeight: Fw.bold, fontSize: 20),
          ),
          LzForm.input(
              label: 'Nama Bapak',
              maxLines: 99,
              enabled: false,
              model: forms.key('nama_bpk')),
          LzForm.input(
              label: 'Nama Ibu', enabled: false, model: forms.key('nama_ibu')),
          LzForm.input(
              label: 'Alamat Bapak',
              maxLines: 99,
              enabled: false,
              model: forms.key('alamat_bpk')),
          LzForm.input(
              label: 'Nama Pasangan',
              maxLines: 99,
              enabled: false,
              model: forms.key('nama_pasangan')),
          LzForm.input(
              label: 'Alamat Pasangan',
              maxLines: 99,
              enabled: false,
              model: forms.key('alamat_pasangan')),
          LzForm.input(
              label: 'No. Telp Pasangan',
              maxLines: 99,
              enabled: false,
              model: forms.key('no_telp_pasangan')),
          Text(
            'Pendidikan',
            style: GoogleFonts.poppins()
                .copyWith(fontWeight: Fw.bold, fontSize: 20),
          ),
          Intrinsic(
            gap: 10,
            children: [
              LzForm.input(
                  label: 'Nama SD',
                  enabled: false,
                  model: forms.key('nama_sd')),
              LzForm.input(
                  label: 'Tahun SD',
                  enabled: false,
                  model: forms.key('tahun_sd')),
            ],
          ),
          LzForm.input(
              label: 'Alamat SD',
              enabled: false,
              model: forms.key('alamat_sd')),
          Intrinsic(
            gap: 10,
            children: [
              LzForm.input(
                  label: 'Nama SMP',
                  enabled: false,
                  model: forms.key('nama_smp')),
              LzForm.input(
                  label: 'Tahun SMP',
                  enabled: false,
                  model: forms.key('tahun_smp')),
            ],
          ),
          LzForm.input(
              label: 'Alamat SMP',
              enabled: false,
              model: forms.key('alamat_smp')),
          Intrinsic(
            gap: 10,
            children: [
              LzForm.input(
                  label: 'Nama SMA',
                  enabled: false,
                  model: forms.key('nama_sma')),
              LzForm.input(
                  label: 'Tahun SMA',
                  enabled: false,
                  model: forms.key('tahun_sma')),
            ],
          ),
          LzForm.input(
              label: 'Alamat SMA',
              enabled: false,
              model: forms.key('alamat_sma')),
          Intrinsic(
            gap: 10,
            children: [
              LzForm.input(
                  label: 'Nama Univ S1',
                  enabled: false,
                  model: forms.key('nama_univ1')),
              LzForm.input(
                  label: 'Tahun S1',
                  enabled: false,
                  model: forms.key('tahun_s1')),
            ],
          ),
          Text(
            'Data Foto',
            style: GoogleFonts.poppins()
                .copyWith(fontWeight: Fw.bold, fontSize: 20),
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              buildFoto(fotoDiri, controller.token ?? ''),
              buildFoto(fotoKtp, controller.token ?? ''),
              buildFoto(fotoKk, controller.token ?? ''),
              buildFoto(fotoSkck, controller.token ?? ''),
            ],
          )
        ],
      ),
    );
  }
}
