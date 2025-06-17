import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/kasbon/views/kasbon_test_vies.dart';
import 'package:qrm/app/modules/monitoring_proyek/views/monitor_view.dart';
import 'package:qrm/app/routes/app_pages.dart';

class MenuEditView extends StatelessWidget {
  const MenuEditView({super.key});
  @override
  Widget build(BuildContext context) {
    final label = [
      'Kasbon',
      'Capaian Kinerja',
      'Modal Logistik',
      'Notulen',
    ];

    final colors = [
      'ff7f07'.hex,
      '467bf6'.hex,
      '06b3b4'.hex,
      '9f68dd'.hex,
    ];

    final icons = [
      Hi.bitcoinMoney01,
      Hi.file01,
      Hi.invoice,
      Hi.file02,
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          'Menu Favorite',
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
          Center(
              child: Text(
            'Pilih 4 menu favorit anda yang akan tampil pada halaman dashboard utama',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: Fw.bold),
          )),
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
                            Get.to(() => KasbonTestVies());
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
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width * 0.1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        label[i],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            width: double.infinity,
            child: Center(
              child: Container(
                height: 3,
                width: MediaQuery.of(context).size.width * 0.74,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color.fromARGB(255, 17, 113, 160),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: MediaQuery.of(context).size.width * 0.01,
            runSpacing: MediaQuery.of(context).size.width * 0.03,
            children: List.generate(9, (i) {
              final label = [
                'Anggaran Departemen',
                'Monitoring Project',
                'Brosur Logistik',
                'Daftar TKDN',
                'Surat Internal',
                'Job Desk',
                'SK Direksi',
                'Data Mandor',
                'Panduan intalasi',
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
              ];
              final icons = [
                Hi.note,
                Hi.chartLineData02,
                Hi.note01,
                Hi.fileAttachment,
                Hi.note,
                Hi.note,
                Hi.note01,
                Hi.fileAttachment,
                Hi.fileAttachment,
              ];
              return LayoutBuilder(
                builder: (context, constraints) {
                  double containerSize = constraints.maxWidth * 0.2;
                  double iconSize = constraints.maxWidth * 0.1;
                  return SizedBox(
                    width: containerSize * 1.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (i == 1) {
                              Get.to(() => MonitorView(),
                                  transition: Transition.fadeIn);
                            } else if (i == 2) {
                              Get.toNamed(Routes.BROSUR_LOGISTIK);
                            } else if (i == 3) {
                              Get.toNamed(Routes.DAFTAR_TKDN);
                            } else if (i == 6) {
                              Get.toNamed(Routes.SURAT_DIREKSI);
                            } else if (i == 5) {
                              Get.toNamed(Routes.JOB_DESK);
                            } else if (i == 4) {
                              Get.toNamed(Routes.SURAT_INTERNAL);
                            } else if (i == 7) {
                              Get.toNamed(Routes.DATA_MANDOR);
                            }
                          },
                          child: Container(
                            width: containerSize,
                            height: containerSize * 0.85,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors[i],
                            ),
                            child: Icon(
                              icons[i],
                              color: Colors.white,
                              size: iconSize,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          label[i],
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: containerSize * 0.18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
