import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_pemb_non_ppn/del_pemb_non_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Delivery%20Pembelian%20Non%20PPN%20Logistik/del_pemb_non_ppn_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/delivery%20pembelian%20non%20ppn/cetak%20delivery%20pembelian%20non/cetak_del_pemb_non_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/delivery%20pembelian%20non%20ppn/create_del_pemb_non_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/delivery%20pembelian%20non%20ppn/del_pemb_non_ppn_belum_val_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/delivery%20pembelian%20non%20ppn/del_pemb_non_ppn_sudah_val_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class DelPembNonPpnView extends GetView<DelPembNonPpnController> {
  const DelPembNonPpnView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DelPembNonPpnController());
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Delivery Pembelian Non PPN',
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => CreateDelPembNonPpnView())?.then((data) {
                if (data != null) {
                  controller.insertData(DelPembNonPpn.fromJson(data));
                }
              });
            },
            icon: Icon(Hi.add01),
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
                        'Laporan Delivery',
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
                  return DelPembNonPpnBelumValView();
                case 1:
                  return DelPembNonPpnSudahValView();
                case 2:
                  return CetakDelPembNonPpnView();
                default:
                  return SizedBox.shrink();
              }
            }),
          ),
        ],
      ),
    );
  }
}
