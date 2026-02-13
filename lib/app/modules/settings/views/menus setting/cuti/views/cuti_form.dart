import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/hrd_cuti.dart';
import 'package:qrm_dev/app/modules/settings/views/menus%20setting/cuti/controllers/form_cuti_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CutiForm extends GetView<FormCutiController> {
  final HrdCuti? data;
  const CutiForm({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormCutiController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Pengajuan Cuti',
        actions: [
          IconButton(
            onPressed: () {
              logg('🔹 [LOG] Tombol submit ditekan.');
              controller.onSubmit(data?.id);
            },
            icon: Icon(Hi.tick04),
          ),
        ],
      ).appBar,
      body: LzListView(
        gap: 20,
        children: [
          LzForm.input(
            maxLines: 99,
            hint: 'Nama',
            model: forms.key('name'),
            label: 'Nama',
            enabled: false,
          ),
          LzForm.input(
            hint: 'Tanggal Pengajuan',
            label: 'Tanggal Pengajuan',
            model: forms.key('tgl_cuti'),
            suffixIcon: Hi.calendar02,
            onTap: () {
              LzPicker.date(
                context,
                minDate: DateTime(1900),
                initDate: forms.get('tgl_cuti').toDate(),
                onSelect: (date) {
                  forms.set('tgl_cuti', date.format('yyyy-MM-dd HH:mm:ss'));
                },
              );
            },
          ),
          LzForm.input(
            maxLines: 99,
            hint: 'NIK',
            model: forms.key('no_ktp'),
            enabled: false,
            label: 'NIK',
          ),
          LzForm.input(
            maxLines: 99,
            hint: 'Departemen',
            label: 'Departemen',
            enabled: false,
            model: forms.key('dept'),
          ),
          LzForm.input(
            maxLines: 99,
            hint: 'Jabatan',
            enabled: false,
            model: forms.key('role'),
            label: 'Jabatan',
          ),
          Intrinsic(gap: 10, children: [
            LzForm.input(
              hint: 'Dari Tanggal',
              label: 'Dari Tanggal',
              suffixIcon: Hi.calendar02,
              model: forms.key('cuti_from'),
              onTap: () {
                LzPicker.date(
                  context,
                  minDate: DateTime(1900),
                  initDate: forms.get('cuti_from').toDate(),
                  onSelect: (date) {
                    forms.set('cuti_from', date.format('yyyy-MM-dd'));
                  },
                );
              },
            ),
            LzForm.input(
              hint: 'Sampai Tanggal',
              label: 'Sampai Tanggal',
              suffixIcon: Hi.calendar02,
              model: forms.key('cuti_to'),
              onTap: () {
                LzPicker.date(
                  context,
                  minDate: DateTime(1900),
                  initDate: forms.get('cuti_to').toDate(),
                  onSelect: (date) {
                    forms.set('cuti_to', date.format('yyyy-MM-dd'));
                  },
                );
              },
            ),
          ]),
          LzForm.input(
            maxLines: 99,
            hint: 'Perihal',
            label: 'Perihal',
            model: forms.key('perihal'),
          ),
          LzForm.input(
            maxLines: 99,
            hint: 'Keterangan Cuti',
            label: 'Keterangan Cuti',
            model: forms.key('keterangan'),
          ),
        ],
      ),
    );
  }
}
