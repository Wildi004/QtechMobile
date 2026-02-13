import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/settings/views/settings_view.dart';

class GeneralOptionSection extends StatelessWidget {
  const GeneralOptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Umum', style: Gfont.fs20.bold),
        AccountOption(
          options: [
            'Pengaturan',
            'Keamanan',
            'Notifikasi',
          ].generate(
            (l, i) => Menu(
              l,
              [
                Hi.settings01,
                Hi.informationDiamond,
                Hi.informationCircle,
              ][i],
            ),
          ),
        ),
      ],
    ).gap(25);
  }
}
