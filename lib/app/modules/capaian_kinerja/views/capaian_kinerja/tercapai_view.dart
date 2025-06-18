import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/capaian_kinerja/controllers/capaian_kinerja_controller.dart';

class TercapaiView extends StatelessWidget {
  final CapaianKinerjaController controller = Get.find();
  TercapaiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            controller.togglePanel();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.blue[800],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tercapai",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                Text("4000",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ),
        ),
        Obx(() {
          final user = controller.cap.value;
          return LzCard(
            style: LzCardStyle(stacked: true),
            children: [
              Row(
                children: [
                  Text(user?.progres.toString() ?? '-'),
                ],
              ).between,
            ],
          );
        })
      ],
    );
  }
  // Widget _buildListItem(String title, String date, BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(
  //         horizontal: MediaQuery.of(context).size.width * 0.03,
  //         vertical: MediaQuery.of(context).size.width * 0.02),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Expanded(
  //             child: Text(
  //           title,
  //           style: TextStyle(
  //               fontSize: MediaQuery.of(context).size.width * 0.03,
  //               fontWeight: FontWeight.bold),
  //         )),
  //         Text(date,
  //             style: TextStyle(
  //                 fontSize: MediaQuery.of(context).size.width * 0.03,
  //                 fontWeight: FontWeight.w500)),
  //       ],
  //     ),
  //   );
  // }
}
