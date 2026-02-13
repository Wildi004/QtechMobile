import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/alat%20proyek%20logistik/alat_proyek_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/arsip%20logistik/arsip_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/delivery%20pembelian%20non%20ppn/del_pemb_non_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/delivery%20pembelian%20ppn%20logistik/del_pemb_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/delivery%20po%20non%20ppn/del_po_non_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/delivery%20po%20ppn/del_po_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/ekpedisi%20logistik/ekpedisi_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/invoice%20delivery%20pembelian%20logistik/invoice%20deliveri%20pembelian%20non%20ppn/inv_del_pemb_non_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/invoice%20delivery%20pembelian%20logistik/invoice%20deliveri%20pembelian%20ppn/inv_del_pemb_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/invoice%20delivery%20po%20logistik/invoice%20deliveri%20material%20po%20non%20ppn/inv_del_po_non_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/invoice%20delivery%20po%20logistik/invoice%20delivery%20material%20po%20ppn/inv_del_po_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/kartu%20stok%20logistik/kartu_stok_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/kendaraan%20logistik/kendaraan_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/laporan%20kerja%20logistik/laporan_kerja_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/monitoring%20proyek%20barat/monitor_proyek_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/pembelian%20non%20ppn%20logistik/pemb_non_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/pembelian%20ppn%20logistik/pemb_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/pengajuan%20logistik/pengajuan_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/po%20non/po_non_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/po%20ppn/po_ppn_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/ptj%20logistik/ptj_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/rab%20logistik/rab_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/rbp%20rb/rbp_rb_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/rbp%20rj/rbp_rj_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/saldo%20logistik/saldo_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/service%20aset/service_aset_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/setting%20logistik/show%20dialog/show_setting_logistik.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/stok%20material/stok_material_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/stok%20opname/stok_opname_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/supplier%20logistik/supplier_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/surat%20jalan%20logistik/surat%20jalan%20eksternal%20non%20ppn/surat_jalan_exst_non_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/surat%20jalan%20logistik/surat%20jalan%20eksternal/surat_jalan_exst_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/surat%20jalan%20logistik/surat%20jalan%20internal/surat_jalan_internal_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/surat%20menyurat/surat%20masuk%20logistik/surat_masuk_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/validasi%20alat/validasi_alat_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_show_menu.dart';
import 'package:qrm_dev/app/widgets/transisi/icon_transisi.dart';

class LogistikView extends StatefulWidget {
  const LogistikView({super.key});

  @override
  State<LogistikView> createState() => _LogistikViewState();
}

