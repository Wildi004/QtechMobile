import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_pengajuan_controller/form_pengajuan_controller.dart';
import 'package:qrm/app/widgets/custom_appbar_widget.dart';
import 'package:qrm/app/widgets/icon_action_widget.dart';

class FormPengajuanHrdView extends GetView<FormPengajuanController> {
  const FormPengajuanHrdView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormPengajuanController()); // init

    final forms = controller.forms;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
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
          return LzLoader.bar();
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
                        options: options,
                        values: values,
                        model: forms.key('nama_item'),
                        onChange: (value) => controller.setUnit(value, i));
                  }

                  String type = controller.types[i];

                  return LzCard(
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
                              onChange: (value) => controller.getRab(value, i),
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
                              onChange: (value) => controller.countTotal(i)),
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
                  );
                }),
              ),
            )),
          ],
        );
      }),
      bottomNavigationBar: Container(
        padding: Ei.all(20),
        decoration: BoxDecoration(color: Colors.white, border: Br.only(['t'])),
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
