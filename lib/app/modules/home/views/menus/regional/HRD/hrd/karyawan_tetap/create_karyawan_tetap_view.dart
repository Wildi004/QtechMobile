import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tetap.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/create_karyawan_tetap_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/image_picker.dart';

class CreateKaryawanTetapView extends GetView<CreateKaryawanTetapController> {
  const CreateKaryawanTetapView({super.key, this.data});
  final KaryawanTetap? data;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<CreateKaryawanTetapController>()) {
      Get.lazyPut(() => CreateKaryawanTetapController());
    }

    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
      controller.getDetailUser(data!.id!);
    }

    return SafeArea(
      top: false,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppbar(
            title: 'Form Karyawan tetap',
            actions: [
              IconButton(
                  onPressed: () {
                    controller.onSubmit(data?.id);
                  },
                  icon: Icon(Hi.tick04))
            ],
          ).appBar,
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
                      hint: 'Contoh: Qrm-001',
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
                      keyboard: Tit.number,
                      label: 'Prosentase',
                      hint: 'Persentase jabatan',
                      model: forms.key('prosentase'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: LzForm.input(
                      keyboard: Tit.number,
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
                      label: 'Email',
                      hint: 'Email qtech',
                      model: forms.key('email'),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              LzForm.input(
                label: 'No telepon',
                keyboard: Tit.number,
                hint: 'Nomor telepon',
                model: forms.key('no_telp'),
              ),
              const SizedBox(width: 16),

              // FOTO
              LzForm.input(
                hint: 'Pilih gambar',
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
                },
              ),
              Obx(() => controller.fileName.value.isEmpty
                  ? const None()
                  : Column(children: [LzImage(controller.file, size: 100)])
                      .start),

              // TTD
              LzForm.input(
                hint: 'Pilih tanda tangan',
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
                },
              ),
              Obx(() => controller.fileName.value.isEmpty
                  ? const None()
                  : Column(children: [LzImage(controller.file, size: 100)])
                      .start),

              Row(
                children: [
                  Flexible(
                    child: LzForm.select(
                      label: 'Pilih jabatan',
                      hint: 'Klik untuk memilih jabatan',
                      style: OptionPickerStyle(withSearch: true),
                      model: forms.key('role_id'),
                      onTap: () => controller.openRole(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: LzForm.select(
                      style: OptionPickerStyle(withSearch: true),
                      label: 'Pilih Departemen',
                      hint: 'Klik untuk memilih departemen',
                      model: forms.key('dept_id'),
                      onTap: () => controller.openDep(),
                    ),
                  ),
                ],
              ),

              LzForm.select(
                label: 'Regional',
                style: OptionPickerStyle(withSearch: true),
                hint: 'Pilih regional',
                model: controller.forms.key('regional'),
                onTap: () async {
                  final data = await controller.getReg().overlay();
                  controller.forms
                      .set('regional')
                      .options(data.labelValue('name'));
                },
              ),
              Row(
                children: [
                  Flexible(
                    child: LzForm.input(
                      label: 'Regional KTP',
                      hint: 'Wilayah KTP',
                      model: forms.key('regional_ktp'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: LzForm.input(
                      label: 'Alamat KTP',
                      hint: 'Alamat sesuai KTP',
                      model: forms.key('alamat_ktp'),
                    ),
                  ),
                ],
              ),
              LzForm.input(
                label: 'Alamat Domisili',
                hint: 'Alamat tempat tinggal saat ini',
                model: forms.key('alamat_domisili'),
              ),
              Row(
                children: [
                  Flexible(
                    child: LzForm.input(
                      label: 'Tempat Lahir',
                      hint: 'Tempat lahir',
                      model: forms.key('tempat_lahir'),
                    ),
                  ),
                  16.width,
                  Flexible(
                    child: LzForm.input(
                      label: 'Tanggal Lahir',
                      hint: 'Format: YYYY-MM-DD',
                      model: forms.key('tgl_lahir'),
                      suffixIcon: Hi.calendar02,
                      onTap: () {
                        LzPicker.date(context,
                            minDate: DateTime(1900),
                            initDate: forms.get('tgl_lahir').toDate(),
                            onSelect: (date) {
                          forms.set('tgl_lahir', date.format());
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: LzForm.select(
                      label: 'Gender',
                      style: OptionPickerStyle(withSearch: true),
                      hint: 'Pilih jenis kelamin',
                      model: controller.forms.key('gender'),
                      onTap: () async {
                        final data = await controller.getgender().overlay();
                        controller.forms
                            .set('gender')
                            .options(data.labelValue('name'));
                      },
                    ),
                  ),
                  10.width,
                  Flexible(
                    child: LzForm.select(
                      label: 'Agama',
                      style: OptionPickerStyle(withSearch: true),
                      hint: 'Pilih agama',
                      model: controller.forms.key('agama'),
                      onTap: () async {
                        final data = await controller.getAgama().overlay();
                        controller.forms
                            .set('agama')
                            .options(data.labelValue('name'));
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: LzForm.select(
                      label: 'Status Kawin',
                      style: OptionPickerStyle(withSearch: true),
                      hint: 'Pilih status pernikahan',
                      model: forms.key('status_kawin_id'),
                      onTap: () => controller.openStatusKawin(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: LzForm.input(
                      label: 'Tanggal Bergabung',
                      hint: 'Tanggal mulai kerja',
                      model: forms.key('tgl_bergabung'),
                      suffixIcon: Hi.calendar02,
                      onTap: () {
                        LzPicker.date(context,
                            minDate: DateTime(1900),
                            initDate: forms.get('tgl_bergabung').toDate(),
                            onSelect: (date) {
                          forms.set('tgl_bergabung', date.format());
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: LzForm.select(
                      label: 'Pilih Status Aktif',
                      style: OptionPickerStyle(withSearch: true),
                      hint: 'Aktif / Tidak Aktif',
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
                      style: OptionPickerStyle(withSearch: true),
                      label: 'Pilih Shift',
                      hint: 'Shift kerja karyawan',
                      model: forms.key('shift_id'),
                      onTap: () => controller.opensift(),
                    ),
                  ),
                ],
              ),
              LzForm.select(
                label: 'Building',
                hint: 'Pilih gedung lokasi kerja',
                style: OptionPickerStyle(withSearch: true),
                model: forms.key('building_id'),
                onTap: () => controller.openBuilding(),
              ),
              Row(
                children: [
                  Flexible(
                    child: LzForm.select(
                      style: OptionPickerStyle(withSearch: true),
                      label: 'Status Karyawan',
                      hint: 'Status kerja',
                      model: controller.forms.key('status_karyawan'),
                      onTap: () async {
                        final data =
                            await controller.getStatuskaryawan().overlay();
                        controller.forms
                            .set('status_karyawan')
                            .options(data.labelValue('name'));
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: LzForm.input(
                      hint: 'ID akun Telegram',
                      keyboard: Tit.number,
                      label: 'ID Telegram',
                      model: forms.key('id_telegram'),
                    ),
                  ),
                ],
              ),
              Obx(() => controller.fileName.value.isEmpty
                  ? const None()
                  : Column(children: [LzImage(controller.file, size: 100)])
                      .start),
            ],
          )),
    );
  }
}

//