class _LogistikViewState extends State<LogistikView>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _fadeAnimations;
  late final List<Animation<double>> _scaleAnimations;

  final labels = [
    'Alat Proyek',
    'Arisp',
    'Del. PO PPN',
    'Del. PO PPN (Non PPN)',
    'Del.pemb (PPN)',
    'Del.pemb (Non PPN)',
    'Exspedisi',
    'Inv. Del. PO',
    'Inv. Del. Pemb',
    'Kartu Stok', //9
    'Kendaraan',
    'Pembelian PPN',
    'Pembelian Non PPN ',
    'Pengajuan',
    'Po. (PPN)',
    'Po. (Non PPN)',
    'PTJ',
    'RBP RB',
    'RBP RJ',
    'Laporan Kerja', //19
    'RAB',
    'Saldo',
    'Service Aset',
    'Setting ',
    'Stock Material',
    'Stock Opname',
    'Surat Masuk',
    'Supplier',
    'Surat Jalan',
    'Validasi Return',
    'Validasi Alat',
    'Monitoring Material Proyek'
  ];

  final colors = [
    '9f68dd'.hex,
    '2a84be'.hex,
    'f2b924'.hex,
    '467bf6'.hex,
    '1dc9b1'.hex,
    '1dc9b1'.hex,
    '1dc9b1'.hex,
    '05d4f3'.hex,
    '92b53e'.hex,
    '9f68dd'.hex,
    '2a84be'.hex,
    'f2b924'.hex,
    '467bf6'.hex,
    '1dc9b1'.hex,
    '1dc9b1'.hex,
    '9f68dd'.hex,
    '2a84be'.hex,
    'ff7581'.hex,
    '05d4f3'.hex,
    '92b53e'.hex,
    '05d4f3'.hex,
    '92b53e'.hex,
    '2a84be'.hex,
    '9f68dd'.hex,
    '2a84be'.hex,
    '1dc9b1'.hex,
    '1dc9b1'.hex,
    '1dc9b1'.hex,
    '9f68dd'.hex,
    '1dc9b1'.hex,
    '2a84be'.hex,
    '2a84be'.hex,
  ];

  final icons = [
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note02,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note02,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
    Hi.note,
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
    final itemWidth = (MediaQuery.of(context).size.width - 20) / 6;

    return Scaffold(
      appBar: CustomAppbar(title: 'Menu Logistik').appBar,
      body: LzListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Wrap(
              spacing: MediaQuery.of(context).size.width * 0.05,
              runSpacing: 25,
              children: List.generate(labels.length, (i) {
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
                                Get.to(() => ArsipLogistikView());
                              } else if (i == 0) {
                                Get.to(() => AlatProyekLogistikView());
                              } else if (i == 23) {
                                ShowSettingLogistik.showMenu(context);
                              } else if (i == 21) {
                                Get.to(() => SaldoLogistikView());
                              } else if (i == 13) {
                                Get.to(() => PengajuanLogistikView());
                              } else if (i == 27) {
                                Get.to(() => SupplierLogistikView());
                              } else if (i == 20) {
                                Get.to(() => RabLogistikView());
                              } else if (i == 16) {
                                Get.to(() => PtjLogistikView(
                                      type: 'Kantor',
                                    ));
                              } else if (i == 19) {
                                Get.to(() => LaporanKerjaLogistikView());
                              } else if (i == 22) {
                                Get.to(() => ServiceAsetLogistikView());
                              } else if (i == 24) {
                                Get.to(() => StokMaterialLogistikView());
                              } else if (i == 10) {
                                Get.to(() => KendaraanLogistikView());
                              } else if (i == 6) {
                                Get.to(() => EkpedisiLogistikView());
                              } else if (i == 25) {
                                Get.to(() => StokOpnameView());
                              } else if (i == 17) {
                                Get.to(() => RbpRbLogistikView());
                              } else if (i == 14) {
                                Get.to(() => PoPpnLogistikView());
                              } else if (i == 18) {
                                Get.to(() => RbpRjLogistikView());
                              } else if (i == 15) {
                                Get.to(() => PoNonLogistikView());
                              } else if (i == 9) {
                                Get.to(() => KartuStokLogistikView());
                              } else if (i == 3) {
                                Get.to(() => DelPoNonView());
                              } else if (i == 11) {
                                Get.to(() => PembPpnView());
                              } else if (i == 12) {
                                Get.to(() => PembNonPpnView());
                              } else if (i == 2) {
                                Get.to(() => DelPoPpnView());
                              } else if (i == 5) {
                                Get.to(() => DelPembNonPpnView());
                              } else if (i == 7) {
                                CustomShowMenu.showDialogWithOptions(
                                  context,
                                  title: 'Pilih invoice',
                                  options: [
                                    DialogOption(
                                      label: 'Invoive Material Po Non Ppn',
                                      onTap: () => Get.to(
                                          () => const InvDelPoNonPpnView()),
                                    ),
                                    DialogOption(
                                      label: 'Invoive Material Po Ppn',
                                      onTap: () =>
                                          Get.to(() => const InvDelPoPpnView()),
                                    ),
                                  ],
                                );
                              } else if (i == 8) {
                                CustomShowMenu.showDialogWithOptions(
                                  context,
                                  title: 'Pilih invoice',
                                  options: [
                                    DialogOption(
                                      label:
                                          'Invoice Delivery Material Pembelian PPN',
                                      onTap: () => Get.to(
                                          () => const InvDelPembPpnView()),
                                    ),
                                    DialogOption(
                                      label:
                                          'Invoice Delivery Material Pembelian Non PPN',
                                      onTap: () => Get.to(
                                          () => const InvDelPembNonPpnView()),
                                    ),
                                  ],
                                );
                              } else if (i == 4) {
                                Get.to(() => DelPembPpnView());
                              } else if (i == 27) {
                                Get.to(() => SuratMasukLogistikView());
                              } else if (i == 28) {
                                CustomShowMenu.showDialogWithOptions(
                                  context,
                                  title: 'Pilih Surat Jalan',
                                  options: [
                                    DialogOption(
                                      label: 'Surat Jalan Internal',
                                      onTap: () => Get.to(
                                          () => const SuratJalanInternalView()),
                                    ),
                                    DialogOption(
                                      label: 'Surat Jalan Eksternal NON PPN',
                                      onTap: () => Get.to(
                                          () => const SuratJalanExstNonView()),
                                    ),
                                    DialogOption(
                                      label: 'Surat Jalan Eksternal',
                                      onTap: () => Get.to(
                                          () => const SuratJalanExstView()),
                                    ),
                                  ],
                                );
                              } else if (i == 30) {
                                Get.to(() => ValidasiAlatView());
                              } else if (i == 31) {
                                Get.to(() => MonitorProyekView());
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
                                color: Colors.black,
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
