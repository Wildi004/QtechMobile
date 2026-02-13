import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/RND/PTJ%20RND/ptj_rnd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/ptj%20rnd/laporan_ptj_rnd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/ptj%20rnd/ptj_rnd_belum_validasi_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/ptj%20rnd/ptj_rnd_sudah_validasi_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/ptj%20rnd/show_regional_rnd.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class PtjRndView extends GetView<PtjRndController> {
  final String type;

  const PtjRndView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PtjRndController());

    return Scaffold(
      appBar: CustomAppbar(
        title: 'PTJ RND',
        actions: [
          IconButton(
            onPressed: () {
              ShowRegionalRnd.showRegIt(context);
            },
            icon: const Icon(Hi.add01),
          )
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
                        'Laporan PTJ RND',
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
                  return PtjRndBelumValidasiView();
                case 1:
                  return PtjRndSudahValidasiView();
                case 2:
                  return LaporanPtjRndView();

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
