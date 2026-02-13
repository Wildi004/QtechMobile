import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/settings/controllers/change_regional_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class ChangeRegional extends GetView<ChangeRegionalController> {
  const ChangeRegional({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ChangeRegionalController());

    return Scaffold(
      appBar: CustomAppbar(title: 'Change Regional').appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Pilih regional untuk berpindah hak akses Anda:',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Tombol bulat per regional (masing-masing dibungkus Obx)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(() => _buildRegionButton(
                        label: 'Timur',
                        icon: Hi.airplane01,
                        controller: controller,
                      )),
                  Obx(() => _buildRegionButton(
                        label: 'Barat',
                        icon: Hi.airplane01,
                        controller: controller,
                      )),
                  Obx(() => _buildRegionButton(
                        label: 'Tengah',
                        icon: Hi.airplane01,
                        controller: controller,
                      )),
                  Obx(() => _buildRegionButton(
                        label: 'Direksi',
                        icon: Hi.airplane01,
                        controller: controller,
                      )),
                ],
              ),

              const SizedBox(height: 40),

              // Pesan hasil response dari API
              Obx(() {
                if (controller.isLoading.value) {
                  return const CircularProgressIndicator();
                }

                if (controller.message.isNotEmpty) {
                  return Text(
                    controller.message.value,
                    style: TextStyle(
                      color: controller.message.value.contains('Berhasil')
                          ? Colors.green
                          : const Color.fromARGB(255, 77, 100, 151),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  );
                }

                return const Text(
                  'Belum ada regional dipilih',
                  style: TextStyle(fontSize: 16),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegionButton({
    required String label,
    required IconData icon,
    required ChangeRegionalController controller,
  }) {
    final bool isSelected = controller.selected.value == label;

    return Builder(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final iconSize = screenWidth * 0.08;
        final buttonSize = screenWidth * 0.18;

        return GestureDetector(
          onTap: controller.isLoading.value
              ? null
              : () => controller.selectRegion(label),
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: buttonSize,
                height: buttonSize,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color.fromARGB(255, 71, 195, 65)
                      : Colors.grey.shade200,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? const Color.fromARGB(255, 71, 195, 65)
                        : Colors.grey,
                    width: 2,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.green.withValues(alpha: 0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Icon(
                  icon,
                  color: isSelected ? Colors.white : Colors.black54,
                  size: iconSize,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? const Color.fromARGB(255, 71, 195, 65)
                      : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
