// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:lazyui/lazyui.dart';
// import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_pengajuan_controller/create_pengajuan_hrd_controller.dart';

// class CreatePengajuanHrdView extends StatelessWidget {
//   CreatePengajuanHrdView({super.key});
//   //

//   final controller = Get.put(CreatePengajuanHrdController());
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(CreatePengajuanHrdController());

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 243, 243, 243),
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         actions: [
//           IconButton(
//             onPressed: () {
//               controller.tambahFormBaru();
//             },
//             icon: const Icon(Hi.add01, color: Colors.white),
//           ),
//           IconButton(
//             onPressed: () {
//               if (_formKey.currentState!.validate()) {
//                 controller.updatePengajuan();
//               } else {
//                 Get.snackbar('Error', 'Mohon isi semua data dengan benar');
//               }
//             },
//             icon: const Icon(Hi.tick04, color: Colors.white),
//           ),
//         ],
//         title:
//             const Text('Form Pengajuan', style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF4CA1AF), Color(0xFF808080)],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           Padding(
//             padding:
//                 const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 80),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     controller: controller.noPengajuan,
//                     readOnly: true,
//                     decoration: const InputDecoration(
//                       labelText: 'No Pengajuan',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextFormField(
//                           controller: controller.tglPengajuan,
//                           readOnly: true,
//                           decoration: const InputDecoration(
//                             labelText: 'Tanggal Pengajuan',
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: TextFormField(
//                           controller: controller.departemen,
//                           readOnly: true,
//                           decoration: const InputDecoration(
//                             labelText: 'Departemen',
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   const Divider(thickness: 1, color: Colors.grey),
//                   const SizedBox(height: 16),
//                   Expanded(
//                     child: LzListView(padding: EdgeInsets.zero, children: [
//                       Obx(() => AnimatedList(
//                             key: controller.listKey,
//                             initialItemCount: controller.tambahanList.length,
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemBuilder: (context, index, animation) {
//                               final item = controller.tambahanList[index];

//                               void updateTotal() {
//                                 final jumlahText = item['field3']?.text ?? '0';
//                                 final hargaText = item['field4']?.text ?? '0';

//                                 int jumlah = int.tryParse(jumlahText) ?? 0;
//                                 int harga = int.tryParse(hargaText) ?? 0;
//                                 int total = jumlah * harga;
//                                 item['field5']?.text = total.toString();
//                               }

//                               item['field3']?.addListener(() {
//                                 updateTotal();
//                                 controller.hitungGrandTotal();
//                               });

//                               item['field4']?.addListener(() {
//                                 updateTotal();
//                                 controller.hitungGrandTotal();
//                               });

//                               return SizeTransition(
//                                 sizeFactor: animation,
//                                 child: Container(
//                                   margin:
//                                       const EdgeInsets.symmetric(vertical: 8),
//                                   padding: const EdgeInsets.all(12),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border:
//                                         Border.all(color: Colors.grey.shade300),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text('Data ${index + 1}',
//                                               style: const TextStyle(
//                                                   fontWeight: FontWeight.bold)),
//                                           IconButton(
//                                             onPressed: () =>
//                                                 controller.removeForm(index),
//                                             icon: const Icon(Hi.cancel02,
//                                                 color: Colors.red),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 8),
//                                       DropdownButtonFormField<String>(
//                                         decoration: const InputDecoration(
//                                           labelText: 'Pilih RAB',
//                                           border: OutlineInputBorder(),
//                                         ),
//                                         items:
//                                             ['Non', 'RAB'].map((String value) {
//                                           return DropdownMenuItem<String>(
//                                             value: value,
//                                             child: Text(value),
//                                           );
//                                         }).toList(),
//                                         onChanged: (String? newValue) {
//                                           if (newValue == 'RAB') {
//                                             controller
//                                                 .getTkdn(); // ← Panggil fungsi API
//                                           }
//                                         },
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return 'Nama barang wajib diisi';
//                                           }
//                                           return null;
//                                         },
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Obx(() {
//                                         if (controller.isLoading.value) {
//                                           return Center(
//                                               child:
//                                                   CircularProgressIndicator());
//                                         }

//                                         final data = controller.rxrab;

//                                         if (data.isEmpty) {
//                                           return const Text(
//                                               'Data RAB belum tersedia');
//                                         }

//                                         return DropdownButtonFormField<String>(
//                                           decoration: const InputDecoration(
//                                             labelText:
//                                                 'Pilih Nama Barang dari RAB',
//                                             border: OutlineInputBorder(),
//                                           ),
//                                           items: data.map((e) {
//                                             return DropdownMenuItem<String>(
//                                               value: e.namaItem,
//                                               child: Text(e.namaItem ??
//                                                   'Nama tidak ada'),
//                                             );
//                                           }).toList(),
//                                           onChanged: (value) {
//                                             item['field2']?.text = value ?? '';
//                                           },
//                                           validator: (value) {
//                                             if (value == null ||
//                                                 value.isEmpty) {
//                                               return 'Pilih nama barang';
//                                             }
//                                             return null;
//                                           },
//                                         );
//                                       }),
//                                       const SizedBox(height: 8),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: TextFormField(
//                                               controller: item['field3'],
//                                               keyboardType:
//                                                   TextInputType.number,
//                                               decoration: const InputDecoration(
//                                                 labelText: 'Jumlah',
//                                                 border: OutlineInputBorder(),
//                                               ),
//                                               validator: (value) {
//                                                 if (value == null ||
//                                                     value.isEmpty) {
//                                                   return 'Jumlah wajib diisi';
//                                                 }
//                                                 if (int.tryParse(value) ==
//                                                     null) {
//                                                   return 'Jumlah harus angka';
//                                                 }
//                                                 return null;
//                                               },
//                                             ),
//                                           ),
//                                           const SizedBox(width: 16),
//                                           Expanded(
//                                             child: TextFormField(
//                                               controller: item['field4'],
//                                               keyboardType:
//                                                   TextInputType.number,
//                                               decoration: const InputDecoration(
//                                                 labelText: 'Harga Satuan',
//                                                 border: OutlineInputBorder(),
//                                               ),
//                                               validator: (value) {
//                                                 if (value == null ||
//                                                     value.isEmpty) {
//                                                   return 'Harga wajib diisi';
//                                                 }
//                                                 if (int.tryParse(value) ==
//                                                     null) {
//                                                   return 'Harga harus angka';
//                                                 }
//                                                 return null;
//                                               },
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 8),
//                                       TextFormField(
//                                         controller: item['field5'],
//                                         readOnly: true,
//                                         decoration: const InputDecoration(
//                                           labelText: 'Total Harga',
//                                           border: OutlineInputBorder(),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           )),
//                     ]),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               color: Colors.white,
//               child: Obx(() => Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text('Grand Total:',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 16)),
//                       Text(
//                         NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ')
//                             .format(controller.grandTotal.value),
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16),
//                       ),
//                     ],
//                   )),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
