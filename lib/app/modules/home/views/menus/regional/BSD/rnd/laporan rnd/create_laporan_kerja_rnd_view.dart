import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/RND/Laporan%20Kerja%20RND/create_laporan_kerja_rnd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreateLaporanKerjaRndView
    extends GetView<CreateLaporanKerjaRndController> {
  const CreateLaporanKerjaRndView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateLaporanKerjaRndController());

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Form Laporan Kerja RND',
        actions: [
          IconButton(onPressed: controller.addCard, icon: Icon(Hi.add01)),
          IconButton(
              onPressed: () {
                controller.onSubmit();
              },
              icon: Icon(Hi.tick04)),
        ],
      ).appBar,
      body: Obx(() {
        return AnimatedList(
          key: controller.listKey,
          initialItemCount: controller.cards.length,
          itemBuilder: (context, index, animation) {
            final nomorData = controller.cards.length - index;
            final form = controller.formRk[index];

            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: ScaleTransition(
                scale: animation,
                child: LzCard(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Data $nomorData',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        IconButton(
                          icon: Icon(Hi.cancel02),
                          onPressed: () => controller.removeCard(index),
                        ),
                      ],
                    ),
                    LzForm.input(
                      label: 'Masukan Nama Pekerjaan',
                      hint: 'Nama Pekerjaan',
                      maxLines: 3,
                      model: form.key('nama_pekerjaan'),
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.select(
                            hint: 'Prioritas',
                            style: OptionPickerStyle(withSearch: true),
                            label: 'Pilih Prioritas',
                            model: form.key('prioritas'),
                            onTap: () async {
                              final data =
                                  await controller.getPrioritas().overlay();
                              form
                                  .set('prioritas')
                                  .options(data.labelValue('name', 'id'));
                            },
                            onChange: (value) =>
                                controller.onChange(index, 'priority')),
                        LzForm.select(
                            hint: 'Status',
                            style: OptionPickerStyle(withSearch: true),
                            label: 'Pilih Status',
                            model: form.key('status'),
                            onTap: () async {
                              final data =
                                  await controller.getStatus().overlay();
                              form
                                  .set('status')
                                  .options(data.labelValue('name', 'id'));
                            },
                            onChange: (value) =>
                                controller.onChange(index, 'status')),
                      ],
                    ),
                    LzForm.select(
                      hint: 'Kategori KPI',
                      label: 'Masukan Kategori KPI',
                      model: form.key('kategori'),
                      style: OptionPickerStyle(maxLines: 3, withSearch: true),
                      onTap: () async {
                        final options = await controller.getCategoryOptions();
                        form.set('kategori').options(options);
                      },
                      onChange: (value) async {
                        // value = keterangan kategori (sesuai getCategoryOptions)
                        final subOptions =
                            await controller.getSubCategoryOptions(value);
                        form.set('sub_kategori').options(subOptions);

                        // Auto-pilih item pertama biar pasti ada ID
                        // if (subOptions.isNotEmpty) {
                        //   final first = subOptions.first;
                        //   form.set('sub_kategori',
                        //       Option(first['label']!, value: first['value']));
                        // } else {
                        //   form.set('sub_kategori', null);
                        // }
                      },
                    ),
                    LzForm.select(
                        hint: 'Sub Kategori KPI',
                        label: 'Masukan Sub Kategori KPI',
                        style: OptionPickerStyle(maxLines: 3, withSearch: true),
                        model: form.key('sub_kategori'),
                        onChange: (value) =>
                            controller.onChange(index, 'category')),
                    LzForm.input(
                      label: 'Masukan Keterangan',
                      hint: 'Keterangan',
                      maxLines: 99,
                      model: form.key('keterangan'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
