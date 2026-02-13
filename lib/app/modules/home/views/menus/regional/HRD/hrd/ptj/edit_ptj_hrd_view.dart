// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lazyui/lazyui.dart';
// import 'package:qrm_dev/app/data/models/models%20hrd/ptj_hrd/ptj_hrd.dart';
// import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_ptj_controller/edit_ptj_hrd_controller.dart';
// import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
// import 'package:qrm_dev/app/widgets/custom_loading.dart';
// import 'package:qrm_dev/app/widgets/icon_action_widget.dart';
// import 'package:qrm_dev/app/widgets/image_picker.dart';

// class EditPtjHrdView extends GetView<EditPtjHrdController> {
//   final PtjHrd? data;

//   const EditPtjHrdView({super.key, this.data});

//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut(() => EditPtjHrdController()..data = data);

//     final forms = controller.forms;

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 243, 243, 243),
//       appBar: CustomAppbar(
//         title: 'Edit ptj',
//         actions: [
//           IconAction(Hi.add01, onTap: () {
//             controller.addPengajuan();
//             logg('test');
//           }),
//           IconAction(Hi.tick04, onTap: () {
//             controller.onSubmit();
//           }),
//         ],
//       ).appBar,
//       body: Obx(() {
//         bool loading = controller.isLoading.value;

//         if (loading) {
//           return CustomLoading();
//         }

//         return Column(
//           children: [
//             Container(
//               padding: Ei.all(20),
//               decoration: BoxDecoration(border: Br.only(['b'])),
//               child: Column(
//                 children: [
//                   LzForm.input(
//                     label: 'No. PTJ',
//                     enabled: false,
//                     model: forms.key('no_ptj'),
//                   ),
//                   Intrinsic(
//                     gap: 10,
//                     children: [
//                       LzForm.input(
//                         label: 'Tanggal PTJ',
//                         enabled: false,
//                         model: forms.key('tgl_ptj'),
//                       ),
//                       LzForm.input(
//                         label: 'Departemen',
//                         enabled: false,
//                         model: forms.key('dep_name'),
//                       ),
//                     ],
//                   ),
//                   LzForm.input(
//                     label: 'Saldo',
//                     enabled: false,
//                     model: forms.key('saldo'),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Obx(
//                 () => LzListView(
//                   gap: 10,
//                   children: [
//                     ...List.generate(controller.formDetails.length, (i) {
//                       final form = controller.formDetails[i];

//                       return LzCard(gap: 10, children: [
//                         Stack(
//                           children: [
//                             Padding(
//                               padding: Ei.only(t: 8, r: 8),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   LzForm.select(
//                                     label: 'Pilih Item',
//                                     hint: 'Pilih item',
//                                     options: controller.dataPengajuanDetails
//                                         .map((e) => e.namaBarang ?? '')
//                                         .toList(),
//                                     values: controller.dataPengajuanDetails
//                                         .map((e) => e.id ?? '')
//                                         .toList(),
//                                     model: form.key('nama_barang'),
//                                     onChange: (value) =>
//                                         controller.setUnit(value, i),
//                                   ),
//                                   Intrinsic(
//                                     gap: 10,
//                                     children: [
//                                       LzForm.input(
//                                         label: 'Tanggal Beli',
//                                         hint: 'Tanggal Beli',
//                                         model: form.key('tgl_beli'),
//                                         suffixIcon: Hi.calendar02,
//                                         onTap: () {
//                                           LzPicker.date(context,
//                                               minDate: DateTime(1900),
//                                               initDate: form
//                                                   .get('tgl_beli')
//                                                   .toDate(), onSelect: (date) {
//                                             form.set('tgl_beli', date.format());
//                                           });
//                                         },
//                                       ),
//                                       LzForm.input(
//                                         label: 'Pilih Nota',
//                                         hint: 'Pilih gambar',
//                                         model: form.key('image'),
//                                         suffixIcon: Hi.image01,
//                                         onTap: () {
//                                           Pickers.image(then: (file) {
//                                             if (file != null) {
//                                               form.set('image', file.path);
//                                               controller.fileImage = file;
//                                             }
//                                           });
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                   Intrinsic(
//                                     gap: 10,
//                                     children: [
//                                       LzForm.input(
//                                         label: 'Jumlah',
//                                         hint: 'Masukkan jumlah',
//                                         model: form.key('qty'),
//                                         keyboard: Tit.number,
//                                         maxLength: 11,
//                                         formatters: [Formatter.currency()],
//                                         onChange: (value) =>
//                                             controller.countTotal(i),
//                                       ),
//                                       LzForm.input(
//                                         label: 'Harga Satuan',
//                                         hint: 'Masukkan harga satuan',
//                                         model: form.key('harga_satuan'),
//                                         keyboard: Tit.number,
//                                         maxLength: 11,
//                                         formatters: [Formatter.currency()],
//                                         enabled: false,
//                                       ),
//                                     ],
//                                   ),
//                                   LzForm.input(
//                                     label: 'Total',
//                                     hint: '0',
//                                     model: form.key('total_harga'),
//                                     enabled: false,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Positioned(
//                               top: 0,
//                               right: 0,
//                               child: IconButton(
//                                 onPressed: () => controller.removePtj(i),
//                                 icon: Icon(Hi.cancel02, color: Colors.red),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ]);
//                     }),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
