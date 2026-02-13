import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model logistik/rbp_rb_nohide/rbp_rb_nohide.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/validasi%20rbp%20rb/validasi_rbp_rb_sudah_controller.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class ValRbpAlatTambahanView extends GetView<ValidasiRbpRbSudahController> {
  final String? noHide;
  final RbpRbNohide? data;

  const ValRbpAlatTambahanView({super.key, this.noHide, this.data});

  @override
  Widget build(BuildContext context) {
    if (noHide != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await controller.getDetailByNoHide(noHide!);
      });
    }

    return Obx(() {
      if (controller.isDetailLoading.value) {
        return CustomLoading();
      }

      if (controller.detailDatas.isEmpty) {
        return const Center(child: Text("Data tidak ditemukan"));
      }

      final items = controller.detailDatas.first.alatTambahan ?? [];

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
                  _buildBoldText('Uraian', item.uraianAt),
                  _buildBoldText('Jumlah', item.jumlahAt),
                  _buildBoldText('Durasi(Hari)', item.satuanIdAt),
                  _buildBoldText('Harga Satuan', item.hargaSatuanAt),
                  _buildBoldText('Total Harga', item.totalHargaAt),
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
