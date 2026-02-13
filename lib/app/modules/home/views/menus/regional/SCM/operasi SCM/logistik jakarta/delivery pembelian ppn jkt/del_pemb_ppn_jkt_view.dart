import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_pemb_ppn/del_pemb_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/Logistik%20Jakarta/Delivery%20Pembelian%20PPN%20Jkt/del_pemb_ppn_jkt_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/delivery%20pembelian%20ppn%20jkt/create_del_pemb_ppn_jkt_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/delivery%20pembelian%20ppn%20jkt/del_pemb_ppn_jkt_belum_val_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/delivery%20pembelian%20ppn%20jkt/del_pemb_ppn_jkt_sudah_val_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/delivery%20pembelian%20ppn%20logistik/cetak%20delivery/cetak_del_pemb_ppn_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class DelPembPpnJktView extends GetView<DelPembPpnJktController> {
  const DelPembPpnJktView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DelPembPpnJktController());
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Delivery pembelian PPN',
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => CreateDelPembPpnJktView())?.then((data) {
                if (data != null) {
                  controller.insertData(DelPembPpn.fromJson(data));
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
                  return DelPembPpnJktBelumValView();
                case 1:
                  return DelPembPpnJktSudahValView();
                case 2:
                  return CetakDelPembPpnView();
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
