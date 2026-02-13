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
                  style: Gfont.fs14.copyWith(fontSize: 12),
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
