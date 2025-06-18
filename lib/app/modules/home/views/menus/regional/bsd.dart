import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd_view.dart';

class Bsd extends StatelessWidget {
  const Bsd({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Hi.brain02,
          Hi.userSettings02,
          Hi.codeCircle,
          Hi.justiceScale01,
          Hi.backpack01,
          Hi.idea01,
          Hi.store01,
        ].generate((icon, i) {
          final labels = [
            'Direktur\nBSD',
            'HRD',
            'IT',
            'Legal',
            'Logistik',
            'RND',
            'Store'
          ];
          final colors = [
            'ffffff'.hex,
            'ffffff'.hex,
            'ffffff'.hex,
            'ffffff'.hex,
            'ffffff'.hex,
            'ffffff'.hex,
            'ffffff'.hex,
          ];

          return Container(
            margin: Ei.only(
                l: i == 0 ? 0 : MediaQuery.of(context).size.width * 0.03),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => HrdView());
                  },
                  child: Container(
                    padding: Ei.all(10),
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: colors[i]),
                    child: Icon(
                      icon,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ),
                ),
                Text(
                  labels[i],
                  style: Gfont.fs14.copyWith(
                      fontSize: MediaQuery.of(context).size.height * 0.018),
                  textAlign: Ta.center,
                )
              ],
            ).gap(5),
          );
        }),
      ).between,
    );
  }
}
// Center(
//               child: Column(
//                 //Colum a
//                 mainAxisAlignment: Maa.center,
//                 spacing: 25,
//                 children: [
//                   Row(
//                     mainAxisAlignment: Maa.center,
//                     children: [
//                       LzImage(
//                         'profile.png',
//                         size: 60,
//                         radius: 50,
//                       ),
//                       SizedBox(width: 20),
//                       Column(
//                         crossAxisAlignment: Caa.start,
//                         children: [
//                           Text(
//                             'Bareel Husein, S. Kom',
//                             style: TextStyle(
//                                 fontSize: 15, fontWeight: FontWeight.bold),
//                           ),
//                           Text('Manager IT - Pusat'),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Center(
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       padding: EdgeInsets.all(15),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black, width: 2),
//                         color: Colors.transparent,
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.transparent,
//                             blurRadius: 5,
//                             spreadRadius: 2,
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             const Text(
//                               '09:45:00 WITA',
//                               style: TextStyle(
//                                 color: Color.fromARGB(255, 0, 0, 0),
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const Text(
//                               'Rabu, 5 Februari 2025',
//                               style: TextStyle(
//                                 color: Color.fromARGB(255, 0, 0, 0),
//                                 fontSize: 12,
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: const [
//                                     Text(
//                                       '09:05:00 WITA',
//                                       style: TextStyle(
//                                           fontSize: 13,
//                                           color: Colors.black,
//                                           fontWeight: Fw.bold),
//                                     ),
//                                     Text(
//                                       ' Terlambat ',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           color: Colors.black,
//                                           backgroundColor:
//                                               Color.fromARGB(255, 255, 0, 0)),
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(right: 20),
//                                       child: const Text(
//                                         '00:00:00 WITA',
//                                         style: TextStyle(
//                                             fontSize: 13,
//                                             color: Colors.black,
//                                             fontWeight: Fw.bold),
//                                       ),
//                                     ),
//                                     Text('')
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                               mainAxisAlignment: Maa.spaceBetween,
//                               children: [
//                                 Container(
//                                   height: 30,
//                                   width: 120,
//                                   padding: EdgeInsets.symmetric(horizontal: 10),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       gradient: LinearGradient(
//                                           colors: ['302C7B'.hex, '5C5A7C'.hex],
//                                           begin: Alignment.centerLeft,
//                                           end: Alignment.centerRight)),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(Hi.login03,
//                                           color: Colors.white, size: 18),
//                                       SizedBox(width: 5),
//                                       GestureDetector(
//                                         onTap: () {
//                                           Get.snackbar('Absen Masuk',
//                                               'Berhasil absen masuk');
//                                         },
//                                         child: Text('Absen Masuk',
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 11)),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 30,
//                                   width: 120,
//                                   padding: EdgeInsets.symmetric(horizontal: 10),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       gradient: LinearGradient(colors: [
//                                         '302C7B'.hex,
//                                         '5C5A7C'.hex
//                                       ])),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(Hi.logout03,
//                                           color: Colors.white, size: 18),
//                                       SizedBox(width: 5),
//                                       GestureDetector(
//                                         onTap: () {
//                                           Get.find<AbsenceController>().showSnackbar();
//                                         },
//                                         child: Text(
//                                           'Absen Pulang',
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 11),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: screenWidth * 0.9,
//                     padding: EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: ['100C58'.hex, '5E5BA7'.hex],
//                         begin: Alignment.topLeft,
//                         end: Alignment.topRight,
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: Maa.spaceBetween,
//                           children: [
//                             Text(
//                               'Jumlah Telat Bulan :',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               '10x (Hari)',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             )
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: Maa.spaceBetween,
//                           children: [
//                             Text(
//                               'Februari',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               '45 Menit (Total)',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Column(
//                     // colum b
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             showDetails = !showDetails;
//                           });
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Februari',
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(width: 5),
//                             Icon(
//                               showDetails
//                                   ? Icons.keyboard_arrow_up
//                                   : Icons.keyboard_arrow_down,
//                               size: 24,
//                             ),
//                           ],
//                         ),
//                       ),
//                       if (showDetails)
//                         Container(
//                           margin: EdgeInsets.only(top: 5),
//                           width: screenWidth * 0.9,
//                           height: 150,
//                           decoration: BoxDecoration(
//                             color: Colors.transparent,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: ListView.builder(
//                             physics: BouncingScrollPhysics(),
//                             itemCount: absensiFebruari.length,
//                             itemBuilder: (context, index) {
//                               final absen = absensiFebruari[index];
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 3, horizontal: 10),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(absen['tanggal']!,
//                                         style: TextStyle(fontSize: 13)),
//                                     Text(absen['status']!,
//                                         style: TextStyle(fontSize: 13)),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                     ],
//                   ),
//                   GestureDetector(
//                     //masukan ke colum b
//                     onTap: () {
//                       Get.snackbar(
//                           'Info', 'Data bulan Januari tidak ditambahkan',);
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Januari',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(width: 5),
//                         Icon(
//                           showDetails
//                               ? Icons.keyboard_arrow_up
//                               : Icons.keyboard_arrow_down,
//                           size: 24,
//                         ),
//                       ],
//                     ),
//                   ),
// GestureDetector(
//   //masukan ke colum b
//   onTap: () {
//     setState(() {
//       Get.snackbar(
//           'Info', 'Data bulan Desember tidak ditambahkan');
//     });
//   },
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(
//         'Desember',
//         style: TextStyle(
//             fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//       SizedBox(width: 5),
//       Icon(
//         showDetails
//             ? Icons.keyboard_arrow_up
//             : Icons.keyboard_arrow_down,
//         size: 24,
//       ),
//     ],
//   ),
// ),//
//                 ],
//               ),//
