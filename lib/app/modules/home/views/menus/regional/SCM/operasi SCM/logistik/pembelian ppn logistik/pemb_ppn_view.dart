import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pembelian_ppn/pembelian_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Pembelian%20PPN/pembelian_ppn_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/pembelian%20ppn%20logistik/cetak%20pembelian/cetak_pembelian_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/pembelian%20ppn%20logistik/create_pemb_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/pembelian%20ppn%20logistik/pemb_ppn_belum_validasi_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/pembelian%20ppn%20logistik/pemb_ppn_sudah_validasi_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class PembPpnView extends GetView<PembelianPpnController> {
  const PembPpnView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PembelianPpnController());
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Pembelian PPN',
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => CreatePembPpnView())?.then((data) {
                if (data != null) {
                  controller.insertData(PembelianPpn.fromJson(data));
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
                        'Laporan Pembelian',
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
                  return PembPpnBelumValidasiView();
                case 1:
                  return PembPpnSudahValidasiView();
                case 2:
                  return CetakPembelianPpnView();
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
