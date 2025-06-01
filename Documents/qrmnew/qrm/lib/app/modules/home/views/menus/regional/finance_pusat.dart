import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class FinancePusat extends StatelessWidget {
  const FinancePusat({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Hi.calculator01,
          Hi.invoice03,
          Hi.affiliate,
          Hi.calculate,
          Hi.taxes,
        ].generate((icon, i) {
          final labels = [
            'Accounting',
            'Billing',
            'Direktur\nKeuangan',
            'Finance',
            'Tax',
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
