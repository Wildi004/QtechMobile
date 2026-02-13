import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/kasbon/controllers/kasbon_controller.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class KasbonList extends GetView<KasbonController> {
  final NumberFormat currencyFormat;

  const KasbonList({
    super.key,
    required this.currencyFormat,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Daftar Kasbon :',
            style: GoogleFonts.poppins(fontSize: 18).copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: LzListView(
            padding: EdgeInsets.zero,
            onRefresh: () => controller.getData(),
            onScroll: (scroll) {
              if (scroll.atBottom(100)) {
                controller.onPaginate();
              }
            },
            children: controller.groupedKasbon.entries
                .toList()
                .asMap()
                .entries
                .map((dateEntry) {
              final index = dateEntry.key + 1;
              final date = dateEntry.value.key;
              final kasbonList = dateEntry.value.value;

              return ExpansionTile(
                title: Text(
                  '$index. $date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: kasbonList.asMap().entries.map((kasbonEntry) {
                  final kasbon = kasbonEntry.value;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => controller.onTapKeterangan(kasbon),
                            child: Text(
                              kasbon.keterangan ?? "-",
                              style: GoogleFonts.poppins().copyWith(),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          currencyFormat.format(kasbon.jml ?? 0),
                          style: GoogleFonts.poppins(),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          ),
        ),
        Obx(() => CustomLoading().lz.hide(!controller.isPaginate.value)),
      ],
    );
  }
}
