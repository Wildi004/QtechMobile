import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/arsiv/arsip_karyawan/arsip_barat_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/arsiv/arsip_karyawan/arsip_pusat.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/arsiv/arsip_karyawan/arsip_timur_view.dart';

class ArsipKaryawanView extends StatelessWidget {
  const ArsipKaryawanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                _buildGradientContainer("Kantor Pusat", [
                  const Color.fromARGB(255, 54, 145, 220),
                  const Color.fromARGB(255, 73, 173, 255),
                  const Color.fromARGB(255, 14, 63, 210)
                ], () {
                  Get.to(() => ArsipPusat());
                }),
                _buildGradientContainer("Regional Timur", [
                  const Color.fromARGB(255, 54, 145, 220),
                  const Color.fromARGB(255, 73, 173, 255),
                  const Color.fromARGB(255, 14, 63, 210)
                ], () {
                  Get.to(() => ArsipTimurView());
                }),
                _buildGradientContainer("Regional Barat", [
                  const Color.fromARGB(255, 54, 145, 220),
                  const Color.fromARGB(255, 73, 173, 255),
                  const Color.fromARGB(255, 14, 63, 210)
                ], () {
                  Get.to(ArsipBaratView());
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientContainer(
      String text, List<Color> colors, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
        ),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
