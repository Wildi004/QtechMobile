// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:qrm_dev/app/modules/capaian_kinerja/controllers/capaian%20kinerja1/capaian_kerja1_controller.dart';

// class SplashScreenView extends StatelessWidget {
//   final CapaianKerja1Controller controller =
//       Get.put(CapaianKerja1Controller());
//   SplashScreenView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('data'),
//       ),
//       body: Container(
//         height: 200,
//         width: 200,
//         color: Colors.blue,
//         child: Obx(() {
//           final cap = controller.cap2.value;
//           return Text(cap.gagal?.toString() ?? 'o');
//         }),
//       ),
//     );
//   }
// }
