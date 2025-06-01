import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/monitoring_proyek/controllers/monitoring_proyek_controller.dart';
import 'package:qrm/app/modules/reg_pusat/views/reg_pusat_view.dart';

class MonitoringProyekView extends StatelessWidget {
  final MonitoringProyekController controller =
      Get.put(MonitoringProyekController());

  final RxInt selectedIndex = (-1).obs;

  MonitoringProyekView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Monitoring proyek",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 91, 122),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: Obx(() {
                bool isLoading = controller.isLoading.value;
                final proyek = controller.dataProyek;

                if (isLoading) {
                  return Center(child: LzLoader.bar());
                }

                if (proyek.isEmpty) {
                  return Center(child: Text('Data tidak tersedia'));
                }

                return ListView.builder(
                  itemCount: proyek.length,
                  itemBuilder: (context, index) {
                    final data = proyek[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            selectedIndex.value =
                                (selectedIndex.value == index) ? -1 : index;
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
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
                                SizedBox(
                                  width: 200,
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
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Obx(() {
                          return selectedIndex.value == index
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(() => RegPusatView());
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            margin: const EdgeInsets.only(
                                                right: 5, left: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Info Proyek",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.snackbar("Detail",
                                                "Menampilkan detail proyek");
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            margin: const EdgeInsets.only(
                                                right: 10, left: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Info Pekerjaan",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox();
                        }),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
