import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/role_akses/views/role_akses_view.dart';

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
            '00ffffff'.hex,
            '00ffffff'.hex,
            '00ffffff'.hex,
            '00ffffff'.hex,
            '00ffffff'.hex,
            '00ffffff'.hex,
            '00ffffff'.hex,
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
                    }
                  },
                  child: Container(
                    padding: Ei.all(10),
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: colors[i]),
                    child: Icon(
                      icon,
                      size: 35,
                    ),
                  ),
                ),
                Text(
                  labels[i],
                  style: GoogleFonts.robotoCondensed(fontSize: 12),
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
