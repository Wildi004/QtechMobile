import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/rab_logistik/rab_logistik.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Rab%20logistik/edit_rab_logistik_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/icon_action_widget.dart';

class EditRabLogistikView extends GetView<EditRabLogistikController> {
  final RabLogistik? data;

  const EditRabLogistikView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.put(EditRabLogistikController()..data = data);

    final forms = controller.forms;
    String formatRupiah(num? value) {
      if (value == null) return '-';
      return NumberFormat.currency(
              locale: 'id', symbol: 'Rp ', decimalDigits: 0)
          .format(value);
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        appBar: CustomAppbar(
          title: ' Edit RAB',
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
                  spacing: 10,
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
              Expanded(
                  child: Obx(
                () => LzListView(
                  gap: 20,
                  autoCache: true,
                  children: controller.formRabs.generate((forms, i) {
                    return LzCard(
                      gap: 10,
                      children: [
                        Text('Data ${controller.formRabs.length - i}',
                            style: Gfont.bold.copyWith(fontSize: 16)),
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
                                model: controller.formRabs[i].key('minggu_ke'),
                                onTap: () async {
                                  final data =
                                      await controller.getMinggu().overlay();
                                  controller.formRabs[i]
                                      .set('minggu_ke')
                                      .options(
                                          data.labelValue('minggu_ke', 'id'));
                                },
                                onChange: (val) {
                                  controller.formRabs[i]
                                      .set('minggu_ke', int.tryParse(val) ?? 0);
                                },
                              ),
                            ),
                            10.width,
                            Expanded(
                              child: LzForm.select(
                                label: 'Kategori RAB',
                                hint: 'Pilih Kategori',
                                style: OptionPickerStyle(withSearch: true),
                                model:
                                    controller.formRabs[i].key('kategori_rab'),
                                onTap: () => controller.openKategori(i),
                                onChange: (opt) =>
                                    controller.onChangeRab(opt, i),
                              ),
                            ),
                          ],
                        ),
                        LzForm.input(
                          label: 'Nama Item',
                          hint: 'Ketik nama item',
                          model: controller.formRabs[i].key('nama_item'),
                        ),
                        Intrinsic(
                          gap: 10,
                          children: [
                            LzForm.input(
                              label: 'Total',
                              hint: 'Masukkan total',
                              model: controller.formRabs[i].key('total'),
                              keyboard: Tit.number,
                              formatters: [Formatter.currency()],
                              maxLength: 11,
                              onChange: (value) => controller.countSubTotal(i),
                            ),
                          ],
                        ),
                        Intrinsic(
                          gap: 10,
                          children: [
                            LzForm.input(
                              label: 'Overheat (%)',
                              hint: 'Masukkan overheat',
                              model: controller.formRabs[i].key('overheat'),
                              keyboard: Tit.number,
                              formatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              maxLength: 11,
                              onChange: (value) => controller.countSubTotal(i),
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
                ),
              )),
              Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                color: Colors.white,
                child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Pengajuan dana :',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(formatRupiah(controller.grandTotal.value))
                      ],
                    )),
              )
            ],
          );
        }),
      ),
    );
  }
}
