import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/karyawan_tetap.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/form_karyawan_tetap_controller.dart';

class DetailKaryawanTetapViev extends GetView<FormKaryawanTetapController> {
  const DetailKaryawanTetapViev({super.key, this.data});
  final KaryawanTetap? data;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<FormKaryawanTetapController>()) {
      Get.lazyPut(() => FormKaryawanTetapController());
    }

    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Karyawan tetap detail",
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
            enabled: false,
            maxLines: 5,
          ),
          LzForm.input(
            label: 'Nama Lengkap',
            enabled: false,
            maxLines: 5,
            model: forms.key('name'),
          ),
          LzForm.input(
            label: 'Email Karyawan',
            enabled: false,
            maxLines: 5,
            model: forms.key('email'),
          ),
          LzForm.input(
            label: 'No KTP',
            enabled: false,
            maxLines: 5,
            model: forms.key('no_ktp'),
          ),
          Row(
            children: [
              Flexible(
                child: LzForm.input(
                  label: 'Jenis Kelamin',
                  enabled: false,
                  model: forms.key('gender'),
                ),
              ),
              const SizedBox(width: 16), // Jarak antar input
              Flexible(
                child: LzForm.input(
                  label: 'Agama',
                  enabled: false,
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
                  enabled: false,
                  model: forms.key('tgl_lahir'),
                ),
              ),
              const SizedBox(width: 16), // Jarak antar input
              Flexible(
                child: LzForm.input(
                  label: 'Tempat lahir',
                  enabled: false,
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
                  enabled: false,
                  model: forms.key('no_telp'),
                ),
              ),
              const SizedBox(width: 16), // Jarak antar input
              Flexible(
                child: LzForm.input(
                  label: 'Regional KTP',
                  enabled: false,
                  model: forms.key('regional_ktp'),
                ),
              ),
            ],
          ),
          LzForm.input(
            maxLines: 5,
            label: 'Alamat domisili',
            enabled: false,
            model: forms.key('alamat_domisili'),
          ),
          LzForm.input(
            label: 'Alamat KTP',
            maxLines: 5,
            enabled: false,
            model: forms.key('alamat_ktp'),
          ),
          LzForm.input(
            label: 'Status kawin',
            enabled: false,
            model: forms.key('status_kawin_id'),
          ),
          Row(
            children: [
              Flexible(
                child: LzForm.input(
                  label: 'Tanggal bergabung',
                  enabled: false,
                  model: forms.key('tgl_bergabung'),
                ),
              ),
              const SizedBox(width: 16), // Jarak antar input
              Flexible(
                child: LzForm.input(
                  label: 'ID telegram',
                  enabled: false,
                  model: forms.key('id_telegram'),
                ),
              ),
            ],
          ),
          LzForm.input(
            label: 'Regional office',
            enabled: false,
            model: forms.key('regional'),
          ),
          Row(
            children: [
              Flexible(
                child: LzForm.input(
                  label: 'Jabatan',
                  enabled: false,
                  model: forms.key('role'),
                ),
              ),
              const SizedBox(width: 16), // Jarak antar input
              Flexible(
                child: LzForm.input(
                  label: 'Departemen',
                  enabled: false,
                  model: forms.key('dept'),
                ),
              ),
            ],
          ),
          LzForm.input(
            label: 'Golongan',
            enabled: false,
            model: forms.key('golongan'),
          ),
          LzForm.input(
            label: 'Foto Profile',
            enabled: false,
            model: forms.key('image'),
          ),
          LzForm.input(
            label: 'Password',
            enabled: false,
            model: forms.key('password'),
          ),
        ],
      ),
    );
  }
}
