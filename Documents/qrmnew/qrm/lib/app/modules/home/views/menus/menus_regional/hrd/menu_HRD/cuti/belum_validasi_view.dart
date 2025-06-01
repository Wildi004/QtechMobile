import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_cuti_sudah_validasi_controller/hrd_cuti_belum_validasi_controller.dart';

class BelumValidasiView extends GetView<HrdCutiBelumValidasiController> {
  const BelumValidasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      Get.lazyPut(() => HrdCutiBelumValidasiController());
      bool isLoading = controller.isLoading.value;
      final data = controller.cuti;

      if (isLoading) {
        return Center(child: LzLoader.bar());
      }

      if (data.isEmpty) {
        return Empty(
          message: 'Tidak ada data apa pun.',
          onTap: () => controller.getData(),
        );
      }

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
              SizedBox(width: 10),
              // LzButton(
              //   icon: Hi.addSquare,
              //   onTap: () {

              //   },
              // ),
            ],
          ),
          SizedBox(height: 20),

          ...data.generate((item, i) {
            return Touch(
              margin: Ei.only(b: 10),
              child: Container(
                width: itemWidth,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 247, 199, 79),
                      const Color.fromARGB(255, 170, 122, 1),
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
                          Text(
                            item.userName ?? 'tidak ada',
                            style: GoogleFonts.notoSerif().copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            item.perihal ?? 'tidak ada',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Text(
                                item.cutiFrom ?? 'tidak ada',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                ' - ${item.cutiTo ?? 'tidak ada'}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [],
                    ),
                  ],
                ),
              ),
            );
          }),

          // animasi loading paginasi
          Obx(() => LzLoader.bar().lz.hide(!controller.isPaginate.value))
        ],
      );
    });
  }
}
