import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/pengajuan_it/pengajuan_it.dart';
import 'package:qrm_dev/app/modules/home/controllers/RND/Pengajuan%20RND/pengajuan_rnd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/pengajuan%20rnd/cetak%20pengajuan%20rnd/laporan_pengajuan_rnd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/pengajuan%20rnd/create_pengajuan_rnd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/pengajuan%20rnd/pengajuan_rnd_belum_validasi_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/pengajuan%20rnd/pengajuan_rnd_sudah_validasi_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';

class PengajuanRndView extends GetView<PengajuanRndController> {
  const PengajuanRndView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PengajuanRndController());

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Pengajuan RND',
        actions: [
          CustomScalaContainer(
            child: IconButton(
              onPressed: () async {
                Get.to(() => CreatePengajuanRndView())?.then((data) {
                  if (data != null) {
                    controller.insertData(PengajuanIt.fromJson(data));
                  }
                });
              },
              icon: Icon(Hi.add01),
              color: Colors.white,
            ),
          ),
        ],
      ).appBar,
      body: Column(
        children: [
          Obx(() {
            int active = controller.tab.value;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: LzTabView(
                      tabs: const [
                        'Belum Validasi',
                        'Sudah Validasi',
                        'Laporan Pengajuan RND',
                      ],
                      onTap: (key, i) {
                        controller.tab.value = i;
                      },
                      builder: (label, i) {
                        bool isActive = active == i;
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color.fromARGB(255, 173, 155, 38)
                                : const Color.fromARGB(255, 243, 238, 238),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black),
                          ),
                          margin: EdgeInsets.only(left: i == 0 ? 0 : 8),
                          child: Text(
                            label,
                            style: TextStyle(
                              color: isActive ? Colors.white : Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
          Expanded(
            child: Obx(() {
              switch (controller.tab.value) {
                case 0:
                  return PengajuanRndBelumValidasiView();
                case 1:
                  return PengajuanRndSudahValidasiView();
                case 2:
                  return LaporanPengajuanRndView();

                default:
                  return SizedBox();
              }
            }),
          ),
        ],
      ),
    );
  }
}
