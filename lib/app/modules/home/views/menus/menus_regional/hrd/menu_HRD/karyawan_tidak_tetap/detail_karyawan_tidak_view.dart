import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/karyawan_tidak.dart';
import 'package:qrm/app/modules/home/controllers/HRD/karyawan_tidak_tetap_controller/detail_ktt_controller.dart';

class DetailKaryawanTidakView extends GetView<DetailKttController> {
  const DetailKaryawanTidakView({super.key, this.data});
  final KaryawanTidak? data;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<DetailKttController>()) {
      Get.lazyPut(() => DetailKttController());
    }

    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Karyawan Tidak Tetap Detail",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 6, 91, 122),
        ),
        body: LzListView(
          gap: 10,
          children: [
            LzForm.input(
                label: 'Nama Lengkap',
                enabled: false,
                model: forms.key('name')),
            LzForm.input(label: 'NIK', enabled: false, model: forms.key('nik')),
            Row(
              children: [
                Flexible(
                  child: LzForm.input(
                      label: 'Jenis Kelamin',
                      enabled: false,
                      model: forms.key('gender')),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: LzForm.input(
                      label: 'Agama',
                      enabled: false,
                      model: forms.key('agama')),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: LzForm.input(
                      label: 'Tanggal Lahir',
                      enabled: false,
                      model: forms.key('tgl_lahir')),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: LzForm.input(
                      label: 'Tempat Lahir',
                      enabled: false,
                      model: forms.key('tempat_lahir')),
                ),
              ],
            ),
            LzForm.input(
                label: 'No Telepon',
                enabled: false,
                model: forms.key('no_telp')),
            LzForm.input(
                label: 'Alamat Domisili',
                enabled: false,
                maxLines: 3,
                model: forms.key('alamat_domisili')),
            LzForm.input(
                label: 'Alamat KTP',
                enabled: false,
                maxLines: 3,
                model: forms.key('alamat_ktp')),
            Row(
              children: [
                Flexible(
                  child: LzForm.input(
                      label: 'Status Kawin',
                      enabled: false,
                      model: forms.key('status_kawin')),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: LzForm.input(
                      label: 'Status Proyek',
                      enabled: false,
                      model: forms.key('status_proyek')),
                ),
              ],
            ),
            LzForm.input(
                label: 'Tanggal Bergabung',
                enabled: false,
                model: forms.key('tgl_bergabung')),
            LzForm.input(
                label: 'Proyek Item',
                enabled: false,
                model: forms.key('proyek_item')),
            LzForm.input(
                label: 'Regional Office',
                enabled: false,
                model: forms.key('regional')),
            Row(
              children: [
                Flexible(
                  child: LzForm.input(
                      label: 'Departemen',
                      enabled: false,
                      model: forms.key('dep')),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: LzForm.input(
                      label: 'Jabatan',
                      enabled: false,
                      model: forms.key('role')),
                ),
              ],
            ),
            LzForm.input(
                label: 'Aktif', enabled: false, model: forms.key('is_active')),
          ],
        ));
  }
}
// LzForm.input(
//     label: 'Foto (path)', enabled: false, model: forms.key('foto')),

// // Jika ingin menampilkan gambar
// Obx(() {
//   final fotoPath = forms.get('foto');
//   return (fotoPath == null || fotoPath.toString().isEmpty)
//       ? const None()
//       : Column(
//           children: [
//             const SizedBox(height: 10),
//             LzImage(fotoPath.toString(), size: 120),
//           ],
//         ).start;
// }),
