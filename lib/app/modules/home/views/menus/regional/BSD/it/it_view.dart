import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';

import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/bsd.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/arsip%20it/tab_arsip_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/artikel%20teknik/artikel_teknik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/aset%20electronik%20it/aset_electronik_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/data%20akun/data_akun_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/laporan%20it/laporan_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/masa_tanggang/masa_tanggang_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/pengajuan%20it/pengajuan_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/ptj%20it/ptj_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/rab%20it/rab_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/saldo%20it/saldo_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/surat%20masuk%20it/surat_keluar_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/surat%20masuk%20it/surat_masuk_it_view.dart';
import 'package:qrm_dev/app/widgets/transisi/icon_transisi.dart';
import '../../../../../../../widgets/custom_appbar_widget.dart';

class ItView extends StatefulWidget {
  const ItView({super.key});

  @override
  State<ItView> createState() => _ItViewState();
}

class _ItViewState extends State<ItView> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _fadeAnimations;
  late final List<Animation<double>> _scaleAnimations;
  final labels = [
    'Arsip',
    'Aset Elektronik',
    'Data Akun',
    'Laporan Kerja',
    'Masa Tanggang',
    'Pengajuan',
    'PTJ',
    'RAB',
    'Saldo',
    'Surat Keluar',
    'Surat Masuk',
    'Artikel Teknik'
  ];
  final icons = [
    'assets/images/arsip02.png',
    'assets/images/computer01.png',
    'assets/images/akun01.png',
    'assets/images/fileHand.png',
    'assets/images/analisis01.png',
    'assets/images/listDock01.png',
    'assets/images/listDock02.png',
    'assets/images/fileDolar01.png',
    'assets/images/wallet01.png',
    'assets/images/mailUp01.png',
    'assets/images/mailDown01.png',
    'assets/images/arsip02.png',
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
    '2a84be'.hex,
  ];
  @override
  void initState() {
    super.initState();
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
      appBar: CustomAppbar(title: 'Menu IT').appBar,
      body: LzListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Wrap(
              spacing: MediaQuery.of(context).size.width * 0.05,
              runSpacing: 20,
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
                                Get.to(() => TabArsipItView());
                              } else if (i == 1) {
                                Get.to(() => AsetElectronikItView());
                              } else if (i == 10) {
                                Get.to(() => SuratMasukItView());
                              } else if (i == 9) {
                                Get.to(() => SuratKeluarItView());
                              } else if (i == 11) {
                                Get.to(() => ArtikelTeknikView());
                              } else if (i == 3) {
                                Get.to(() => LaporanItView());
                              } else if (i == 8) {
                                Get.to(() => SaldoItView());
                              } else if (i == 5) {
                                Get.to(() => PengajuanItView());
                              } else if (i == 7) {
                                Get.to(() => RabItView());
                              } else if (i == 2) {
                                Get.to(() => DataAkunItView());
                              } else if (i == 4) {
                                Get.to(() => MasaTanggangItView());
                              } else if (i == 6) {
                                Get.to(() => PtjItView(
                                      type: 'Kantor',
                                    ));
                              }
                            },
                            child: buildMenuIcons(
                              icons[i],
                              MediaQuery.of(context).size.width * 0.13,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            labels[i],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
