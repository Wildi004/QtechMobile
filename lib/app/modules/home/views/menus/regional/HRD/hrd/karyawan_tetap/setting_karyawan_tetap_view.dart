import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tetap.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/form_karyawan_tetap_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/karyawan_tetap_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/setting_karyawan_tetap_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/karyawan_tetap/detail_karyawan_tetap_viev.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/karyawan_tetap/edit_karyawan_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/karyawan_tetap/status_user_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/karyawan_tetap/tanda_tangan_karyawan.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';

class SettingKaryawanTetapView extends GetView<KaryawanTetapController> {
  final KaryawanTetap? data;
  const SettingKaryawanTetapView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<FormKaryawanTetapController>()) {
      Get.lazyPut(() => FormKaryawanTetapController());
    }

    return Scaffold(
      appBar: CustomAppbar(title: 'Setting').appBar,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LzImage(
                      data!.image ?? '',
                      size: 100,
                      fit: BoxFit.cover,
                      radius: 50,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      data!.name ?? '-',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSerif().copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    Text(
                      data!.isActive == 1
                          ? 'Karyawan Aktif'
                          : 'Karyawan Tidak Aktif',
                      style: TextStyle(
                        color: data!.isActive == 1
                            ? const Color.fromARGB(255, 40, 166, 44)
                            : Colors.red,
                        fontSize: 14,
                      ),
                    ),

                    //

                    const SizedBox(height: 25),

                    buildButton('Detail Profile Karyawan', () {
                      Get.to(
                        () => DetailKaryawanTetapViev(data: data),
                      )?.then((value) {
                        if (value != null) {
                          final form = Get.find<FormKaryawanTetapController>();
                          form.updateData(
                              KaryawanTetap.fromJson(value), data!.id!);
                        }
                      });
                    }),
                    buildButton('Edit Profile Karyawan', () {
                      Get.to(() => EditKaryawanView(
                            data: data,
                          ))?.then((value) {
                        if (value != null) {
                          controller.updateData(value, data!.id!);
                        }
                      });
                    }),
                    buildButton('Tambah Tanda Tangan', () async {
                      Get.to(() => TandaTanganKaryawan(data: data))
                          ?.then((value) {
                        if (value != null) {
                          final karyawanCtrl =
                              Get.find<KaryawanTetapController>();
                          karyawanCtrl.updateData(value, data!.id!);
                        }
                      });
                    }),
                    buildButton('Status User', () {
                      Get.to(
                        () => StatusUserView(data: data),
                      )?.then((value) {
                        if (value != null) {
                          final form =
                              Get.find<SettingKaryawanTetapController>();
                          form.updateData(
                              KaryawanTetap.fromJson(value), data!.id!);
                        }
                      });
                    }),

                    buildButton('Hapus Karyawan', () {
                      CustomDelete.show(
                        title: 'Konfirmasi Hapus',
                        message:
                            'Apakah Anda Yakin Ingin Menghapus Karyawan Ini?',
                        context: context,
                        onConfirm: () {
                          if (data?.id != null) {
                            controller.deleteData(data!.id!);
                          }
                        },
                      );
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
}

Widget buildButton(String title, VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
    child: LzCard(
      onTap: onTap,
      padding: Ei.all(15),
      children: [
        Center(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
