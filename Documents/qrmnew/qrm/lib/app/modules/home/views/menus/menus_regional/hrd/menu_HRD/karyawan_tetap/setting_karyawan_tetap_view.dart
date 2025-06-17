import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/models/karyawan_tetap.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/form_karyawan_tetap_controller.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/karyawan_tetap/detail_karyawan_tetap_viev.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/karyawan_tetap/edit_karyawan_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/karyawan_tetap/status_user_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/karyawan_tetap/tanda_tangan_karyawan.dart';
import 'package:qrm/app/widgets/token_image_widget.dart';

import '../../../../../../controllers/HRD/hrd_karyawan_tetap_controller/karyawan_tetap_controller.dart';

class SettingKaryawanTetapView extends GetView<KaryawanTetapController> {
  final KaryawanTetap? data;
  const SettingKaryawanTetapView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
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
                child: LzListView(padding: Ei.sym(v: 20), children: [
              Center(
                child: Column(
                  children: [
                    TokenImage(data?.image ?? ''),
                    const SizedBox(height: 15),
                    Text(
                      textAlign: TextAlign.center,
                      data?.name ?? '',
                      style: GoogleFonts.notoSerif().copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      data?.isActive == 1
                          ? 'Karyawan Aktif'
                          : 'Karyawan Tidak Aktif',
                      style: TextStyle(
                        color: data?.isActive == 1
                            ? const Color.fromARGB(255, 40, 166, 44)
                            : Colors.red,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Tombol-tombol
                    buildButton('Detail Profile Karyawan', () {
                      context.openBottomSheet(DetailKaryawanTetapViev(
                        data: data,
                      ));
                    }),
                    buildButton('Edit Profile Karyawan', () {
                      context.openBottomSheet(EditKaryawanView(
                        data: data,
                      ));
                    }),
                    buildButton('Tambah Tanda Tangan', () {
                      Get.to(() => TandaTanganKaryawan(data: data))
                          ?.then((value) {
                        if (value != null) {
                          final form = Get.find<FormKaryawanTetapController>();
                          form.updateData(
                              KaryawanTetap.fromJson(value), data!.id!);
                        }
                      });
                    }),
                    buildButton('Status User', () {
                      context.openBottomSheet(StatusUserView(
                        data: data,
                      ));
                    }),
                    buildButton('Hapus Karyawan', () {
                      Get.defaultDialog(
                          title: 'Konfirmasi',
                          titleStyle: TextStyle(fontWeight: Fw.bold),
                          middleText:
                              'Apakah Anda yakin ingin menghapus data ini?',
                          middleTextStyle: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.018,
                          ),
                          textConfirm: 'Ya',
                          buttonColor: Colors.blue,
                          textCancel: 'Batal',
                          confirmTextColor: Colors.white,
                          onConfirm: () async {
                            Get.back();
                            await Future.delayed(Duration(milliseconds: 300));
                            await controller.deleteData(data!.id!);
                          });
                    }),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ])),
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

// Tambahan konten dari data jika dibutuhkan
// Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: data1.map((data) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         SizedBox(height: 10),
//         Text(''), // ganti jika ingin menampilkan data
//       ],
//     );
//   }).toList(),
// ),
