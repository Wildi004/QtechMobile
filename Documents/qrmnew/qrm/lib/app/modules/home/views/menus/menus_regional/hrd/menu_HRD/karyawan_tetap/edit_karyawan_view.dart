import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/karyawan_tetap.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/edit_karyawan_controller.dart';

class EditKaryawanView extends GetView<EditKaryawanController> {
  const EditKaryawanView({super.key, this.data});
  final KaryawanTetap? data;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<EditKaryawanController>()) {
      Get.lazyPut(() => EditKaryawanController());
    }

    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Karyawan tetap detail",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 91, 122),
      ),
      body: LzListView(
        gap: 10,
        children: [
          LzForm.input(
            label: 'ID Karyawan',
            model: forms.key('id'),
            maxLines: 5,
          ),
          LzForm.input(
            label: 'Nama Lengkap',
            maxLines: 5,
            model: forms.key('name'),
          ),
          LzForm.input(
            label: 'Email Karyawan',
            maxLines: 5,
            model: forms.key('email'),
          ),
          LzForm.input(
            label: 'No KTP',
            maxLines: 5,
            model: forms.key('no_ktp'),
          ),
          Row(
            children: [
              Flexible(
                child: LzForm.input(
                  label: 'Jenis Kelamin',
                  model: forms.key('gender'),
                ),
              ),
              const SizedBox(width: 16), // Jarak antar input
              Flexible(
                child: LzForm.input(
                  label: 'Agama',
                  model: forms.key('agama'),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: LzForm.input(
                  label: 'Tanggal lahir',
                  model: forms.key('tgl_lahir'),
                ),
              ),
              const SizedBox(width: 16), // Jarak antar input
              Flexible(
                child: LzForm.input(
                  label: 'Tempat lahir',
                  maxLines: 5,
                  model: forms.key('tempat_lahir'),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: LzForm.input(
                  label: 'No telepon',
                  model: forms.key('no_telp'),
                ),
              ),
              const SizedBox(width: 16), // Jarak antar input
              Flexible(
                child: LzForm.input(
                  label: 'Regional KTP',
                  model: forms.key('regional_ktp'),
                ),
              ),
            ],
          ),
          LzForm.input(
            maxLines: 5,
            label: 'Alamat domisili',
            model: forms.key('alamat_domisili'),
          ),
          LzForm.input(
            label: 'Alamat KTP',
            maxLines: 5,
            model: forms.key('alamat_ktp'),
          ),
          LzForm.input(
            label: 'Status kawin',
            model: forms.key('status_kawin_id'),
          ),
          Row(
            children: [
              Flexible(
                child: LzForm.input(
                  label: 'Tanggal bergabung',
                  model: forms.key('tgl_bergabung'),
                ),
              ),
              const SizedBox(width: 16), // Jarak antar input
              Flexible(
                child: LzForm.input(
                  label: 'ID telegram',
                  model: forms.key('id_telegram'),
                ),
              ),
            ],
          ),
          LzForm.input(
            label: 'Regional office',
            model: forms.key('regional'),
          ),
          Row(
            children: [
              Flexible(
                child: Obx(() {
                  if (controller.roles.isEmpty) {
                    return Text(
                        'Memuat data jabatan...'); // atau SizedBox.shrink()
                  }

                  return Column(
                    children: controller.roleid.generate(
                      (data, i) => LzForm.select(
                        label: 'Pilih jabatan',
                        hint: 'Klik untuk Jabatan',
                        model: data.key('role_id'),
                        onTap: () => controller.openRole(i),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(width: 16), // Jarak antar input
              Flexible(
                child: LzForm.input(
                  label: 'Departemen',
                  model: forms.key('dept'),
                ),
              ),
            ],
          ),
          LzForm.input(
            label: 'Golongan',
            model: forms.key('golongan'),
          ),
          LzForm.input(
            label: 'Foto profile',
            model: forms.key('image'),
          ),
           
          LzForm.input(
            label: 'Ulangi password',
          ),
          Obx(() => controller.fileName.value.isEmpty
              ? const None()
              : Column(
                  children: [
                    LzImage(controller.file, size: 100),
                  ],
                ).start),
          LzButton(
            text: data == null ? 'Submit' : 'Update',
            onTap: () {
              controller.onSubmit(data?.id);
            },
          ).margin(all: 20),
        ],
      ),
    );
  }
}
