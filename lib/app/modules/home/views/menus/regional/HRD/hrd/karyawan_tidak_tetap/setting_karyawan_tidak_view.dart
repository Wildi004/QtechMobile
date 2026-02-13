import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tetap.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tidak.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/karyawan_tidak_tetap_controller/edit_status_ktt_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/karyawan_tidak_tetap_controller/karyawan_tidak_tetap_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/karyawan_tidak_tetap/detail_karyawan_tidak_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/karyawan_tidak_tetap/edit_karyawan_tidak_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/karyawan_tidak_tetap/status_user_tidak_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';

class SettingKaryawanTidakView extends StatelessWidget {
  final KaryawanTidak? data;
  final KaryawanTetap? data1;

  final KaryawanTidakTetapController controller =
      Get.put(KaryawanTidakTetapController());

  SettingKaryawanTidakView({super.key, this.data, this.data1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Setting').appBar,
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
                        LzImage(
                          data!.foto ?? '',
                          size: 100,
                          fit: BoxFit.cover,
                          radius: 50,
                        ),

                        const SizedBox(height: 15),
                        Obx(() {
                          controller.isLoading.value;
                          final e = controller.getKaryawan(data?.id);

                          logg(e.toJson(), limit: 99999);

                          return Text(
                            textAlign: TextAlign.center,
                            e.name ?? '-',
                            style: GoogleFonts.notoSerif().copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          );
                        }),
                        Obx(() {
                          controller.isLoading.value;
                          final e = controller.getKaryawan(data?.id);
                          return Text(
                            e.isActive == 1
                                ? 'Karyawan Aktif'
                                : 'Karyawan Tidak Aktif',
                            style: TextStyle(
                              color: e.isActive == 1
                                  ? const Color.fromARGB(255, 40, 166, 44)
                                  : Colors.red,
                              fontSize: 14,
                            ),
                          );
                        }),

                        const SizedBox(height: 25),
                        // Tombol-tombol
                        buildButton('Detail Profile Karyawan', () {
                          Get.to(() => DetailKaryawanTidakView(data: data));
                        }),
                        buildButton('Edit Profile Karyawan', () {
                          Get.to(() => EditKaryawanTidakView(data: data))
                              ?.then((value) {
                            if (value != null) {
                              controller.updateData(value, data!.id!);
                            }
                          });
                        }),
                        buildButton('Status User', () {
                          Get.to(() => StatusUserTidakView(data: data))
                              ?.then((value) {
                            if (value != null) {
                              final form = Get.find<EditStatusKttController>();
                              form.updateData1(
                                  KaryawanTidak.fromJson(value), data!.id!);
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: jobdesk.map((data) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(height: 10),
                          Text(''),
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
