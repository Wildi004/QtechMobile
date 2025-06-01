// import 'package:flutter/material.dart';
// import 'package:qrm/app/modules/cuti/controllers/cuti_controller.dart';

// class CutiForm extends StatelessWidget {
//   final CutiController controller;

//   const CutiForm(this.controller, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 320,
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Form Pengajuan Cuti",
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.orange),
//               ),
//               IconButton(
//                 icon: Icon(Icons.close, color: Colors.black),
//                 onPressed: controller.toggleForm,
//               ),
//             ],
//           ),

//           SizedBox(height: 10),

//           // Input "Tanggal Pengajuan"

//           SizedBox(height: 10),

//           // Input "Perihal Cuti"
//           TextField(
//             controller: controller.perihalCuti,
//             decoration: InputDecoration(
//               labelText: "Perihal Cuti",
//               border: OutlineInputBorder(),
//             ),
//           ),

//           SizedBox(height: 10),

//           // Label "Tanggal Mulai Cuti"
//           Text("Tanggal Mulai Cuti",
//               style: TextStyle(fontWeight: FontWeight.bold)),

//           SizedBox(height: 5),

//           // Input "Dari" dan "Sampai"
//           Row(
//             children: [
//               // Input "Dari"
//               Expanded(
//                 child: TextField(
//                   controller: controller.tanggalDari,
//                   decoration: InputDecoration(
//                     labelText: "Dari",
//                     border: OutlineInputBorder(),
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10),
//               // Input "Sampai"
//               Expanded(
//                 child: TextField(
//                   controller: controller.tanggalSampai,
//                   decoration: InputDecoration(
//                     labelText: "Sampai",
//                     border: OutlineInputBorder(),
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           SizedBox(height: 15),

//           // Tombol Kirim
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue[900],
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 padding: EdgeInsets.symmetric(vertical: 12),
//               ),
//               onPressed: controller.submitForm,
//               child: Text("KIRIM",
//                   style: TextStyle(color: Colors.white, fontSize: 16)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
