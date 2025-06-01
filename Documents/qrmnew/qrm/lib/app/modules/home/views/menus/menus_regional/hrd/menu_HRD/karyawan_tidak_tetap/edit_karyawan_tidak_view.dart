import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/karyawan_tidak.dart';
import 'package:qrm/app/modules/home/controllers/HRD/karyawan_tidak_tetap_controller/form_ktt_controller.dart';

class EditKaryawanTidakView extends GetView<FormKttController> {
  const EditKaryawanTidakView({super.key, this.data});
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

            maxLines: 5,
          ),
          LzForm.input(
            label: 'Nama Lengkap',

            maxLines: 5,
            model: forms.key('name'), //
          ),
          LzForm.input(
            label: 'Nik',

            maxLines: 5,
            model: forms.key('nik'), //
          ),
          Row(
            children: [
              Flexible(
                child: LzForm.input(
                  label: 'Jenis Kelamin',

                  model: forms.key('gender'), //
                ),
              ),
              const SizedBox(width: 16), // Jarak antar input
              Flexible(
                child: LzForm.input(
                  label: 'Agama',

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

                  model: forms.key('tgl_lahir'), //
                ),
              ),
              const SizedBox(width: 16), // Jarak antar input
              Flexible(
                child: LzForm.input(
                  label: 'Tempat lahir',

                  maxLines: 5,
                  model: forms.key('tempat_lahir'), //
                ),
              ),
            ],
          ),
          LzForm.input(
            label: 'No telepon',

            model: forms.key('no_telp'), //
          ),
          LzForm.input(
            maxLines: 5,
            label: 'Alamat domisili',

            model: forms.key('alamat_domisili'), //
          ),
          LzForm.input(
            label: 'Alamat KTP',
            maxLines: 5,

            model: forms.key('alamat_ktp'), //
          ),
          LzForm.input(
            label: 'Status kawin',

            model: forms.key('status_kawin_id'), //
          ),
          LzForm.input(
            label: 'Tanggal bergabung',

            model: forms.key('tgl_bergabung'), //
          ),
          LzForm.input(
            label: 'Status Proyek',

            model: forms.key('status_proyek'), //
          ),
          LzForm.input(
            label: 'Proyek item ID',

            model: forms.key('proyek_item_id'), //
          ),
          LzForm.input(
            label: 'Regional office',

            model: forms.key('regional'), //
          ),
          LzForm.input(
            maxLines: 5,
            label: 'Jabatan',

            model: forms.key('role'), //
          ),
          LzForm.input(
            maxLines: 5,
            label: 'Departemen',

            model: forms.key('dept'), //
          ),
          LzForm.input(
            label: 'foto',

            model: forms.key('foto'), //
          ),
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
