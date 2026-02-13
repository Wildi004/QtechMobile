import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/inv_del_po_ppn/inv_del_po_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Inv%20Del%20Po%20PPN%20Logiastik/inv_del_po_ppn_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/invoice%20delivery%20po%20logistik/invoice%20delivery%20material%20po%20ppn/cetak%20inv%20del%20po%20ppn/cetak_inv_del_po_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/invoice%20delivery%20po%20logistik/invoice%20delivery%20material%20po%20ppn/create_inv_del_po_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/invoice%20delivery%20po%20logistik/invoice%20delivery%20material%20po%20ppn/inv_del_po_ppn_belum_val_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/invoice%20delivery%20po%20logistik/invoice%20delivery%20material%20po%20ppn/inv_del_po_ppn_sudah_val_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class InvDelPoPpnView extends GetView<InvDelPoPpnController> {
  const InvDelPoPpnView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => InvDelPoPpnController());
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Invoice Delivery PO PPN',
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => CreateInvDelPoPpnView())?.then((data) {
                if (data != null) {
                  controller.insertData(InvDelPoPpn.fromJson(data));
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
                        'Laporan Invoice',
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
                  return InvDelPoPpnBelumValView();
                case 1:
                  return InvDelPoPpnSudahValView();
                case 2:
                  return CetakInvDelPoPpnView();
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
