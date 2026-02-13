import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/home_controller.dart';
import 'package:qrm_dev/app/widgets/custom_main_color.dart';

import '../../../../../data/services/storage/auth.dart';

class CardName extends GetView<HomeController> {
  const CardName({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: CustomMainColor.main(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 115, 115, 119),
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                final data = controller.user.value;
                return Text(
                  'Hi! ${data?.name}',
                  style: GoogleFonts.robotoSlab().copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                );
              }),
              // Role User
              FutureBuilder(
                future: Auth.user(),
                builder: (context, snap) {
                  final user = snap.data;
                  return Text(
                    '${user?.role}',
                    style: GoogleFonts.notoSerif().copyWith(
                      color: Colors.white,
                      fontSize: 15, // ukuran fix
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
              const SizedBox(height: 10),
              const Text(
                'Sisa Saldo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 6),
              Obx(() {
                final data = controller.sisaKasbon.value;
                return Align(
                  child: Text(
                    data == null ? '0' : '${data.sisaSaldo}',
                    style: GoogleFonts.libreBaskerville().copyWith(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: Fw.bold,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class AppColors {
  static const Color primary = Color(0xFF000000);
  static LinearGradient mainGradient = const LinearGradient(
    colors: [
      Color(0xFF1E1E1E),
      Color(0xFF2E2E2E),
      Color(0xFF3E3E3E),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// child: LzCard(
//   color: AppColors.mainGradient,
//   children: [
//     Padding(
//       padding: const EdgeInsets.only(left: 10, top: 5),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           FutureBuilder(
//             future: Auth.user(),
//             builder: (context, snap) {
//               final user = snap.data;
//               return Text(
//                 'Hi! ${user?.name}',
//                 style: GoogleFonts.deliciousHandrawn().copyWith(
//                   color: Colors.white,
//                   fontSize: screenWidth * 0.08,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               );
//             },
//           ),
//           FutureBuilder(
//             future: Auth.user(),
//             builder: (context, snap) {
//               final user = snap.data;
//               return Text(
//                 '${user?.role}',
//                 style: GoogleFonts.notoSerif().copyWith(
//                   color: Colors.white,
//                   fontSize: screenWidth * 0.05,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               );
//             },
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             'Sisa Saldo',
//             style: TextStyle(color: Colors.white),
//           ),
//           SizedBox(height: screenHeight * 0.01),
//           Align(
//             child: Text(
//               'Rp 100,000,000-,',
//               style: GoogleFonts.libreBaskerville().copyWith(
//                 color: Colors.white,
//                 fontSize: screenHeight * 0.035,
//                 fontWeight: Fw.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   ],
// ),
// class CardName extends GetView<HomeController> { const CardName({super.key}); @override Widget build(BuildContext context) { double screenWidth = MediaQuery.of(context).size.width; double screenHeight = MediaQuery.of(context).size.height; return Center( child: Container( width: double.infinity, padding: const EdgeInsets.all(10), decoration: CustomMainColor.main( borderRadius: BorderRadius.circular(15), boxShadow: [ BoxShadow( color: const Color.fromARGB(255, 115, 115, 119), blurRadius: 10, spreadRadius: 1, offset: const Offset(0, 8), ), ], ), child: Padding( padding: const EdgeInsets.only(left: 10, top: 5), child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [ Obx(() { final data = controller.user.value; return Text( 'Hi! ${data?.name}', style: GoogleFonts.deliciousHandrawn().copyWith( color: Colors.white, fontSize: screenWidth * 0.08, fontWeight: FontWeight.bold, ), maxLines: 1, overflow: TextOverflow.ellipsis, ); }), FutureBuilder( future: Auth.user(), builder: (context, snap) { final user = snap.data; return Text( '${user?.role}', style: GoogleFonts.notoSerif().copyWith( color: Colors.white, fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold, ), maxLines: 1, overflow: TextOverflow.ellipsis, ); }, ), const SizedBox(height: 10), const Text( 'Sisa Saldo', style: TextStyle(color: Colors.white), ), SizedBox(height: screenHeight * 0.01), Align( child: Text( 'Rp 100,000,000-,', style: GoogleFonts.libreBaskerville().copyWith( color: Colors.white, fontSize: screenHeight * 0.035, fontWeight: Fw.bold, ), ), ), ], ), ), ), ); } } class AppColors { static const Color primary = Color(0xFF000000); static LinearGradient mainGradient = const LinearGradient( colors: [ Color(0xFF1E1E1E), Color(0xFF2E2E2E), Color(0xFF3E3E3E), ], begin: Alignment.topLeft, end: Alignment.bottomRight, ); }
