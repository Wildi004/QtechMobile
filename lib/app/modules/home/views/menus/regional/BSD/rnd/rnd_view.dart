import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/arsip%20rnd/tab_arsip_rnd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/laporan%20rnd/laporan_rnd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/pengajuan%20rnd/pengajuan_rnd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/ptj%20rnd/ptj_rnd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/rab%20rnd/rab_rnd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/saldo%20rnd/saldo_rnd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/surat%20masuk%20rnd/surat_keluar_rnd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/surat%20masuk%20rnd/surat_masuk_rnd_view.dart';
import 'package:qrm_dev/app/widgets/transisi/icon_transisi.dart';
import '../../../../../../../widgets/custom_appbar_widget.dart';

class RndView extends StatefulWidget {
  const RndView({super.key});

  @override
  State<RndView> createState() => _RndViewState();
}

class _RndViewState extends State<RndView> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _fadeAnimations;
  late final List<Animation<double>> _scaleAnimations;

  final labels = [
    'arsip',
    'KPI',
    'Pengajuan',
    'PTJ',
    'Laporan Kerja',
    'RAB',
    'Saldo',
    'Surat Masuk',
    'Surat Keluar',
  ];

  final colors = [
    '9f68dd'.hex,
    '9f68dd'.hex,
    '9f68dd'.hex,
    '9f68dd'.hex,
    '9f68dd'.hex,
    '9f68dd'.hex,
    '9f68dd'.hex,
    '9f68dd'.hex,
    '9f68dd'.hex,
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
                                Get.to(() => TabArsipRndView());
                              } else if (i == 2) {
                                Get.to(() => PengajuanRndView());
                              } else if (i == 3) {
                                Get.to(() => PtjRndView(
                                      type: 'Kantor',
                                    ));
                              } else if (i == 4) {
                                Get.to(() => LaporanRndView());
                              } else if (i == 5) {
                                Get.to(() => RabRndView());
                              } else if (i == 6) {
                                Get.to(() => SaldoRndView());
                              } else if (i == 7) {
                                Get.to(() => SuratMasukRndView());
                              } else if (i == 8) {
                                Get.to(() => SuratKeluarRndView());
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
