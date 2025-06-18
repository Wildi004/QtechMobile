import 'package:flutter/material.dart';

class TotalLaporanKerjaWidget extends StatelessWidget {
  final int total;
  final int onProgress;
  final int tercapai;

  const TotalLaporanKerjaWidget({
    super.key,
    required this.total,
    required this.onProgress,
    required this.tercapai,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildInfoCard(
          title: 'Total Laporan Kerja',
          value: total,
          gradientColors: const [
            Color.fromARGB(255, 98, 85, 237),
            Color.fromARGB(255, 42, 33, 136)
          ],
        ),
        const SizedBox(height: 12),
        _buildInfoCard(
          title: 'Tercapai',
          value: tercapai,
          gradientColors: const [
            Color.fromARGB(255, 58, 156, 93),
            Color.fromARGB(255, 23, 85, 33)
          ],
        ),
        const SizedBox(height: 12),
        _buildInfoCard(
          title: 'On Progress',
          value: onProgress,
          gradientColors: const [
            Color.fromARGB(255, 186, 193, 70),
            Color.fromARGB(255, 62, 75, 30)
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    required int value,
    required List<Color> gradientColors,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(colors: gradientColors),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: gradientColors.first.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            value.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
