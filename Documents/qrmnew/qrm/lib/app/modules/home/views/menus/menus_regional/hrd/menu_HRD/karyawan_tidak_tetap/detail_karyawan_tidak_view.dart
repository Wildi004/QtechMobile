import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/karyawan_tidak.dart';
import 'package:qrm/app/modules/home/controllers/HRD/karyawan_tidak_tetap_controller/form_ktt_controller.dart';

class DetailKaryawanTidakView extends GetView<FormKttController> {
  const DetailKaryawanTidakView({super.key, this.data});
  final KaryawanTidak? data;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<FormKttController>()) {
      Get.lazyPut(() => FormKttController());
    }

    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Karyawan tidak tetap detail",
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
            model: forms.key('id'), //
            enabled: false,
            maxLines: 5,
          ),
          LzForm.input(
            label: 'Nama Lengkap',
            enabled: false,
            maxLines: 5,
            model: forms.key('name'), //
          ),
          LzForm.input(
            label: 'Nik',
            enabled: false,
            maxLines: 5,
            model: forms.key('nik'), //
          ),
          Row(
            children: [
              Flexible(
                child: LzForm.input(
                  label: 'Jenis Kelamin',
                  enabled: false,
                  model: forms.key('gender'), //
                ),
              ),
              const SizedBox(width: 16), // Jarak antar input
              Flexible(
                child: LzForm.input(
                  label: 'Agama',
                  enabled: false,
                  model: forms.key('agama'), //
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
                  model: forms.key('tgl_lahir'), //
                ),
              ),
              const SizedBox(width: 16), // Jarak antar input
              Flexible(
                child: LzForm.input(
                  label: 'Tempat lahir',
                  enabled: false,
                  maxLines: 5,
                  model: forms.key('tempat_lahir'), //
                ),
              ),
            ],
          ),
          LzForm.input(
            label: 'No telepon',
            enabled: false,
            model: forms.key('no_telp'), //
          ),
          LzForm.input(
            maxLines: 5,
            label: 'Alamat domisili',
            enabled: false,
            model: forms.key('alamat_domisili'), //
          ),
          LzForm.input(
            label: 'Alamat KTP',
            maxLines: 5,
            enabled: false,
            model: forms.key('alamat_ktp'), //
          ),
          LzForm.input(
            label: 'Status kawin',
            enabled: false,
            model: forms.key('status_kawin_id'), //
          ),
          LzForm.input(
            label: 'Tanggal bergabung',
            enabled: false,
            model: forms.key('tgl_bergabung'), //
          ),
          LzForm.input(
            label: 'Status Proyek',
            enabled: false,
            model: forms.key('status_proyek'), //
          ),
          LzForm.input(
            label: 'Proyek item ID',
            enabled: false,
            model: forms.key('proyek_item_id'), //
          ),
          LzForm.input(
            label: 'Regional office',
            enabled: false,
            model: forms.key('regional'), //
          ),
          LzForm.input(
            maxLines: 5,
            label: 'Jabatan',
            enabled: false,
            model: forms.key('role'), //
          ),
          LzForm.input(
            maxLines: 5,
            label: 'Departemen',
            enabled: false,
            model: forms.key('dept'), //
          ),
          LzForm.input(
            label: 'foto',
            enabled: false,
            model: forms.key('foto'), //
          ),
        ],
      ),
    );
  }
}
