
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/karyawan_tetap.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/edit_karyawan_controller.dart';
import 'package:qrm/app/widgets/image_picker.dart';

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
      controller.getDetailUser(data!.id!);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Form Karyawan tetap",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 91, 122),
      ),
      body: LzListView(
        gap: 10,
        autoCache: true,
        children: [
          LzForm.input(
            label: 'Nama Lengkap',
            hint: 'Nama karyawan',
            maxLines: 5,
            model: forms.key('name'),
          ),
          Row(
            children: [
              Flexible(
                child: LzForm.input(
                  label: 'No induk',
                  hint: 'contoh : Qrm-001',
                  maxLines: 1,
                  model: forms.key('no_induk'),
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: LzForm.input(
                  label: 'Golongan',
                  maxLines: 1,
                  hint: 'Golongan jabatan',
                  model: forms.key('golongan'),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Flexible(
                child: LzForm.input(
                  label: 'Prosentase',
                  hint: 'Presentase jabatan',
                  model: forms.key('prosentase'),
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: LzForm.input(
                  hint: 'Nomor KTP',
                  label: 'Nomor KTP',
                  model: forms.key('no_ktp'),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: LzForm.input(
                  label: 'email',
                  hint: 'Email qtech',
                  model: forms.key('email'),
                ),
              ),
              const SizedBox(width: 16), // Jarak antar input
            ],
          ),

          LzForm.input(
            label: 'No telepon',
            hint: 'Nomor Telepon',
            model: forms.key('no_telp'),
          ),

          const SizedBox(width: 16), // Jarak antar input

          LzForm.input(
              hint: 'Pilih Gambar',
              label: 'Pilih gambar',
              model: forms.key('image'),
              suffixIcon: Hi.image01,
              onTap: () {
                Pickers.image(then: (file) {
                  if (file != null) {
                    forms.set('image', file.path);
                    controller.fileImage = file;
                  }
                });
              }),
          Obx(() => controller.fileName.value.isEmpty
              ? const None()
              : Column(
                  children: [
                    LzImage(controller.file, size: 100),
                  ],
                ).start),
          LzForm.input(
              hint: 'Pilih ttd',
              label: 'Pilih ttd',
              model: forms.key('ttd'),
              suffixIcon: Hi.image01,
              onTap: () {
                Pickers.image(then: (file) {
                  if (file != null) {
                    forms.set('ttd', file.path);
                    controller.fileTtd = file;
                  }
                });
              }),
          Obx(() => controller.fileName.value.isEmpty
              ? const None()
              : Column(
                  children: [
                    LzImage(controller.file, size: 100),
                  ],
                ).start),
          LzForm.select(
            label: 'Pilih jabatan',
            hint: 'Klik untuk Jabatan',
            model: forms.key('role_id'),
            onTap: () => controller.openRole(),
          ),
          LzForm.select(
            label: 'Pilih Departemen',
            hint: 'Klik untuk Departemen',
            model: forms.key('dept_id'),
            onTap: () => controller.openDep(),
          ),

          LzForm.input(
            label: 'regional',
            hint: 'Pusat, Pusat-Finance, Pusat-BSD, Pusat-Teknik, Timur, Barat',
            model: forms.key('regional'),
          ),
          Row(
            children: [
              Flexible(
                child: LzForm.input(
                  label: 'regional ktp',
                  hint: 'Regional KTP',
                  model: forms.key('regional_ktp'),
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: LzForm.input(
                  label: 'alamat ktp',
                  hint: 'alamat KTP',
                  model: forms.key('alamat_ktp'),
                ),
              ),
            ],
          ),
          LzForm.input(
            label: 'alamat domisili',
            hint: 'alamat domisili',
            model: forms.key('alamat_domisili'),
          ),
          Row(
            children: [
              Flexible(
                child: LzForm.input(
                  label: 'tempat lahir',
                  hint: 'Tempat lahir',
                  model: forms.key('tempat_lahir'),
                ),
              ),
              16.width,
              Flexible(
                child: LzForm.input(
                    label: 'tgl lahir',
                    hint: 'Format : Y-m-d',
                    model: forms.key('tgl_lahir'),
                    suffixIcon: Hi.calendar02,
                    onTap: () {
                      LzPicker.date(context,
                          minDate: DateTime(1900),
                          initDate: forms.get('tgl_lahir').toDate(),
                          onSelect: (date) {
                        forms.set('tgl_lahir', date.format());
                      });
                    }),
              ),
            ],
          ),

          Row(
            children: [
              Flexible(
                child: LzForm.select(
                    label: 'Gender',
                    hint: 'Pilih gender',
                    model: controller.forms.key('gender'),
                    onTap: () async {
                      final data = await controller.getgender().overlay();
                      controller.forms
                          .set('gender')
                          .options(data.labelValue('name'));
                    }),
              ),
              10.width,
              Flexible(
                child: LzForm.select(
                    label: 'agama',
                    hint: 'Pilih agama',
                    model: controller.forms.key('agama'),
                    onTap: () async {
                      final data = await controller.getAgama().overlay();
                      controller.forms
                          .set('agama')
                          .options(data.labelValue('name'));
                    }),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: LzForm.select(
                  label: 'Status kawin',
                  hint: 'Status kawin',
                  model: forms.key('status_kawin_id'),
                  onTap: () => controller.openStatusKawin(),
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: LzForm.input(
                    label: 'Tgl bergabung',
                    hint: 'Tgl bergabung',
                    model: forms.key('tgl_bergabung'),
                    suffixIcon: Hi.calendar02,
                    onTap: () {
                      LzPicker.date(context,
                          minDate: DateTime(1900),
                          initDate: forms.get('tgl_bergabung').toDate(),
                          onSelect: (date) {
                        forms.set('tgl_bergabung', date.format());
                      });
                    }),
              ),
            ],
          ),

          Row(
            children: [
              Flexible(
                child: LzForm.select(
                  label: 'Pilih Status Aktif',
                  model: forms.key('is_active'),
                  onTap: () async {
                    final data = await controller.getAktif().overlay();
                    controller.forms
                        .set('is_active')
                        .options(data.labelValue('name', 'id'));
                  },
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: LzForm.select(
                  label: 'Pilih shift',
                  model: forms.key('shift_id'),
                  onTap: () => controller.opensift(),
                ),
              ),
            ],
          ),

          LzForm.select(
            label: 'building',
            model: forms.key('building_id'),
            onTap: () => controller.openBuilding(),
          ),

          Row(
            children: [
              Flexible(
                child: LzForm.select(
                    label: ' status karyawan',
                    hint: 'Pilih Status',
                    model: controller.forms.key('status_karyawan'),
                    onTap: () async {
                      final data =
                          await controller.getStatuskaryawan().overlay();
                      controller.forms
                          .set('status_karyawan')
                          .options(data.labelValue('name'));
                    }),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: LzForm.input(
                  hint: 'Id telegram user',
                  label: 'id telegram',
                  model: forms.key('id_telegram'),
                ),
              ),
            ],
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

//  Row(
//             children: [
//               Flexible(
//                 child: LzForm.select(
//                         label: 'Pilih jabatan',
//                         hint: 'Klik untuk Jabatan',
//                         model: forms.key('role_id'),
//                         onTap: () => controller.openRole(),
//                       )
//               ),

//               const SizedBox(width: 16), // Jarak antar input
//               Flexible(
//                 child: LzForm.input(
//                   label: 'Departemen',
//                   model: forms.key('dept'),
//                 ),
//               ),
//             ],
//           ),
