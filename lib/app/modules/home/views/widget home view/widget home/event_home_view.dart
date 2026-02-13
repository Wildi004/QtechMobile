import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/widget%20controller/event_home_view_vontroller.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';

class EventHomeView extends GetView<EventHomeViewVontroller> {
  const EventHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<EventHomeViewVontroller>()) {
      Get.put(EventHomeViewVontroller());
    }

    return Obx(
      () {
        final items = controller.data;
        if (items.isEmpty) {
          return const Center(child: Text('Belum ada data'));
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: items.map((item) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: CustomDecoration.main2(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item['title'] ?? '',
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['date'] ?? '',
                        style:
                            const TextStyle(fontSize: 13, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Hi.location01,
                            color: Colors.white,
                          ),
                          Text(
                            item['location'] ?? '',
                            style: const TextStyle(
                                fontSize: 13, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
