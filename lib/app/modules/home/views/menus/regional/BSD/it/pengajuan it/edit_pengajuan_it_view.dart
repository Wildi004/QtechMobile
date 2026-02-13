import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/pengajuan_it/pengajuan_it.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Pengajuan%20It/edit_pengajuan_it_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/icon_action_widget.dart';

class EditPengajuanItView extends GetView<EditPengajuanItController> {
  final PengajuanIt? data;

  const EditPengajuanItView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditPengajuanItController());

    String formatRupiah(num? value) {
      if (value == null) return '-';
      return NumberFormat.currency(
              locale: 'id', symbol: 'Rp ', decimalDigits: 0)
          .format(value);
    }

    final forms = controller.forms;

    if (data != null) {
      Future.microtask(() => controller.setData(data!));
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Form Pengajuan',
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
                  spacing: 25,
                  children: [
                    LzForm.input(
                      label: 'No. Pengajuan',
                      enabled: false,
                      model: forms.key('no_pengajuan'),
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          hint: 'Tanggal Pengajuan',
                          label: 'Tanggal',
                          model: forms.key('tgl_pengajuan'),
                          suffixIcon: Hi.calendar02,
                          onTap: () {
                            LzPicker.date(
                              context,
                              initDate: forms.get('tgl_pengajuan').toDate(),
                              onSelect: (date) {
                                forms.set('tgl_pengajuan', date.format());
                              },
                            );
                          },
                        ),
                        LzForm.input(
                          label: 'Departemen',
                          enabled: false,
                          model: forms.key('dep_name'),
                        ),
                      ],
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
                    Widget dynamicInput(String type) {
                      if (type == 'None') {
                        return LzForm.input(
                            label: 'Nama Item',
                            hint: 'Ketik nama item',
                            model: forms.key('nama_item'));
                      }

                      final options = controller.dataRabDetails
                          .map((e) => e.namaItem ?? '')
                          .toList();
                      final values =
                          controller.dataRab.map((e) => e.id ?? '').toList();

                      return LzForm.select(
                          label: 'Pilih Item',
                          hint: 'Pilih item rab',
                          style:
                              OptionPickerStyle(maxLines: 3, withSearch: true),
                          options: options,
                          values: values,
                          model: forms.key('nama_item'),
                          onChange: (value) => controller.setUnit(value, i));
                    }

                    String type = controller.types[i];

                    return Column(
                      crossAxisAlignment: Caa.start,
                      children: [
                        Text('Data ${controller.formRabs.length - i}',
                            style: Gfont.bold.copyWith(fontSize: 16)),
                        LzCard(
                          gap: 10,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: LzForm.radio(
                                    label: 'Pilih RAB',
                                    options: ['None', 'RAB'],
                                    model: forms.key('type'),
                                    onChange: (value) =>
                                        controller.getRab(value, i),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => controller.removeRab(i),
                                  icon: Icon(Hi.cancel02, color: Colors.red),
                                ),
                              ],
                            ),

                            // input or select option
                            dynamicInput(type),

                            // unit
                            LzForm.input(
                                label: 'Satuan',
                                hint: 'Masukkan satuan',
                                model: forms.key('satuan'),
                                keyboard: Tit.number,
                                maxLength: 11,
                                formatters: [Formatter.currency()],
                                onChange: (value) => controller.countTotal(i),
                                enabled: type == 'None'),
                            Intrinsic(
                              gap: 10,
                              children: [
                                LzForm.input(
                                    label: 'Jumlah',
                                    hint: 'Masukkan jumlah',
                                    model: forms.key('jumlah'),
                                    keyboard: Tit.number,
                                    formatters: [Formatter.currency()],
                                    maxLength: 11,
                                    onChange: (value) =>
                                        controller.countTotal(i)),
                                LzForm.input(
                                    label: 'Total',
                                    hint: '0',
                                    model: forms.key('total'),
                                    enabled: false)
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              )),
              Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                child: Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Pengajuan dana :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(formatRupiah(controller.grandTotal.value)),
                    ],
                  );
                }),
              ),
            ],
          );
        }),
      ),
    );
  }
}
