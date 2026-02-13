import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';

import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/bsd.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/legal_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/logistik_jkt_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/logistik_view.dart';
import 'package:qrm_dev/app/widgets/transisi/icon_transisi.dart';
import '../../../../../../../widgets/custom_appbar_widget.dart';

class OperasiScmView extends StatefulWidget {
  const OperasiScmView({super.key});

  @override
  State<OperasiScmView> createState() => _OperasiScmViewState();
}

class _OperasiScmViewState extends State<OperasiScmView>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _fadeAnimations;
  late final List<Animation<double>> _scaleAnimations;
  final labels = [
    'Arsip',
    'Legal',
    'Logistik Dan Administrasi SCM',
    'Logistik Dan Administrasi SCM Reg. Barat',
    'KPI',
    'Pengajuan',
    'PTJ',
    'Rencana Dan Laporan',
    'Saldo',
    'Surat Masuk',
    'Surat Keluar',
  ];
  final icons = [
    'assets/images/arsip02.png',
    'assets/images/bank01.png',
    'assets/images/logistik01.png',
    'assets/images/logistik02.png',
    'assets/images/userGroup02.png',
    'assets/images/listDock01.png',
    'assets/images/listDock02.png',
    'assets/images/fileHand.png',
    'assets/images/wallet01.png',
    'assets/images/mailDown01.png',
    'assets/images/mailUp01.png',
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
    '9f68dd'.hex,
    '9f68dd'.hex,
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
      appBar: CustomAppbar(title: 'Menu Operasi SCM').appBar,
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
                              if (i == 1) {
                                Get.to(() => LegalView());
                              } else if (i == 2) {
                                Get.to(() => LogistikView());
                              } else if (i == 3) {
                                Get.to(() => LogistikJktView());
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
