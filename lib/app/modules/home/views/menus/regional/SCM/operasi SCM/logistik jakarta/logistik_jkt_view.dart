import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/alat%20proyek%20logistik%20jkt/alat_proyek_log_jkt_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/aset_kantor%20jkt/aset_kantor_jkt_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/delivery%20pembelian%20non%20ppn%20jkt/del_pemb_jkt_non_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/delivery%20pembelian%20ppn%20jkt/del_pemb_ppn_jkt_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/invoice%20delivery%20pembelian%20logistik%20jkt/invoice%20deliveri%20pembelian%20non%20ppn/inv_del_pemb_jkt_non_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/invoice%20delivery%20pembelian%20logistik%20jkt/invoice%20deliveri%20pembelian%20ppn/inv_del_pemb_jkt_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/kartu%20stok%20logistik%20jkt/kartu_stok_jkt_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/kendaraan%20logistik%20jkt/kendaraan_logistik_jkt_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/pembelian%20non%20ppn%20jkt/pemb_non_ppn_jkt_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/pembelian%20ppn%20jkt/pemb_ppn_jkt_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/service%20aset%20jkt/service_aset_logistik_jkt_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/stok%20material%20logistik%20jkt/stok_material_logistik_jkt_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/stok%20opname%20jkt/stok_opname_jkt_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/surat%20jalan%20logistik%20jkt/surat%20jalan%20eksternal%20jkt%20non%20ppn/surat_jalan_exst_jkt_non_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/surat%20jalan%20logistik%20jkt/surat%20jalan%20eksternal%20jkt/surat_jalan_exst_jkt_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/surat%20jalan%20logistik%20jkt/surat%20jalan%20internal%20jkt/surat_jalan_internal_jkt_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_show_menu.dart';

class LogistikJktView extends StatelessWidget {
  const LogistikJktView({super.key});

  @override
  Widget build(BuildContext context) {
    final label = [
      'Alat Proyek',
      'Arisp',
      'Asest Kantor',
      'Del Pembelian PPN',
      'Del Pembelian Non PPN',
      'Invoice Del Pembelian',
      'Kartu Stok',
      'Kendaraan',
      'Pembelian PPN',
      'Pembelian Non PPN', //
      'Service Aset',
      'Stok Material',
      'Stok Opname',
      'Surat Jalan',
      'Validasi Return',
      'Validasi Alat Pm',
      'Validasi Return Alat Pm',
    ];

    final colors = [
      '9f68dd'.hex,
      '2a84be'.hex,
      'f2b924'.hex,
      '467bf6'.hex,
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
    ];

    final icons = [
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
      Hi.note,
      Hi.note,
      Hi.note,
    ];
    return Scaffold(
      appBar: CustomAppbar(title: 'Logistik Reg. Barat').appBar,
      body: SafeArea(
        child: LzListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Wrap(
                spacing: MediaQuery.of(context).size.width * 0.05,
                runSpacing: 25,
                children: List.generate(label.length, (i) {
                  final itemWidth =
                      (MediaQuery.of(context).size.width - (27 * 1)) / 6;

                  return SizedBox(
                    width: itemWidth,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (i == 0) {
                              Get.to(() => AlatProyekLogJktView());
                            } else if (i == 2) {
                              Get.to(() => AsetKantorJktView());
                            } else if (i == 1) {
                              Get.to(() => AsetKantorJktView());
                            } else if (i == 3) {
                              Get.to(() => DelPembPpnJktView());
                            } else if (i == 8) {
                              Get.to(() => PembPpnJktView());
                            } else if (i == 9) {
                              Get.to(() => PembNonPpnJktView());
                            } else if (i == 4) {
                              Get.to(() => DelPembJktNonPpnView());
                            } else if (i == 5) {
                              CustomShowMenu.showDialogWithOptions(
                                context,
                                title: 'Pilih invoice',
                                options: [
                                  DialogOption(
                                    label: 'Invoive Material Po Non Ppn',
                                    onTap: () => Get.to(
                                        () => const InvDelPembJktNonPpnView()),
                                  ),
                                  DialogOption(
                                    label: 'Invoive Material Po Ppn',
                                    onTap: () => Get.to(
                                        () => const InvDelPembJktPpnView()),
                                  ),
                                ],
                              );
                            } else if (i == 6) {
                              Get.to(() => KartuStokJktLogistikView());
                            } else if (i == 7) {
                              Get.to(() => KendaraanLogistikJktView());
                            } else if (i == 10) {
                              Get.to(() => ServiceAsetLogistikJktView());
                            } else if (i == 11) {
                              Get.to(() => StokMaterialLogistikJktView());
                            } else if (i == 12) {
                              Get.to(() => StokOpnameJktView());
                            } else if (i == 13) {
                              CustomShowMenu.showDialogWithOptions(
                                context,
                                title: 'Pilih Surat Jalan',
                                options: [
                                  DialogOption(
                                    label: 'Surat Jalan Internal',
                                    onTap: () => Get.to(() =>
                                        const SuratJalanInternalJktView()),
                                  ),
                                  DialogOption(
                                    label: 'Surat Jalan Eksternal NON PPN',
                                    onTap: () => Get.to(
                                        () => const SuratJalanExstJktNonView()),
                                  ),
                                  DialogOption(
                                    label: 'Surat Jalan Eksternal',
                                    onTap: () => Get.to(
                                        () => const SuratJalanExstJktView()),
                                  ),
                                ],
                              );
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
                          label[i],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
