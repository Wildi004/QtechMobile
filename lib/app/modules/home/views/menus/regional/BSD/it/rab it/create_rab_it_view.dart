import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Rab%20IT/create_rab_it_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/icon_action_widget.dart';

class CreateRabItView extends GetView<CreateRabItController> {
  const CreateRabItView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateRabItController());
    final forms = controller.forms;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        appBar: CustomAppbar(
          title: 'Form RAB',
          actions: [
            IconAction(Hi.add01, onTap: () {
              controller.addRab();
            }),
            IconAction(Hi.tick04, onTap: () {
              controller.onSubmit();
            }),
          ],
        ).appBar,
        body: Obx(() {
          bool loading = controller.isLoading.value;

          if (loading) {
            return CustomLoading();
          }

          return Column(
            children: [
              Container(
                padding: Ei.all(20),
                decoration: BoxDecoration(border: Br.only(['b'])),
                child: Column(
                  spacing: 15,
                  children: [
                    LzForm.input(
                      label: 'Periode',
                      hint: 'Periode',
                      model: forms.key('periode'),
                      suffixIcon: Hi.calendar02,
                      onTap: () {
                        LzPicker.date(context,
                            minDate: DateTime(1900),
                            initDate: forms.get('periode').toDate(),
                            onSelect: (date) {
                          forms.set('periode', date.format());
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(child: Obx(
                () {
                  if (controller.formRabs.isEmpty) {
                    return Center(child: Text("Belum ada item RAB"));
                  }
                  return LzListView(
                    gap: 20,
                    autoCache: true,
                    children: controller.formRabs.generate((forms, i) {
                      return LzCard(
                        gap: 10,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () => controller.removeRab(i),
                                icon: Icon(Hi.cancel02, color: Colors.red),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: LzForm.select(
                                  label: 'Minggu ke',
                                  style: OptionPickerStyle(withSearch: true),
                                  hint: 'Pilih Minggu',
                                  model:
                                      controller.formRabs[i].key('minggu_ke'),
                                  onTap: () async {
                                    final data =
                                        await controller.getMinggu().overlay();
                                    controller.formRabs[i]
                                        .set('minggu_ke')
                                        .options(
                                            data.labelValue('minggu_ke', 'id'));
                                  },
                                  onChange: (val) {
                                    controller.formRabs[i].set(
                                        'minggu_ke', int.tryParse(val) ?? 0);
                                  },
                                ),
                              ),
                              10.width,
                              Expanded(
                                child: LzForm.select(
                                  label: 'Kategori RAB',
                                  style: OptionPickerStyle(withSearch: true),
                                  hint: 'Pilih Kategori',
                                  model: controller.formRabs[i]
                                      .key('kategori_rab'),
                                  onTap: () => controller.openKategori(i),
                                  onChange: (val) {
                                    forms.set(
                                        'kategori_rab', int.tryParse(val) ?? 0);
                                    controller.openSelecKat(i);
                                  },
                                ),
                              ),
                            ],
                          ),

                          LzForm.input(
                            label: 'Nama Item',
                            maxLines: 11,
                            hint: 'Ketik nama item',
                            model: controller.formRabs[i].key('nama_item'),
                          ),

                          LzForm.input(
                            label: 'Total',
                            hint: 'Masukkan total',
                            model: controller.formRabs[i].key('total'),
                            keyboard: Tit.number,
                            formatters: [Formatter.currency()],
                            maxLength: 11,
                            onChange: (value) => controller.countSubTotal(i),
                          ),

                          // Overheat & Sub Total
                          Intrinsic(
                            gap: 10,
                            children: [
                              LzForm.input(
                                label: 'Overheat (%)',
                                hint: 'Masukkan overheat',
                                model: controller.formRabs[i].key('overheat'),
                                keyboard: Tit.number,
                                maxLength: 11,
                                onChange: (value) =>
                                    controller.countSubTotal(i),
                              ),
                              LzForm.input(
                                label: 'Sub Total',
                                hint: 'Hasil subtotal',
                                readOnly: true,
                                model: controller.formRabs[i].key('sub_total'),
                              ),
                            ],
                          ),

                          LzForm.input(
                            label: 'Catatan',
                            hint: 'Tulis catatan',
                            model: controller.formRabs[i].key('catatan'),
                          ),
                        ],
                      );
                    }),
                  );
                },
              )),
            ],
          );
        }),
        bottomNavigationBar: Container(
          padding: Ei.all(20),
          decoration:
              BoxDecoration(color: Colors.white, border: Br.only(['t'])),
          child: Row(
            children: [
              Text('Grand Total', style: Gfont.bold),
              Obx(() => Text(controller.grandTotal.value.currency(prefix: 'Rp'),
                  style: Gfont.bold))
            ],
          ).between,
        ),
      ),
    );
  }
}
