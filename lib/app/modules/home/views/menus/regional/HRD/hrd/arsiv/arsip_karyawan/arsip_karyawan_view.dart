import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/arsiv/arsip_karyawan/arsip_barat_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/arsiv/arsip_karyawan/arsip_pusat.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/arsiv/arsip_karyawan/arsip_timur_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart'; // pastikan import widget-nya

class ArsipKaryawanView extends StatelessWidget {
  const ArsipKaryawanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Arsip Karyawan').appBar,
      body: LzListView(
        children: [
          _buildGradientContainer("Kantor Pusat", () {
            context.openBottomSheet(ArsipPusat());
          }),
          _buildGradientContainer("Regional Timur", () {
            context.openBottomSheet(ArsipTimurView());
          }),
          _buildGradientContainer("Regional Barat", () {
            context.openBottomSheet(ArsipBaratView());
          }),
        ],
      ),
    );
  }

  Widget _buildGradientContainer(String text, VoidCallback onTap) {
    return CustomScalaContainer(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
          ),
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: CustomDecoration.validator(),
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
      ),
    );
  }
}
