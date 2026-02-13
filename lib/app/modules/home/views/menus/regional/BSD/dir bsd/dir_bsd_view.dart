import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/bsd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/arsip%20bsd/tab_arsip_bsd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/kasbon%20dep%20bsd/kasbon_dep_bsd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/pengajuan%20dep%20bsd/pengajuan_dep_bsd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/ptj%20dep%20bsd/ptj_dep_bsd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/saldo%20dep%20bsd/saldo_dep_bsd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/setting%20bsd/kategori%20rk/kat_rk_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/surat%20masuk%20bsd/surat_keluar_bsd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/surat%20masuk%20bsd/surat_masuk_bsd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/val_dir_bsd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/invoice%20delivery%20po%20logistik/invoice%20delivery%20material%20po%20ppn/inv_del_po_ppn_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_show_menu.dart';
import 'package:qrm_dev/app/widgets/transisi/icon_transisi.dart';

import '../../../../../../monitoring_proyek/views/monitor_view.dart';

class DirBsdView extends StatefulWidget {
  const DirBsdView({super.key});

  @override
  State<DirBsdView> createState() => _DirBsdViewState();
}

class _DirBsdViewState extends State<DirBsdView> with TickerProviderStateMixin {
  final controller = Get.put(DirBsdController());

  late List<AnimationController> _controllers;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<double>> _scaleAnimations;

  final labels = [
    'Arsip Dir. BSD',
    'KPI',
    'Pengajuan Dir. BSD',
    'PTJ Dir. BSD',
    'Saldo Dir. BSD',
    'Setting',
    'Surat Keluar Dir. BSD',
    'Surat Masuk Dir. BSD',
    'Validasi Dir. BSD',
    'Monitoring Proyek',
  ];

  final icons = [
    'assets/images/arsip02.png',
    'assets/images/userGroup02.png',
    'assets/images/fileHand.png',
    'assets/images/listDock01.png',
    'assets/images/card01.png',
    'assets/images/setting01.png',
    'assets/images/mailUp01.png',
    'assets/images/mailDown01.png',
    'assets/images/filelist01.png',
    'assets/images/monitorSeo.png',
  ];

  @override
  void initState() {
    super.initState();

    _controllers = AnimatedGridHelper.makeControllers(
      length: controller.visibleIndexes.length,
      vsync: this,
    );

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
      appBar: CustomAppbar(title: 'Menu Dir. BSD').appBar,
      body: LzListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Obx(() {
              return Wrap(
                spacing: MediaQuery.of(context).size.width * 0.05,
                runSpacing: 25,
                children: List.generate(
                  controller.visibleIndexes.length,
                  (i) {
                    final index = controller.visibleIndexes[i];

                    return FadeTransition(
                      opacity: _fadeAnimations[i],
                      child: ScaleTransition(
                        scale: _scaleAnimations[i],
                        child: SizedBox(
                          width: itemWidth,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => _onTapMenu(index),
                                child: Image.asset(
                                  icons[index],
                                  width:
                                      MediaQuery.of(context).size.width * 0.13,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                labels[index],
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
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  void _onTapMenu(int index) {
    if (index == 0) {
      Get.to(() => TabArsipBsdView());
    } else if (index == 2) {
      CustomShowMenu.showDialogWithOptions(
        context,
        title: 'Jenis Pengajuan',
        options: [
          DialogOption(
            label: 'Pengajuan Departemen',
            onTap: () => Get.to(() => const PengajuanDepBsdView()),
          ),
          DialogOption(
            label: 'Pengajuan Kasbon',
            onTap: () => Get.to(() => const KasbonDepBsdView()),
          ),
          DialogOption(
            label: 'Pengajuan Gaji Karyawan',
            onTap: () => Get.to(() => const InvDelPoPpnView()),
          ),
        ],
      );
    } else if (index == 3) {
      Get.to(() => PtjDepBsdView());
    } else if (index == 4) {
      Get.to(() => SaldoDepBsdView());
    } else if (index == 5) {
      Get.to(() => KatRkView());
    } else if (index == 6) {
      Get.to(() => SuratKeluarBsdView());
    } else if (index == 7) {
      Get.to(() => SuratMasukBsdView());
    } else if (index == 8) {
      Get.to(() => ValDirBsdView());
    } else if (index == 9) {
      Get.to(() => MonitorView());
    }
  }
}
