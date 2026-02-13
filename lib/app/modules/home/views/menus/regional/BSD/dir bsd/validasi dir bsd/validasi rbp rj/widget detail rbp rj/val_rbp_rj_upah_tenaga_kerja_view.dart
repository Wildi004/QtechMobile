import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/validasi%20rbp%20rj/validasi_rbp_rj_sudah_controller.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class ValRbpRjUpahTenagaKerjaView
    extends GetView<ValidasiRbpRjSudahController> {
  final String? noHide;

  const ValRbpRjUpahTenagaKerjaView({super.key, this.noHide});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isDetailLoading.value) {
        return CustomLoading();
      }

      if (controller.detailDatas.isEmpty) {
        return const Center(child: Text("Data tidak ditemukan"));
      }

      final items = controller.detailDatas.first.upahTenaga ?? [];

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
                  _buildBoldText('Uraian', item.uraianUpah),
                  _buildBoldText('Jumlah', item.jumlahUpah),
                  _buildBoldText('Durasi(Hari)', item.durasiUpah),
                  _buildBoldText('Harga Satuan', item.upahNormal),
                  _buildBoldText('Total Harga', item.totalHargaUpah),
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
