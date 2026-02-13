import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/modal_logistik.dart';
import 'package:qrm_dev/app/modules/harga_modal_logistik/controllers/form_harga_modal_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class FormHargaModalView extends GetView<FormHargaModalController> {
  final ModalLogistik? data;

  const FormHargaModalView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormHargaModalController());
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Buat Harga Modal Logistik',
        actions: [
          IconButton(
              onPressed: () {
                controller.onSubmit(data?.id);
              },
              icon: Icon(Hi.tick03))
        ],
      ).appBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LzListView(
          gap: 10,
          autoCache: true, // set true, jika inputannya ada banyak
          children: [
            LzForm.input(
                label: 'Kode Material',
                hint: 'Masukan Kode Material',
                model: forms.key('kode_material')),
            LzForm.input(
                label: 'Nama',
                hint: 'Masukan Nama Material',
                model: forms.key('nama')),
            Intrinsic(gap: 10, children: [
              LzForm.input(
                  hint: 'Inputkan tanggal',
                  label: 'Tanggal input',
                  model: forms.key('tgl_input'),
                  suffixIcon: Hi.calendar02,
                  onTap: () {
                    LzPicker.date(context,
                        initDate: forms.get('tgl_input').toDate(),
                        onSelect: (date) {
                      forms.set('tgl_input', date.format());
                    });
                  }),
              LzForm.input(
                  hint: 'Inputkan tanggal',
                  label: 'Tanggal Upload',
                  model: forms.key('tgl_berlaku'),
                  suffixIcon: Hi.calendar02,
                  onTap: () {
                    LzPicker.date(context,
                        initDate: forms.get('tgl_berlaku').toDate(),
                        onSelect: (date) {
                      forms.set('tgl_berlaku', date.format());
                    });
                  }),
            ]),
            Intrinsic(gap: 10, children: [
              LzForm.input(
                label: 'Qty',
                hint: 'Maukan Qty',
                formatters: [Formatter.currency()],
                keyboard: Tit.number,
                model: forms.key('qty'),
              ),
              LzForm.select(
                label: 'satuan',
                style: OptionPickerStyle(withSearch: true),
                hint: 'Pilih Satuan',
                model: controller.forms.key('satuan'),
                onTap: () async {
                  final data = await controller.getSatuan().overlay();
                  controller.forms
                      .set('satuan')
                      .options(data.labelValue('name'));
                },
              ),
            ]),
            Intrinsic(gap: 10, children: [
              LzForm.input(
                label: 'Harga Satuan',
                hint: 'Masukan Harga Satuan',
                onChange: (v) => controller.hitungOtomatis(),
                formatters: [Formatter.currency()],
                keyboard: Tit.number,
                model: forms.key('harga_satuan'),
              ),
              LzForm.input(
                label: 'Harga Diskon',
                hint: 'Masukan Harga Diskon',
                formatters: [Formatter.currency()],
                keyboard: Tit.number,
                onChange: (v) => controller.hitungOtomatis(),
                model: forms.key('harga_diskon'),
              ),
            ]),
            Row(
              children: [
                Expanded(
                    child: LzForm.input(
                  label: 'PPN',
                  hint: 'Masukan PPN',
                  formatters: [Formatter.currency()],
                  keyboard: Tit.number,
                  onChange: (v) => controller.hitungOtomatis(),
                  model: forms.key('ppn'),
                )),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: LzForm.input(
                  label: 'Total PPN',
                  formatters: [Formatter.currency()],
                  keyboard: Tit.number,
                  onChange: (v) => controller.hitungOtomatis(),
                  hint: 'Masukan Total PPN',
                  model: forms.key('total_ppn'),
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: LzForm.input(
                  label: 'Sub Total',
                  formatters: [Formatter.currency()],
                  keyboard: Tit.number,
                  hint: 'Masukan Sub Total',
                  model: forms.key('sub_total'),
                )),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: LzForm.input(
                  label: 'Ongkir',
                  hint: 'Masukan Ongkir',
                  formatters: [Formatter.currency()],
                  keyboard: Tit.number,
                  onChange: (v) => controller.hitungOtomatis(),
                  model: forms.key('ongkir'),
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: LzForm.input(
                  label: 'Harga Modal',
                  hint: 'Masukan Harga Modal',
                  formatters: [Formatter.currency()],
                  keyboard: Tit.number,
                  onChange: (v) => controller.hitungOtomatis(),
                  model: forms.key('harga_modal'),
                )),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: LzForm.select(
                    style: OptionPickerStyle(withSearch: true),
                    label: 'Pilih Supplier',
                    hint: 'Klik untuk memilih Supplier',
                    model: forms.key('supplier'),
                    onTap: () => controller.openSupplier(),
                  ),
                ),
              ],
            ),
            LzForm.input(
                label: 'Lokasi',
                hint: 'Masukan Lokasi',
                model: forms.key('lokasi'),
                maxLines: 4),
            LzForm.input(
                label: 'Keterangan',
                hint: 'Keterangan',
                model: forms.key('keterangan'),
                maxLines: 99),
          ],
        ),
      ),
    );
  }
}
