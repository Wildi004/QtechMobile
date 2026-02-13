import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/PTJ%20IT/ptj_it_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/ptj%20it/cetak_ptj_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/ptj%20it/ptj_it_belum_validasi_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/ptj%20it/ptj_it_sudah_validasi_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/ptj%20it/show_regional_it.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class PtjItView extends GetView<PtjItController> {
  final String type;

  const PtjItView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PtjItController());
    return Scaffold(
      appBar: CustomAppbar(
        title: 'PTJ IT',
        actions: [
          IconButton(
            onPressed: () {
              ShowRegionalIt.showRegIt(context);
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
                        'Laporan PTJ IT',
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
                  return PtjItBelumValidasiView();
                case 1:
                  return PtjItSudahValidasiView();
                case 2:
                  return CetakPtjItView();

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
