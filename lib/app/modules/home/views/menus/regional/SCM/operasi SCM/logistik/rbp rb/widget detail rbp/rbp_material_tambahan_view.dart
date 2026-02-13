import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model logistik/rbp_rb_nohide/rbp_rb_nohide.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Rbp Rb Logistik/rbp_rb_logistik_controller.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class RbpMaterialTambahanView extends GetView<RbpRbLogistikController> {
  final String? noHide;
  final RbpRbNohide? data;

  const RbpMaterialTambahanView({super.key, this.noHide, this.data});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isDetailLoading.value) {
        return CustomLoading();
      }

      if (controller.detailDatas.isEmpty) {
        return const Center(child: Text("Data tidak ditemukan"));
      }

      final items = controller.detailDatas.first.materialTambahan ?? [];

      return LzListView(
        padding: EdgeInsets.zero,
        children: [
          ...items.asMap().entries.map((entry) {
            final i = entry.key;
            final item = entry.value;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: LzCard(
                children: [
                  Text(
                    'Item ${i + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  _buildBoldText('Uraian', item.uraianMt),
                  _buildBoldText('Jumlah', item.jumlahMt),
                  _buildBoldText('Satuan', item.satuan),
                  _buildBoldText('Harga Satuan', item.hargaSatuanMt),
                  _buildBoldText('Total Harga', item.totalHargaMt),
                ],
              ),
            );
          }),
        ],
      );
    });
  }
}

Widget _buildBoldText(String title, dynamic value) {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: '$title : ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: value?.toString() ?? '-',
        ),
      ],
    ),
  );
}
