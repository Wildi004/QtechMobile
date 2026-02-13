import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';
import 'package:qrm_dev/app/modules/absence/controllers/absence_controller.dart';

class TitleAbsensi extends GetView<AbsenceController> {
  const TitleAbsensi({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Obx(() {
          final data = controller.user.value;
          return LzImage(
            data?.image ?? '',
            size: 50,
          );
        }),
        SizedBox(width: MediaQuery.of(context).size.height * 0.02),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              final data = controller.user.value;
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  'Hi! ${data?.name}',
                  style: GoogleFonts.deliciousHandrawn().copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }),
            FutureBuilder(
              future: Auth.user(),
              builder: (context, snap) {
                final user = snap.data;
                return Text(
                  '${user?.role}',
                  style: GoogleFonts.notoSerif().copyWith(
                    fontSize: MediaQuery.of(context).size.height * 0.014,
                    color: Colors.black,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
