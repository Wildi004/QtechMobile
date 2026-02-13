import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class RegPusat extends StatelessWidget {
  const RegPusat({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: Scrolics.bounce,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Hi.validation,
          Hi.archive,
          Hi.mailDownload01,
          Hi.mailReply01,
          Hi.wallet01,
        ].generate((icon, i) {
          final labels = [
            'Validasi \nDirut',
            'Arsip Direktur\nUtama',
            'Surat\nKeluar',
            'Surat\nMasuk',
            'Saldo\nKaryawan'
          ];

          final colors = [
            '00ffffff'.hex,
            '00ffffff'.hex,
            '00ffffff'.hex,
            '00ffffff'.hex,
            '00ffffff'.hex,
          ];

          return Container(
            margin: Ei.only(
                l: i == 0 ? 0 : MediaQuery.of(context).size.width * 0.03),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
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
                  style: TextStyle(fontSize: 12),
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
