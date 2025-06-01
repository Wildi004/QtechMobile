import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/data_proyek.dart';
import 'package:qrm/app/modules/monitoring_proyek/controllers/monitor_controller.dart';

class SettingMonitoringView extends GetView<MonitorController> {
  final DataProyek? data;
  const SettingMonitoringView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Monitoring Proyek',
          style: TextStyle(color: Colors.white),
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
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Obx(() {
              return Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: controller.tabIndex.value == 0
                      ? LinearGradient(
                          colors: ['4CA1AF'.hex, '808080'.hex], // warna gradien
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        )
                      : LinearGradient(
                          colors: ['4CA1AF'.hex, '808080'.hex], // warna gradien
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                ),
                child: Center(
                  child: Text(
                    data?.kodeProyek ?? '-',
                    style: GoogleFonts.notoSerif().copyWith(
                      color: Colors.white,
                      fontWeight: Fw.bold,
                    ),
                  ),
                ),
              );
            }),
            SizedBox(height: 20),
            Obx(() {
              int active = controller.tabIndex.value;
              return Align(
                alignment: Alignment.center,
                child: IntrinsicWidth(
                  child: LzTabView(
                    tabs: const [
                      'Informasi Umun',
                      'Hasil Perhitungan',
                    ],
                    onTap: (key, i) {
                      controller.tabIndex.value = i;
                    },
                    builder: (label, i) {
                      bool isActive = active == i;
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color.fromARGB(255, 173, 155, 38)
                              : const Color.fromARGB(255, 243, 238, 238),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black),
                        ),
                        margin: EdgeInsets.only(left: i == 0 ? 0 : 8),
                        child: Text(
                          label,
                          style: TextStyle(
                            color: isActive ? Colors.white : Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (controller.tabIndex.value == 0) {
                  return LzListView(
                    gap: 20,
                    children: [
                      LzForm.input(
                          enabled: false,
                          label: 'Kode Proyek',
                          model: forms.key('kode_proyek')),
                      LzForm.input(
                          maxLines: 10,
                          enabled: false,
                          label: 'Judul Pekerjaan',
                          model: forms.key('judul_kontrak')),
                      LzForm.input(
                          enabled: false,
                          label: 'Nilai Kontrak',
                          model: forms.key('nilai_kontrak')),
                      LzForm.input(
                          enabled: false,
                          label: 'No Kontrak',
                          model: forms.key('no_kontrak')),
                      Row(
                        children: [
                          Expanded(
                            child: LzForm.input(
                              enabled: false,
                              label: 'Area Proyek',
                              model: forms.key('area_proyek_id'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: LzForm.input(
                              enabled: false,
                              label: 'Tanggal Kontrak',
                              model: forms.key('tgl_kontrak'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: LzForm.input(
                              enabled: false,
                              label: 'Durasi kontrak',
                              model: forms.key('durasi_kontrak'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: LzForm.input(
                              enabled: false,
                              label: 'Durasi Proyek',
                              model: forms.key('durasi_proyek'),
                            ),
                          ),
                        ],
                      ),
                      LzForm.input(
                        maxLines: 10,
                        enabled: false,
                        label: 'Lokasi Proyek',
                        model: forms.key('lokasi_proyek'),
                      ),
                      LzForm.input(
                        maxLines: 10,
                        enabled: false,
                        label: 'Perusahaan Pemberi Kerja Area Proyek',
                        model: forms.key('nama_pemberi_kerja'),
                      ),
                    ],
                  );
                } else if (controller.tabIndex.value == 1) {
                  return LzListView(
                    gap: 20,
                    children: [
                      LzForm.input(
                        maxLines: 10,
                        enabled: false,
                        label: 'Total Beban Proyek',
                        model: forms.key('jumlah_total'),
                      ),
                      LzForm.input(
                        maxLines: 10,
                        enabled: false,
                        label: 'Nilai Penawaran/Nilai Kontrak',
                        model: forms.key('nilai_kontrak'),
                      ),
                      LzForm.input(
                        maxLines: 10,
                        enabled: false,
                        label: 'Nilai Pendapatan',
                        model: forms.key('dpp_pendapatan'),
                      ),
                      LzForm.input(
                        maxLines: 10,
                        enabled: false,
                        label: 'Management Fee Kantor',
                        model: forms.key('man_fee_kantor'),
                      ),
                      LzForm.input(
                        maxLines: 10,
                        enabled: false,
                        label: 'Komitmen Fee Kantor',
                        model: forms.key('kom_fee_kantor'),
                      ),
                      LzForm.input(
                        maxLines: 10,
                        enabled: false,
                        label: 'Nilai PPH',
                        model: forms.key('nilai_pph'),
                      ),
                      LzForm.input(
                        maxLines: 10,
                        enabled: false,
                        label: 'Nilai PPN',
                        model: forms.key('nilai_ppn'),
                      ),
                      LzForm.input(
                        maxLines: 10,
                        enabled: false,
                        label: 'Nilai SCF',
                        model: forms.key('nilai_scf'),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lazyui/lazyui.dart';
// import 'package:qrm/app/data/models/data_proyek.dart';
// import 'package:qrm/app/modules/monitoring_proyek/controllers/monitor_controller.dart';
// import 'package:qrm/app/modules/monitoring_proyek/views/setting_monitoring/informasi_umum.dart';
// import 'package:qrm/app/modules/reg_pusat/views/hasil_perhitungan_view.dart';

// class SettingMonitoringView extends GetView<MonitorController> {
//   final DataProyek? data;
//   const SettingMonitoringView({super.key, this.data});

//   @override
//   Widget build(BuildContext context) {
//     final forms = controller.forms;
//     if (data != null) {
//       forms.fill(data!.toJson());
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Monitoring proyek",
//           style: TextStyle(color: Colors.white, fontWeight: Fw.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 6, 91, 122),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(0),
//         child: Column(
//           children: [
//             Obx(() {
//               return Container(
//                 height: 50,
//                 // color: const Color.fromARGB(255, 6, 91, 122),
//                 color: controller.tabIndex.value == 0
//                     ?const Color.fromARGB(255, 6, 91, 122)
//                     : const Color.fromARGB(255, 6, 91, 122),
//                 child: Center(
//                     child: Text(
//                   data?.kodeProyek ?? '-',
//                   style:  GoogleFonts.notoSerif().copyWith(color: Colors.white, fontWeight: Fw.bold),
//                 )),
//               );
//             }),
//             SizedBox(height: 20),
//             Obx(() {
//               int active = controller.tabIndex.value;
//               return Align(
//                 alignment: Alignment.center,
//                 child: IntrinsicWidth(
//                   child: LzTabView(
//                     tabs: const [
//                       'Informasi Umun',
//                       'Hasil Perhitungan',
//                     ],
//                     onTap: (key, i) {
//                       controller.tabIndex.value = i;
//                     },
//                     builder: (label, i) {
//                       bool isActive = active == i;
//                       return Container(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 8, horizontal: 16),
//                         decoration: BoxDecoration(
//                           color: isActive
//                               ? const Color.fromARGB(255, 173, 155, 38)
//                               : const Color.fromARGB(255, 243, 238, 238),
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(color: Colors.black),
//                         ),
//                         margin: EdgeInsets.only(left: i == 0 ? 0 : 8),
//                         child: Text(
//                           label,
//                           style: TextStyle(
//                             color: isActive ? Colors.white : Colors.black,
//                             fontSize: MediaQuery.of(context).size.width * 0.04,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               );
//             }),
//             const SizedBox(height: 10),
//             Expanded(
//               child: Obx(() {
//                 return controller.tabIndex.value == 0
//                     ? InformasiUmum()
//                     : HasilPerhitunganView();
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
