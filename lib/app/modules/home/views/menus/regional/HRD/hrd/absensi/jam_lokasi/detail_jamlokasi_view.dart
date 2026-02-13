// import 'package:flutter/material.dart';
// import 'package:lazyui/lazyui.dart';
// import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

// class DetailJamlokasiView extends StatelessWidget {
//   DetailJamlokasiView({
//     super.key,
//     this.name,
//     this.address,
//     this.timein,
//     this.timeout,
//     this.radius,
//     this.latitudelongtitude,
//   });

//   final String? name;
//   final String? address;
//   final String? timein;
//   final String? timeout;
//   final String? radius;
//   final String? latitudelongtitude;

//   final OutlineInputBorder borderStyle = OutlineInputBorder(
//     borderRadius: BorderRadius.circular(10),
//     borderSide: const BorderSide(color: Colors.black, width: 2),
//   );

//   final TextEditingController namaController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController timeinController = TextEditingController();
//   final TextEditingController timeoutController = TextEditingController();
//   final TextEditingController radiusController = TextEditingController();
//   final TextEditingController latitudelongtitudeController =
//       TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     namaController.text = name ?? '';
//     addressController.text = address ?? '';
//     timeinController.text = timein ?? '';
//     timeoutController.text = timeout ?? '';
//     radiusController.text = radius ?? '';
//     latitudelongtitudeController.text = latitudelongtitude ?? '';

//     if (latitudelongtitude != null &&
//         RegExp(r'^-?\d+(\.\d+)?\s*,\s*-?\d+(\.\d+)?$')
//             .hasMatch(latitudelongtitude!)) {
//       final parts = latitudelongtitude!.split(',');
//       final lat = double.tryParse(parts[0].trim());
//       final lng = double.tryParse(parts[1].trim());
//       if (lat != null && lng != null) {}
//     }

//     return Scaffold(
//      appBar: CustomAppbar(
//           title: 'Shift Detail',
//         ).appBar,
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: LzListView(
//           children: [
//             TextFormField(
//               readOnly: true,
//               controller: namaController,
//               maxLines: 1,
//               decoration: InputDecoration(
//                 labelText: 'Nama Alamat',
//                 labelStyle: const TextStyle(fontWeight: Fw.bold),
//                 border: borderStyle,
//                 focusedBorder: borderStyle.copyWith(
//                   borderSide: borderStyle.borderSide.copyWith(
//                     color: const Color.fromARGB(255, 0, 61, 230),
//                     width: 2,
//                   ),
//                 ),
//               ),
//             ),
//             15.height,
//             TextFormField(
//               readOnly: true,
//               controller: addressController,
//               maxLines: 1,
//               decoration: InputDecoration(
//                 labelText: 'Alamat',
//                 labelStyle: const TextStyle(fontWeight: Fw.bold),
//                 border: borderStyle,
//                 focusedBorder: borderStyle.copyWith(
//                   borderSide: borderStyle.borderSide.copyWith(
//                     color: const Color.fromARGB(255, 0, 61, 230),
//                     width: 2,
//                   ),
//                 ),
//               ),
//             ),
//             15.height,
//             Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     readOnly: true,
//                     controller: timeinController,
//                     decoration: InputDecoration(
//                       labelText: 'Jam Masuk',
//                       labelStyle: const TextStyle(fontWeight: Fw.bold),
//                       border: borderStyle,
//                       focusedBorder: borderStyle.copyWith(
//                         borderSide: borderStyle.borderSide.copyWith(
//                           color: const Color.fromARGB(255, 0, 61, 230),
//                           width: 2,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 15),
//                 Expanded(
//                   child: TextFormField(
//                     readOnly: true,
//                     controller: timeoutController,
//                     decoration: InputDecoration(
//                       labelText: 'Jam Pulang',
//                       labelStyle: const TextStyle(fontWeight: Fw.bold),
//                       border: borderStyle,
//                       focusedBorder: borderStyle.copyWith(
//                         borderSide: borderStyle.borderSide.copyWith(
//                           color: const Color.fromARGB(255, 0, 61, 230),
//                           width: 2,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             20.height,
//             TextFormField(
//               readOnly: true,
//               controller: radiusController,
//               maxLines: 1,
//               decoration: InputDecoration(
//                 labelText: 'Radius',
//                 labelStyle: const TextStyle(fontWeight: Fw.bold),
//                 border: borderStyle,
//                 focusedBorder: borderStyle.copyWith(
//                   borderSide: borderStyle.borderSide.copyWith(
//                     color: const Color.fromARGB(255, 0, 61, 230),
//                     width: 2,
//                   ),
//                 ),
//               ),
//             ),
//             20.height,
//             TextFormField(
//               readOnly: true,
//               controller: latitudelongtitudeController,
//               maxLines: 1,
//               decoration: InputDecoration(
//                 labelText: 'latitude longtitude',
//                 labelStyle: const TextStyle(fontWeight: Fw.bold),
//                 border: borderStyle,
//                 focusedBorder: borderStyle.copyWith(
//                   borderSide: borderStyle.borderSide.copyWith(
//                     color: const Color.fromARGB(255, 0, 61, 230),
//                     width: 2,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
