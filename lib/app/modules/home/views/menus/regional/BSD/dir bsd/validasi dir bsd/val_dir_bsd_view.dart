import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/val_dir_bsd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class ValDirBsdView extends GetView<ValDirBsdController> {
  const ValDirBsdView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ValDirBsdController());

    return Scaffold(
      appBar: CustomAppbar(title: 'Validasi Dir. BSD').appBar,
      backgroundColor: Colors.grey[100],
      body: Obx(
        () => LzListView(
          onRefresh: () => controller.getData(),
          gap: 10,
          padding: Ei.all(15),
          children: [
            for (int i = 0; i < controller.dataValidasi.length; i++)
              InkWell(
                onTap: () => controller.onItemTap(i),
                child: Container(
                  padding: Ei.sym(v: 14, h: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: Br.radius(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: Maa.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          controller.dataValidasi[i]['title'],
                          softWrap: true,
                        ),
                      ),
                      controller.dataValidasi[i]['count'] > 0
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: Br.radius(12),
                              ),
                              child: Text(
                                '${controller.dataValidasi[i]['count']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Icon(Hi.notification01, color: Colors.grey),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
