import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tidak.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/karyawan_tidak_tetap_controller/edit_ktt_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class EditKaryawanTidakView extends GetView<EditKttController> {
  const EditKaryawanTidakView({super.key, this.data});
  final KaryawanTidak? data;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<EditKttController>()) {
      Get.lazyPut(() => EditKttController());
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
          title: 'Edit Karyawan Tidak Tetap',
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
          children: [
            LzForm.input(
              label: 'Nama Lengkap',
              maxLines: 5,
              model: forms.key('name'),
            ),
            LzForm.input(
              label: 'Nik',
              maxLines: 5,
              keyboard: Tit.number,
              model: forms.key('nik'),
            ),
            Row(
              children: [
                Expanded(
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
                const SizedBox(width: 16),
                Expanded(
                  child: LzForm.select(
                      label: 'agama',
                      style: OptionPickerStyle(withSearch: true),
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
                Expanded(
                  child: LzForm.input(
                      label: 'Tanggal Lahir',
                      hint: 'Tanggal Lahir',
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
                const SizedBox(width: 16),
                Expanded(
                  child: LzForm.input(
                    label: 'Tempat lahir',
                    maxLines: 5,
                    model: forms.key('tempat_lahir'),
                  ),
                ),
              ],
            ),
            LzForm.input(
              label: 'No telepon',
              keyboard: Tit.number,
              model: forms.key('no_telp'),
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
            Row(
              children: [
                Expanded(
                  child: LzForm.select(
                    label: 'Status kawin',
                    style: OptionPickerStyle(withSearch: true),
                    hint: 'Status kawin',
                    model: forms.key('status_kawin_id'),
                    onTap: () => controller.openStatusKawin(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: LzForm.input(
                    label: 'Regional office',
                    model: forms.key('regional'),
                  ),
                ),
              ],
            ),
            LzForm.input(
                label: 'Tanggal Bergabung',
                hint: 'Tanggal Bergabun',
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

            Row(
              children: [
                Expanded(
                  child: LzForm.select(
                    label: 'Pilih jabatan',
                    style: OptionPickerStyle(withSearch: true),
                    hint: 'Klik untuk Jabatan',
                    model: forms.key('role_id'),
                    onTap: () => controller.openRole(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: LzForm.select(
                    label: 'Pilih Departemen',
                    hint: 'Klik untuk Departemen',
                    style: OptionPickerStyle(withSearch: true),
                    model: forms.key('dep_id'),
                    onTap: () => controller.openDep(),
                  ),
                ),
              ],
            ),
            LzForm.select(
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

            // LzButton(
            //   text: data == null ? 'Submit' : 'Update',
            //   onTap: () {
            //     controller.onSubmit(data?.id);
            //     logg('Tombol ditekan');
            //     logg(data?.toJson(), limit: 9999);
            //   },
            // ).margin(all: 20),
          ],
        ),
      ),
    );
  }
}
