import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrm_dev/app/data/models/capaian_kerja1/capaian_kerja1.dart';
import 'package:qrm_dev/app/modules/capaian_kinerja/controllers/capaian%20kinerja1/capaian_kerja1_controller.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';

class OnprogresView extends StatelessWidget {
  final Capaian1 data;

  const OnprogresView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CapaianKerja1Controller());

    int tercapai = data.waiting ?? 0;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildItem('On Progres', tercapai.toString()),
          ],
        ),
      ),
    );
  }

  /// Widget reusable
  Widget _buildItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: CustomDecoration.validator(),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '$label: $value',
              style: CustomTextStyle.title(),
            ),
          ),
        ],
      ),
    );
  }
}
