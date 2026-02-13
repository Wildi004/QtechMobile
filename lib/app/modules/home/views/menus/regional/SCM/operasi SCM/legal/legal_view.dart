import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/bsd.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/arsip%20legal/arsip_legal_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/list%20eproc%20legal/list_eproc_legal_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/ptj%20legal/ptj_legal_view.dart';
import 'package:qrm_dev/app/widgets/transisi/icon_transisi.dart';

import '../../../../../../../../widgets/custom_appbar_widget.dart';

class LegalView extends StatefulWidget {
  const LegalView({super.key});

  @override
  State<LegalView> createState() => _LegalViewState();
}

class _LegalViewState extends State<LegalView> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _fadeAnimations;
  late final List<Animation<double>> _scaleAnimations;
  final label = [
    'Arsip',
    'List Eproc',
    'PTJ',
  ];

  final icons = [
    'assets/images/arsip02.png',
    'assets/images/note01.png',
    'assets/images/listDock02.png',
  ];

  final colors = [
    '92b53e'.hex,
    '9f68dd'.hex,
  ];

  @override
  void initState() {
    super.initState();
    _controllers =
        AnimatedGridHelper.makeControllers(length: label.length, vsync: this);
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
    final itemWidth = (MediaQuery.of(context).size.width - 20) / 6;

    return Scaffold(
      appBar: CustomAppbar(title: 'Menu Legal').appBar,
      body: LzListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Wrap(
              spacing: MediaQuery.of(context).size.width * 0.05,
              runSpacing: 25,
              children: List.generate(label.length, (i) {
                return AnimatedBuilder(
                  animation: _controllers[i],
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimations[i].value,
                      child: Transform.scale(
                        scale: _scaleAnimations[i].value,
                        child: child,
                      ),
                    );
                  },
                  child: SizedBox(
                    width: itemWidth,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (i == 0) {
                              Get.to(() => ArsipLegalView());
                            } else if (i == 1) {
                              Get.to(() => ListEprocLegalView());
                            } else if (i == 2) {
                              Get.to(() => PtjLegalView(
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
                          label[i],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
