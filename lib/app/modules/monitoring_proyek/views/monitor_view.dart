import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/data_proyek.dart';
import 'package:qrm/app/modules/monitoring_proyek/controllers/monitor_controller.dart';
import 'package:qrm/app/modules/monitoring_proyek/views/setting_monitoring/setting_monitoring_view.dart';

class MonitorView extends StatelessWidget {
  final MonitorController controller = Get.put(MonitorController());

  MonitorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Monitoring Proyek',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: ['4CA1AF'.hex, '808080'.hex],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
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
                final data = controller.rxmonitor;
                final itemWidth = MediaQuery.of(context).size.width - 30;

                if (isLoading) {
                  return Center(child: LzLoader.bar());
                }

                if (data.isEmpty) {
                  return Empty(
                    message: 'Tidak ada data.',
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
                          final index = controller.rxmonitor.indexOf(data);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => controller.toggleItem(index),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  width: itemWidth,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color.fromARGB(255, 54, 145, 220),
                                        const Color.fromARGB(255, 73, 173, 255),
                                        const Color.fromARGB(255, 14, 63, 210)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data.kodeProyek ?? 'tidak ada',
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
                              Obx(() {
                                if (controller.selectedIndex.value == index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.to(() =>
                                                      SettingMonitoringView(
                                                          data: data))
                                                  ?.then((value) {
                                                if (value != null) {
                                                  controller.updateData(
                                                      DataProyek.fromJson(
                                                          value),
                                                      data.id!);
                                                }
                                              });
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12),
                                              decoration: BoxDecoration(
                                                color: Colors
                                                    .blue, // Ganti warna sesuai kebutuhan
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                "Proyek",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              // Navigasi ke halaman pekerjaan
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 12),
                                              decoration: BoxDecoration(
                                                color: Colors
                                                    .green, // Ganti warna sesuai kebutuhan
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                "Pekerjaan",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }),
                              const SizedBox(height: 10),
                            ],
                          );
                        }).toList(),
                      ),
                      Obx(() =>
                          LzLoader.bar().lz.hide(!controller.isPaginate.value))
                    ]);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
