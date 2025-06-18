import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_RAB_controller/rab_hrd_controller.dart';

class RabSudahValidasiView extends GetView<RabHrdController> {
  const RabSudahValidasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;
    Get.lazyPut(() => RabHrdController());

    return Obx(() {
      bool isLoading = controller.isLoading.value;
      final data = controller.rab;

      if (isLoading) {
        return Center(child: LzLoader.bar());
      }

      if (data.isEmpty) {
        return Empty(
          message: 'Tidak ada data apa pun.',
          onTap: () => controller.getData(),
        );
      }

      final grouped = controller.rabGroupedByBulan;

      return LzListView(
        padding: Ei.sym(v: 20, h: 20),
        onRefresh: () => controller.getData(),
        onScroll: (scroll) {
          if (scroll.atBottom(100)) {
            controller.onPaginate();
          }
        },
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: controller.updateSearchQuery,
                  decoration: InputDecoration(
                    hintText: "Cari...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ...grouped.entries.expand((entry) {
            final bulan = entry.key;
            final list = entry.value;

            return [
              Row(
                children: [
                  Text(
                    bulan,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ).marginOnly(bottom: 10),
                  10.width,
                  Container(
                    width: 190,
                    height: 2,
                    color: Colors.black,
                    margin: EdgeInsets.only(right: 8),
                  ),
                ],
              ),
              ...list.generate((item, i) {
                return Touch(
                  child: Container(
                    width: itemWidth,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 54, 145, 220),
                          const Color.fromARGB(255, 73, 173, 255),
                          const Color.fromARGB(255, 14, 63, 210),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.kodeRab ?? 'tidak ada',
                                      style: GoogleFonts.notoSerif().copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      item.grandtotal ?? 'tidak ada',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(height: 20),
            ];
          }),
          Obx(() => LzLoader.bar().lz.hide(!controller.isPaginate.value)),
        ],
      );
    });
  }
}
