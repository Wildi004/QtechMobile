import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/RAB/rab_hrd_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/absensi/jam_lokasi/absensi_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/arsiv/arsip_hrd_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/cuti/hrd_cuti_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/karyawan_tetap/karyawan_tetap_viev.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/karyawan_tidak_tetap/karyawan_tidak_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/pengajuan_hrd/pengajuan_hrd_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/ptj/ptj_hrd_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/saldo/saldo_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/setting/setting_hrd_view.dart';

class HrdView extends StatelessWidget {
  const HrdView({super.key});
  @override
  Widget build(BuildContext context) {
    final label = [
      'Absensi',
      'Arsip Karyawan',
      'Setting',
      'Karyawan tetep',
      'Karyawan tidak tetap',
      'Cuti',
      'Pengajuan',
      'Saldo',
      'PTJ',
      'Laporan Kerja',
      'Surat Masuk',
      'Surat Keluar',
      'RAB',
    ];

    final colors = [
      // 'ff7f07'.hex,
      // '467bf6'.hex,
      // '06b3b4'.hex,
      // '9f68dd'.hex,
      // '9f68dd'.hex,
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
      '2a84be'.hex,
      'ff7581'.hex,
    ];

    final icons = [
      Hi.userCheck01,
      Hi.archive,
      Hi.settings01,
      Hi.userMultiple,
      Hi.userMultiple02,
      Hi.calendarLove02,
      Hi.calendar01,
      Hi.wallet01,
      Hi.note,
      Hi.checkList,
      Hi.mailOpen,
      Hi.mailDownload01,
      Hi.note,
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Menu HRD',
          style: TextStyle(color: Colors.white, fontWeight: Fw.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: ['4CA1AF'.hex, '808080'.hex],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
        ),
      ),
      body: LzListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Wrap(
              spacing: MediaQuery.of(context).size.width * 0.05,
              runSpacing: 25,
              children: List.generate(label.length, (i) {
                final itemWidth =
                    (MediaQuery.of(context).size.width - (20 * 1)) / 6;

                return SizedBox(
                  width: itemWidth,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (i == 0) {
                            context.openBottomSheet(AbsensiView());
                          } else if (i == 1) {
                            context.openBottomSheet(ArsipHrdView());
                          } else if (i == 2) {
                            context.openBottomSheet(SettingHrdView());
                          } else if (i == 3) {
                            context.openBottomSheet(KaryawanTetapViev());
                          } else if (i == 4) {
                            context.openBottomSheet(KaryawanTidakView());
                          } else if (i == 7) {
                            context.openBottomSheet(SaldoView());
                          } else if (i == 5) {
                            context.openBottomSheet(HrdCutiView());
                          } else if (i == 6) {
                            context.openBottomSheet(PengajuanHrdView());
                          } else if (i == 8) {
                            context.openBottomSheet(PtjHrdView());
                          } else if (i == 12) {
                            context.openBottomSheet(RabHrdView());
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
    );
  }
}
