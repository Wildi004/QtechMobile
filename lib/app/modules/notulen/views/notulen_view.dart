import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/notulen/notulen.dart';
import 'package:qrm_dev/app/modules/notulen/views/form_notulen_view.dart';
import 'package:qrm_dev/app/modules/notulen/views/notulen_all_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

import '../controllers/notulen_controller.dart';

class NotulenView extends GetView<NotulenController> {
  const NotulenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Notulen',
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => FormNotulenView())?.then((data) {
                  if (data != null) {
                    controller.insertData(Notulen.fromJson(data));
                  }
                });
              },
              icon: Icon(Hi.add01))
        ],
      ).appBar,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Obx(() {
              int active = controller.tabIndex.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: LzTabView(
                      tabs: const [
                        'Semua',
                        'Umum',
                        'Penting',
                        'Rahasia',
                      ],
                      onTap: (key, i) {
                        controller.tabIndex.value = i;
                        controller.filterNotulenByTab();
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
                ],
              );
            }),
            const SizedBox(height: 10),
            Expanded(
              child: NotulenAllView(),
            ),
          ],
        ),
      ),
    );
  }
}
