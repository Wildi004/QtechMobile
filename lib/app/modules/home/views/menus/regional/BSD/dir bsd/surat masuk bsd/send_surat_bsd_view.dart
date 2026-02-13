import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/surat_masuk/surat_masuk.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/surat%20menyurat%20Bsd/send_surat_bsd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/surat%20masuk/penerima_surat_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class SendSuratBsdView extends GetView<SendSuratBsdController> {
  final SuratMasuk? data;
  const SendSuratBsdView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SendSuratBsdController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Form Surat Keluar',
        actions: [
          IconButton(
            onPressed: () {
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
            hint: 'Perihal Surat',
            label: 'Surat',
            model: forms.key('perihal'),
          ),
          Intrinsic(
            gap: 10,
            children: [
              LzForm.select(
                label: 'Sifat',
                style: OptionPickerStyle(withSearch: true),
                hint: 'Pilih sifat',
                model: controller.forms.key('sifat'),
                onTap: () async {
                  final data = await controller.getSifat().overlay();
                  controller.forms
                      .set('sifat')
                      .options(data.labelValue('name'));
                },
              ),
              LzForm.input(
                hint: 'Tanggal Surat',
                label: 'Tanggal Surat',
                model: forms.key('tgl_surat'),
                suffixIcon: Hi.calendar02,
                onTap: () {
                  LzPicker.date(
                    context,
                    initDate: forms.get('tgl_surat').toDate(),
                    onSelect: (date) {
                      forms.set('tgl_surat', date.format());
                    },
                  );
                },
              ),
            ],
          ),
          LzForm.input(
            hint: 'Keterangan Surat',
            label: 'Keterangan Surat',
            maxLines: 99,
            model: forms.key('keterangan'),
          ),
          Row(
            children: [
              Touch(
                onTap: () => Get.to(() => PenerimaSuratView()),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFFAC7823),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Penerima +', style: Gfont.white),
                    )),
              )
            ],
          ).between,
          LzForm.input(
            hint: 'File/Surat',
            label: 'File/Surat',
            model: forms.key('image'),
            suffixIcon: Hi.image01,
            onTap: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.any,
              );
              if (result != null && result.files.isNotEmpty) {
                final path = result.files.single.path!;
                forms.set('image', path);
                controller.fileName.value = path;
                controller.file = File(path);
              }
            },
          ),
          Obx(() => controller.fileName.value.isEmpty
              ? const None()
              : Column(
                  children: [
                    LzImage(controller.file, size: 100),
                  ],
                ).start),
        ],
      ),
    );
  }
}
