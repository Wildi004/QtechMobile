import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/arsip%20perusahaan/arsip_perusahaan_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/data%20kontrak/data_kontrak_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/dekumentasi%20kendaraan/dok_ken_legal_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/kendaraan%20logistik/kendaraan_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/RAB/rab_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/absensi/absensi_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/aset%20kantor/aset_kantor_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/karyawan_tetap/karyawan_tetap_viev.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/karyawan_tidak_tetap/karyawan_tidak_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/laporan_kerja/laporan_kerja_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/pas%20bandara/pas_bandara_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/pengajuan_hrd/pengajuan_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/ptj/ptj_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/saldo/saldo_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/setting/cuti_hrd/cuti_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/setting/setting_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/surat%20masuk/surat_keluar_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/surat%20masuk/surat_masuk_hrd_view.dart';
import 'package:qrm_dev/app/widgets/custom_show_menu.dart';
import 'package:qrm_dev/app/widgets/transisi/icon_transisi.dart';
import '../../../../../../../widgets/custom_appbar_widget.dart';
import 'arsiv/arsip_karyawan/arsip_karyawan_view.dart';

class HrdView extends StatefulWidget {
  const HrdView({super.key});

  @override
  State<HrdView> createState() => _HrdViewState();
}

class _HrdViewState extends State<HrdView> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _fadeAnimations;
  late final List<Animation<double>> _scaleAnimations;

  final labels = [
    'Absensi', //0
    'Arsip Karyawan', //1
    'Arsip Perusahaan', //2
    'Aset Kantor', //3
    'CSR', //4
    'Cuti', //5
    'Dok. Kendaraan', //6
    'Jejak Karir', //7
    'Karyawan Tetap', //8
    'Karyawan Tidak Tetap', //9
    'Kendaraan', //10
    'KPI', //11
    'Lap. Kerja Karyawan', //12
    'Laporan Kerja', //13
    'Pas Bandara', //14
    'Pengajuan', //15
    'PTJ', //16
    'RAB', //17
    'Saldo', //18
    'Setting', //19
    'Surat Keluar',
    'Surat Masuk',
    'Data Kontrak'
  ];

  final colors = [
    '9f68dd'.hex,
    '2a84be'.hex,
    'ff7581'.hex,
    'f2b924'.hex,
    '467bf6'.hex,
    '1dc9b1'.hex,
    '1dc9b1'.hex,
    '05d4f3'.hex,
    '92b53e'.hex,
    '9f68dd'.hex,
    '9f68dd'.hex,
    '2a84be'.hex,
    '2a84be'.hex,
    '92b53e'.hex,
    '05d4f3'.hex,
    '9f68dd'.hex,
    '05d4f3'.hex,
    '1dc9b1'.hex,
    'ff7581'.hex,
    'ff7581'.hex,
    'ff7581'.hex,
    'ff7581'.hex,
    'ff7581'.hex,
  ];

  final icons = [
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
    Hi.file01,
  ];

  @override
  void initState() {
    super.initState();
    // Buat animasi
    _controllers =
        AnimatedGridHelper.makeControllers(length: labels.length, vsync: this);
    _fadeAnimations = AnimatedGridHelper.makeFadeAnimations(_controllers);
    _scaleAnimations = AnimatedGridHelper.makeScaleAnimations(_controllers);
    AnimatedGridHelper.runSequentially(_controllers, vsync: this);
  }

  @override
  void dispose() {
    AnimatedGridHelper.disposeControllers(_controllers);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Menu HRD').appBar,
      body: LzListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Wrap(
              spacing: MediaQuery.of(context).size.width * 0.05,
              runSpacing: 15,
              children: List.generate(labels.length, (i) {
                final itemWidth =
                    (MediaQuery.of(context).size.width - (20 * 1)) / 6;

                return FadeTransition(
                  opacity: _fadeAnimations[i],
                  child: ScaleTransition(
                    scale: _scaleAnimations[i],
                    child: SizedBox(
                      width: itemWidth,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (i == 0) {
                                Get.to(() => AbsensiView());
                              } else if (i == 1) {
                                Get.to(() => ArsipKaryawanView());
                              } else if (i == 2) {
                                Get.to(() => ArsipPerusahaanView());
                              } else if (i == 3) {
                                Get.to(() => AsetKantorHrdView());
                              } else if (i == 4) {
                                // Get.to(() => KaryawanTetapViev());
                              } else if (i == 5) {
                                Get.to(() => CutiHrdView());
                              } else if (i == 6) {
                                Get.to(() => DokKenLegalView());
                              } else if (i == 7) {
                                // Get.to(() => HrdCutiView());
                              } else if (i == 8) {
                                Get.to(() => KaryawanTetapViev());
                              } else if (i == 9) {
                                Get.to(() => KaryawanTidakView());
                              } else if (i == 10) {
                                Get.to(() => KendaraanLogistikView());
                              } else if (i == 11) {
                                // Get.to(() => LaporanKerjaHrdView());
                              } else if (i == 12) {
                                // Get.to(() => LaporanKerjaHrdView());
                              } else if (i == 13) {
                                Get.to(() => LaporanKerjaHrdView());
                              } else if (i == 14) {
                                CustomShowMenu.showDialogWithOptions(
                                  context,
                                  title: 'Pilih Regional',
                                  options: [
                                    DialogOption(
                                      label: 'Pas Bandara Regional Bali',
                                      onTap: () => Get.to(
                                          () => const PasBandaraHrdView()),
                                    ),
                                    DialogOption(
                                      label: 'Pas Bandara Regional Jakarta',
                                      onTap: () => Get.snackbar(
                                          'Maaf', 'Belum Tersedia'),
                                    ),
                                  ],
                                );
                              } else if (i == 15) {
                                Get.to(() => PengajuanHrdView());
                              } else if (i == 16) {
                                Get.to(() => PtjHrdView(
                                      type: 'Kantor',
                                    ));
                              } else if (i == 17) {
                                Get.to(() => RabHrdView());
                              } else if (i == 18) {
                                Get.to(() => SaldoView());
                              } else if (i == 19) {
                                Get.to(() => SettingHrdView());
                              } else if (i == 20) {
                                Get.to(() => SuratKeluarHrdView());
                              } else if (i == 21) {
                                Get.to(() => SuratMasukHrdView());
                              } else if (i == 22) {
                                Get.to(() => DataKontrakView());
                              }
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors[i],
                              ),
                              child: Icon(
                                icons[i],
                                color: const Color.fromARGB(255, 0, 0, 0),
                                size: MediaQuery.of(context).size.width * 0.09,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            labels[i],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
