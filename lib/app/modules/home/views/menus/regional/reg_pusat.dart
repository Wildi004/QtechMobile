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
                  onTap: () {},
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
                  style: TextStyle(
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
