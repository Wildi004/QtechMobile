// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_laporan_kerja_controller/hrd_laporan_kerja_detail_controller.dart';
// import 'package:qrm_dev/app/widgets/custom_loading.dart';

// class LaporanKerjaHrdDetail extends GetView<HrdLaporanKerjaDetailController> {
//   final int id;

//   const LaporanKerjaHrdDetail({super.key, required this.id});

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.getData(id);
//     });

//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(title: const Text('Setting laporan')),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CustomLoading());
//         }

//         if (controller.pekerjaan.value == null) {
//           return const Center(child: Text('Data tidak ditemukan.'));
//         }

//         final data = controller.pekerjaan.value!;
//         return Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Nama Pekerjaan: ${data.namaPekerjaan ?? '-'}',
//                   style: const TextStyle(fontSize: 16)),
//               Text('Periode: ${data.periode ?? '-'}',
//                   style: const TextStyle(fontSize: 16)),
//               const SizedBox(height: 8),
//               Text('Tanggal Rencana: ${data.tglRencana ?? '-'}',
//                   style: const TextStyle(fontSize: 16)),
//               const SizedBox(height: 8),
//               Text('Tanggal Penyelesaian: ${data.tglPenyelesaian ?? '-'}',
//                   style: const TextStyle(fontSize: 16)),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
