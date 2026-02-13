import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/capaian_kerja1/capaian_kerja1.dart';
import 'package:qrm_dev/app/modules/capaian_kinerja/controllers/capaian%20kinerja1/capaian_kerja1_controller.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';

class TotalLaporanKerjaView extends StatelessWidget {
  final Capaian1 data;

  const TotalLaporanKerjaView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CapaianKerja1Controller());

    int total = data.total ?? 0;
    int tercapai = data.selesai ?? 0;
    int onProgres = total - tercapai;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildItem(
              context,
              label: 'Total',
              value: total.toString(),
              onTap: () => _showTeamList(context, 'Total'),
            ),
            _buildItem(
              context,
              label: 'Tercapai',
              value: tercapai.toString(),
              onTap: () => _showTeamList(context, 'Tercapai'),
            ),
            _buildItem(
              context,
              label: 'On Progres',
              value: onProgres.toString(),
              onTap: () => _showTeamList(context, 'On Progres'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }

  void _showTeamList(BuildContext context, String type) {
    final team = data.team ?? [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // penting kalau banyak data
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            // <- Ini penting!
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$type per Anggota',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...team.map((member) {
                  int value = 0;
                  if (type == 'Total') {
                    value = member.total ?? 0;
                  } else if (type == 'Tercapai') {
                    value = member.selesai ?? 0;
                  } else if (type == 'On Progres') {
                    value = (member.total ?? 0) - (member.selesai ?? 0);
                  }
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: CustomDecoration.validator(),
                    child: Row(
                      children: [
                        LzImage(
                          member.image,
                          size: 40,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '${member.name} - $type: $value',
                            style: CustomTextStyle.title(),
                          ),
                        ),
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
        );
      },
    );
  }
}
