import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/karyawan_tidak.dart';
import 'package:qrm/app/modules/home/controllers/HRD/karyawan_tidak_tetap_controller/create_ktt_controller.dart';

class CreateKaryawanTidakView extends GetView<CreateKttController> {
  const CreateKaryawanTidakView({super.key, this.data});
  final KaryawanTidak? data;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<CreateKttController>()) {
      Get.lazyPut(() => CreateKttController());
    }

    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Buat karyawan tidak tetap",
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
              maxLines: 5,
              hint: 'Nama karyawan',
              model: forms.key('name'),
            ),
            LzForm.input(
              label: 'NIK',
              maxLines: 5,
              hint: 'Nik karyawan',
              model: forms.key('nik'),
            ),
            Row(
              children: [
                Flexible(
                  child: LzForm.select(
                      label: 'regional',
                      hint: 'Pilih regional',
                      model: controller.forms.key('regional'),
                      onTap: () async {
                        final data = await controller.getRegional().overlay();
                        controller.forms
                            .set('regional')
                            .options(data.labelValue('name'));
                      }),
                ),
                const SizedBox(width: 16),
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
                  child: LzForm.input(
                      label: 'Tanggal Lahir',
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
                const SizedBox(width: 16),
                Flexible(
                  child: LzForm.input(
                    label: 'Tempat Lahir',
                    hint: 'Tempat lahir',
                    maxLines: 5,
                    model: forms.key('tempat_lahir'),
                  ),
                ),
              ],
            ),
            LzForm.input(
                label: 'No Telepon',
                model: forms.key('no_telp'),
                hint: 'Nomor telepon'),
            Row(
              children: [
                Flexible(
                  child: LzForm.input(
                    label: 'Alamat Domisili',
                    hint: 'Alamat domisili karyawan',
                    model: forms.key('alamat_domisili'),
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: LzForm.input(
                    label: 'Alamat KTP',
                    hint: 'Alamat KTP karyawan',
                    model: forms.key('alamat_ktp'),
                  ),
                ),
              ],
            ),
            LzForm.select(
              label: 'Status kawin',
              hint: 'Status kawin',
              model: forms.key('status_kawin_id'),
              onTap: () => controller.openStatusKawin(),
            ),
            Row(
              children: [
                Flexible(
                  child: LzForm.input(
                      label: 'Tgl bergabung',
                      hint: 'Format : Y-m-d',
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
                16.width,
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
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: LzForm.select(
                    label: 'Pilih jabatan',
                    hint: 'Klik untuk Jabatan',
                    model: forms.key('role_id'),
                    onTap: () => controller.openRole(),
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: LzForm.select(
                    label: 'Pilih Departemen',
                    hint: 'Klik untuk Departemen',
                    model: forms.key('dep_id'),
                    onTap: () => controller.openDep(),
                  ),
                ),
              ],
            ),
            LzButton(
              text: data == null ? 'Submit' : 'Update',
              onTap: () {
                controller.onSubmit(data?.id);
                logg('Tombol ditekan');

                final payload = controller.forms.value;
                payload['status_kawin_id'] =
                    controller.forms.extra('status_kawin_id');
                payload['role_id'] = controller.forms.extra('role_id');
                payload['dep_id'] = controller.forms.extra('dep_id');

                logg(payload); // ✅ sudah benar dan bersih
              },
            ).margin(all: 20),
          ],
        ));
  }
}
