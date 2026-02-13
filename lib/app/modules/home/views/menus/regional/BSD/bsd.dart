import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/arsip%20perusahaan/arsip_perusahaan_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/data%20kontrak/data_kontrak_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/dir_bsd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/rnd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/surat%20eksternal/surat_eksternal_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/transisi/icon_transisi.dart';

class Bsd extends StatefulWidget {
  const Bsd({super.key});

  @override
  State<Bsd> createState() => _BsdState();
}

class _BsdState extends State<Bsd> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _fadeAnimations;
  late final List<Animation<double>> _scaleAnimations;

  final labels = [
    'Arsip Perusahaan',
    'Data Kontrak',
    'Direktur\nBSD',
    'IT',
    'RND',
    'Surat Eksternal',
  ];

  final colors = [
    '9f68dd'.hex,
    '2a84be'.hex,
    'f2b924'.hex,
    'f2b924'.hex,
    'ff7581'.hex,
    'ff7581'.hex,
  ];

  final icons = [
    'assets/images/arsip03.png',
    'assets/images/notePen01.png',
    'assets/images/person01.png',
    'assets/images/chip01.png',
    'assets/images/idea01.png',
    'assets/images/mail01.png',
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
      appBar: CustomAppbar(title: 'Menu BSD').appBar,
      body: LzListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Wrap(
              spacing: MediaQuery.of(context).size.width * 0.06,
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
                              if (i == 2) {
                                Get.to(() => DirBsdView());
                              } else if (i == 3) {
                                Get.to(() => ItView());
                              } else if (i == 5) {
                                Get.to(() => SuratEksternalView());
                              } else if (i == 0) {
                                Get.to(() => ArsipPerusahaanView());
                              } else if (i == 1) {
                                Get.to(() => DataKontrakView());
                              } else if (i == 4) {
                                Get.to(() => RndView());
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

Widget buildMenuIcons(dynamic icon, double size) {
  if (icon is String) {
    return Image.asset(
      icon,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }

  if (icon is IconData) {
    return Icon(
      icon,
      size: size,
      color: Colors.black,
    );
  }

  return Icon(
    Hi.files01,
    size: size,
  );
}
