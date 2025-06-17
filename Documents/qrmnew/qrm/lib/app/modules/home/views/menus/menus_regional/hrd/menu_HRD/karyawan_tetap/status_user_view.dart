import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/karyawan_tetap.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/setting_karyawan_tetap_controller.dart';

class StatusUserView extends GetView<SettingKaryawanTetapController> {
  const StatusUserView({super.key, this.data});
  final KaryawanTetap? data;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SettingKaryawanTetapController>()) {
      Get.lazyPut(() => SettingKaryawanTetapController());
    }
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Status User',
          style: TextStyle(color: Colors.white, fontWeight: Fw.bold),
        ),
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
      backgroundColor: Colors.white,
      body: LzListView(
        children: [
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: data?.image != null
                          ? ClipOval(
                              child: Image.network(
                                'https://laravel.apihbr.link/storage/${data?.image}',
                                width: 130,
                                height: 130,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.blue,
                                    child: const Icon(Icons.person,
                                        size: 50, color: Colors.white),
                                  );
                                },
                              ),
                            )
                          : Container(
                              color: Colors.blue,
                              alignment: Alignment.center,
                              child: const Icon(Icons.person,
                                  size: 50, color: Colors.white),
                            ),
                    ),
                    const SizedBox(height: 15),
                    LzForm.select(
                      label: 'Status karyawan',
                      hint: 'Pilih Status',
                      model: controller.forms.key('is_active'),
                      onTap: () async {
                        final data = await controller.getStatus().overlay();
                        controller.forms
                            .set('is_active')
                            .options(data.labelValue(
                              'name',
                            ));
                      },
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
