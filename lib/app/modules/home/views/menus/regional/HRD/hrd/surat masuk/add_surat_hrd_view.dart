import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/arsip_lamaran.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/surat_menyurat_controller/surat%20menyurat%20hrd/add_surat_hrd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class AddSuratHrdView extends GetView<AddSuratHrdController> {
  final ArsipLamaran? data;
  const AddSuratHrdView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddSuratHrdController());
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Silakan pilih departemen'),
              TextButton(
                onPressed: () {
                  final allIds =
                      controller.departemenList.map((d) => d.id!).toList();
                  if (controller.selectedDepIds.length == allIds.length) {
                    controller.selectedDepIds.clear();
                  } else {
                    controller.selectedDepIds.value = allIds;
                  }
                },
                child: Obx(() {
                  final allIds =
                      controller.departemenList.map((d) => d.id!).toList();
                  final isAllSelected =
                      controller.selectedDepIds.length == allIds.length;
                  return Text(isAllSelected ? 'Batal Semua' : 'Pilih Semua');
                }),
              ),
            ],
          ),

          Obx(() => Wrap(
                spacing: 10,
                runSpacing: 10,
                children: controller.departemenList.map((dep) {
                  final isSelected = controller.selectedDepIds.contains(dep.id);
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: isSelected,
                        onChanged: (val) {
                          if (val == true) {
                            controller.selectedDepIds.add(dep.id!);
                          } else {
                            controller.selectedDepIds.remove(dep.id);
                          }
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          if (isSelected) {
                            controller.selectedDepIds.remove(dep.id);
                          } else {
                            controller.selectedDepIds.add(dep.id!);
                          }
                        },
                        child: Text(
                          dep.departemen ?? '-',
                          style: TextStyle(
                            color: isSelected ? Colors.blue : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              )),

          // Bagian input file
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
