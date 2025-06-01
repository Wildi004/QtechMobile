import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/capaian_kinerja/views/capaian_kinerja/capaian_kinerja_view.dart';
import 'package:qrm/app/modules/role_akses/views/role_akses_view.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Hi.access,
          Hi.file01,
          Hi.building05,
        ].generate((icon, i) {
          final labels = [
            'Role\nAcces',
            'User\nLog',
            'Company\nProfile',
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
                l: i == 0 ? 0 : MediaQuery.of(context).size.width * 0.13),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (i == 0) {
                      Get.to(() => RoleAksesView());
                    } else if (i == 1) {
                      Get.to(() => CapaianKinerjaView());
                    }
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
