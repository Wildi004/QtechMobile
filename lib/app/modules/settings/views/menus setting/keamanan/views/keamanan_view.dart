import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/settings/views/menus%20setting/keamanan/controllers/keamanan_controller.dart';

// contoh menampilkan halaman tanpa Routes
// kita harus menyiapkan/menginitialisasi controllernya secara manual

class KeamananView extends GetView<KeamananController> {
  const KeamananView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() =>
        KeamananController()); // <-- cara menyiapkan controller secara manual

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: LzListView(
        children: [WidgetProfile()],
      ),
    );
  }
}

class WidgetProfile extends GetView<KeamananController> {
  const WidgetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    // ini cara pertama, tanpa indikator loading
    return Obx(() {
      final user = controller.user.value;

      // contoh tanggal lahir
      String birthdate = '1990-10-10';

      return LzCard(
        style: LzCardStyle(stacked: true),
        children: [
          Row(
            children: [
              Text(user?.name ?? '-'),
              Text('${Date.calculateAge(birthdate.toDate()).year} tahun')
            ],
          ).between,
          Text(user?.agama ?? '-')
        ],
      );
    });

    // ini cara kedua, dengan indikator loading
    // return Obx(() {
    //   bool loading = controller.isLoading.value;
    //   final user = controller.user2;

    //   if (loading) {
    //     return Text('Masih loading...');
    //   }

    //   // contoh tanggal lahir
    //   String birthdate = '1990-10-10';

    //   return LzCard(
    //     style: LzCardStyle(stacked: true),
    //     children: [
    //       Row(
    //         children: [Text(user.name ?? '-'), Text('${Date.calculateAge(birthdate.toDate()).year} tahun')],
    //       ).between,
    //       Text(user.agama ?? '-')
    //     ],
    //   );
    // });
  }
}
