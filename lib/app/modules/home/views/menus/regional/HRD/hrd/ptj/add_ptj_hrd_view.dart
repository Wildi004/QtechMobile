import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_ptj_controller/form_ptj_hrd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/icon_action_widget.dart';
import 'package:qrm_dev/app/widgets/image_picker.dart';

class AddPtjHrdView extends GetView<FormPtjHrdController> {
  final String type;
  const AddPtjHrdView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormPtjHrdController(type));

    final forms = controller.forms;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (!controller.isSubmitted.value && controller.created != null) {
          await controller.deletePtj(controller.created!.noHide!);
        }
      },
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Form PTJ',
          actions: [
            IconAction(Hi.tick04, onTap: () {
              controller.onSubmit();
            }),
          ],
        ).appBar,
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
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
                        label: 'No. PTJ',
                        enabled: false,
                        model: forms.key('no_ptj')),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                            label: 'Tanggal PTJ',
                            enabled: false,
                            model: forms.key('tgl_ptj')),
                        LzForm.input(
                            label: 'Departemen',
                            enabled: false,
                            model: forms.key('dep_name')),
                      ],
                    ),
                    LzForm.input(
                        label: 'Type',
                        enabled: false,
                        model: forms.key('type')),
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () => LzListView(
                    gap: 20,
                    autoCache: true,
                    children: controller.formPengajuan.generate((forms, i) {
                      return LzCard(
                        gap: 10,
                        children: [
                          LzForm.select(
                            label: 'Pilih Item',
                            hint: 'Pilih item',
                            style: OptionPickerStyle(
                                maxLines: 3, withSearch: true),
                            options: controller.dataPengajuanDetails
                                .map((e) => e.namaBarang ?? '')
                                .toList(),
                            values: controller.dataPengajuanDetails
                                .map((e) => e.id ?? '')
                                .toList(),
                            model: forms.key('nama_barang'),
                            onChange: (value) => controller.setUnit(value, i),
                          ),
                          Intrinsic(
                            gap: 10,
                            children: [
                              LzForm.input(
                                label: 'Tanggal Beli',
                                hint: 'Tanggal Beli',
                                model: forms.key('tgl_beli'),
                                suffixIcon: Hi.calendar02,
                                onTap: () {
                                  LzPicker.date(context,
                                      minDate: DateTime(1900),
                                      initDate: forms.get('tgl_beli').toDate(),
                                      onSelect: (date) {
                                    forms.set('tgl_beli', date.format());
                                  });
                                },
                              ),
                              LzForm.input(
                                label: 'Pilih Nota',
                                hint: 'Pilih gambar',
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
                            ],
                          ),
                          Intrinsic(
                            gap: 10,
                            children: [
                              LzForm.input(
                                label: 'Jumlah',
                                hint: 'Masukkan jumlah',
                                model: forms.key('qty'),
                                keyboard: Tit.number,
                                maxLength: 11,
                                formatters: [Formatter.currency()],
                                onChange: (value) => controller.countTotal(i),
                              ),
                              LzForm.input(
                                label: 'Harga Satuan',
                                hint: 'Masukkan harga satuan',
                                model: forms.key('harga_satuan'),
                                keyboard: Tit.number,
                                maxLength: 11,
                                formatters: [Formatter.currency()],
                                enabled: false,
                              ),
                            ],
                          ),
                          LzForm.input(
                            label: 'Total',
                            hint: '0',
                            model: forms.key('total'),
                            enabled: false,
                          ),
                          Obx(() => controller.fileName.value.isEmpty
                              ? const None()
                              : Column(children: [
                                  LzImage(controller.file, size: 100),
                                ]).start),
                        ],
                      );
                    }),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
