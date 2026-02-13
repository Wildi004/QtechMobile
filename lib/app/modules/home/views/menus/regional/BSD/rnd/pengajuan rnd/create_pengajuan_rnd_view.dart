import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/RND/Pengajuan%20RND/create_pengajuan_rnd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/icon_action_widget.dart';

class CreatePengajuanRndView extends GetView<CreatePengajuanRndController> {
  const CreatePengajuanRndView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreatePengajuanRndController());

    final forms = controller.forms;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Form Pengajuan RND',
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
                      model: forms.key('no_pengajuan')),
                  Intrinsic(
                    gap: 10,
                    children: [
                      LzForm.input(
                          label: 'Tanggal Pengajuan',
                          enabled: false,
                          model: forms.key('tgl_pengajuan')),
                      LzForm.input(
                          label: 'Departemen',
                          enabled: false,
                          model: forms.key('dep_name')),
                    ],
                  ),
                ],
              ),
            ),

            // dynamic list
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
                        style: OptionPickerStyle(maxLines: 3, withSearch: true),
                        options: options,
                        values: values,
                        model: forms.key('nama_item'),
                        onChange: (value) => controller.setUnit(value, i));
                  }

                  String type = controller.types[i];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LzCard(
                        color: Colors.white,
                        gap: 10,
                        children: [
                          Text('Data ${controller.formRabs.length - i}',
                              style: Gfont.bold.copyWith(fontSize: 16)),
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
                              label: 'Harga Satuan',
                              hint: 'Masukkan Harga Satuan',
                              model: forms.key('satuan'),
                              keyboard: Tit.number,
                              maxLength: 11,
                              formatters: [Formatter.currency()],
                              enabled: type == 'None'),
                          Intrinsic(
                            gap: 10,
                            children: [
                              LzForm.input(
                                  label: 'Qty',
                                  hint: 'Masukkan Qty',
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
                          // jumlah

                          // total
                        ],
                      ),
                    ],
                  );
                }),
              ),
            )),
          ],
        );
      }),
      bottomNavigationBar: Container(
        padding: Ei.all(20),
        decoration: BoxDecoration(border: Br.only(['t'])),
        child: Row(
          children: [
            Text('Grand Total', style: Gfont.bold),
            Obx(() => Text(controller.grandTotal.value.currency(prefix: 'Rp'),
                style: Gfont.bold))
          ],
        ).between,
      ),
    );
  }
}
