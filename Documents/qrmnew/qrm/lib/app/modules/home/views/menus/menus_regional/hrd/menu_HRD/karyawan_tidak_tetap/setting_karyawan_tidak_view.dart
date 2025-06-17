import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/models/karyawan_tetap.dart';
import 'package:qrm/app/data/models/karyawan_tidak.dart';
import 'package:qrm/app/modules/home/controllers/HRD/karyawan_tidak_tetap_controller/karyawan_tidak_tetap_controller.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/karyawan_tetap/tanda_tangan_karyawan.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/karyawan_tidak_tetap/detail_karyawan_tidak_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/karyawan_tidak_tetap/edit_karyawan_tidak_view.dart';
import 'package:qrm/app/widgets/token_image_widget.dart';

class SettingKaryawanTidakView extends StatelessWidget {
  final KaryawanTidak? data;
  final KaryawanTetap? data1;

  final KaryawanTidakTetapController controller =
      Get.put(KaryawanTidakTetapController());

  SettingKaryawanTidakView({super.key, this.data, this.data1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("setting", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: ['4CA1AF'.hex, '808080'.hex],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                final jobdesk = controller.karyawanTidak;

                return LzListView(padding: Ei.sym(v: 20), children: [
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                            height: 100,
                            width: 100,
                            child: TokenImage(data?.foto ?? '')),

                        const SizedBox(height: 15),
                        Text(
                          textAlign: TextAlign.center,
                          data?.name ?? '',
                          style: GoogleFonts.notoSerif().copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const Text(
                          'Karyawan Aktif',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Tombol-tombol
                        buildButton('Detail Profile Karyawan', () {
                          context.openBottomSheet(DetailKaryawanTidakView(
                            data: data,
                          ));
                        }),
                        buildButton('Edit Profile Karyawan', () {
                          context.openBottomSheet(EditKaryawanTidakView(
                            data: data,
                          ));
                        }),
                        buildButton('Tambah Tanda Tangan', () {
                          context.openBottomSheet(TandaTanganKaryawan());
                        }),
                        buildButton('Status User', () {
                          // aksi status
                        }),
                        buildButton('Hapus Karyawan', () {
                          // aksi hapus
                        }),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),

                  // Tambahan konten dari jobdesk jika dibutuhkan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: jobdesk.map((data) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(height: 10),
                          Text(''), // ganti jika ingin menampilkan data
                        ],
                      );
                    }).toList(),
                  ),
                ]);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String title, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: const BorderSide(color: Colors.black),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
