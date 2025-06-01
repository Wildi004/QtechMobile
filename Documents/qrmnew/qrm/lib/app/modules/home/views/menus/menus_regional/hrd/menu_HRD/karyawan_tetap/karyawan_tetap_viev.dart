import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/karyawan_tetap.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/karyawan_tetap_controller.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/karyawan_tetap/setting_karyawan_tetap_view.dart';

class KaryawanTetapViev extends StatelessWidget {
  final KaryawanTetapController controller = Get.put(KaryawanTetapController());

  KaryawanTetapViev({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Hi.add01,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Hi.pdf01,
              color: Colors.white,
            ),
          )
        ],
        centerTitle: true,
        title: Text(
          'Karyawan Tetap',
          style: TextStyle(color: Colors.white, fontWeight: Fw.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: ['4CA1AF'.hex, '808080'.hex],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: Obx(() {
                bool isLoading = controller.isLoading.value;
                final data = controller.karyawanTetap.toList();
                final itemWidth = MediaQuery.of(context).size.width - 30;

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
                  padding: Ei.sym(v: 20),
                  onRefresh: () => controller.getData(),
                  onScroll: (scroll) {
                    if (scroll.atBottom(100)) {
                      controller.onPaginate();
                    }
                  },
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: data.map((data) {
                        String? imageUrl = data.image != null
                            ? "https://laravel.apihbr.link/storage/${data.image}"
                            : null;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                // Container dengan nama
                                Padding(
                                  padding: const EdgeInsets.only(left: 60),
                                  child: Material(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(15),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(15),
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (_) =>
                                              SettingKaryawanTetapView(
                                                  data: data),
                                        ).then((value) {
                                          if (value != null) {
                                            controller.updateData(
                                                KaryawanTetap.fromJson(value),
                                                data.id!);
                                          }
                                        });
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                        width: itemWidth,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              const Color.fromARGB(
                                                  255, 54, 145, 220),
                                              const Color.fromARGB(
                                                  255, 73, 173, 255),
                                              const Color.fromARGB(
                                                  255, 14, 63, 210),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                data.name ?? 'tidak ada',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  left: 0,
                                  top: 5,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (imageUrl != null) {
                                        Get.dialog(
                                          Dialog(
                                            backgroundColor: Colors.transparent,
                                            child: InteractiveViewer(
                                              panEnabled: true,
                                              minScale: 0.5,
                                              maxScale: 3.0,
                                              child: Container(
                                                width: 300,
                                                height: 300,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image:
                                                        NetworkImage(imageUrl),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageUrl != null
                                              ? NetworkImage(imageUrl)
                                              : const AssetImage(
                                                      "assets/images/default.png")
                                                  as ImageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      }).toList(),
                    ),
                    Obx(() =>
                        LzLoader.bar().lz.hide(!controller.isPaginate.value))
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
