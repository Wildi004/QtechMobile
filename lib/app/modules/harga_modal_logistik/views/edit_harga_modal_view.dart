import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/modal_logistik.dart';
import 'package:qrm_dev/app/modules/harga_modal_logistik/controllers/edit_harga_modal_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class EditHargaModalView extends GetView<EditHargaModalController> {
  final ModalLogistik? data;
  const EditHargaModalView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EditHargaModalController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.getDetailData(data!.id!);
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Edit Harga Modal',
        actions: [
          IconButton(
              onPressed: () {
                controller.onSubmit(data?.id);
              },
              icon: Icon(Hi.tick03))
        ],
      ).appBar,
      body: LzListView(
        gap: 25,
        children: [
          // Kode Material
          LzForm.input(
            hint: 'Inputkan Kode Material',
            label: 'Kode Material',
            model: forms.key('kode_material'),
          ),

          // Nama
          LzForm.input(
            hint: 'Inputkan Nama Material',
            label: 'Nama',
            model: forms.key('nama'),
          ),

          // Tanggal Berlaku
          LzForm.input(
            label: 'Tanggal Berlaku',
            hint: 'Format: YYYY-MM-DD',
            model: forms.key('tgl_berlaku'),
            suffixIcon: Hi.calendar02,
            onTap: () {
              LzPicker.date(context,
                  minDate: DateTime(1900),
                  initDate: forms.get('tgl_berlaku').toDate(),
                  onSelect: (date) {
                forms.set('tgl_berlaku', date.format());
              });
            },
          ),

          // Qty
          Intrinsic(
            gap: 10,
            children: [
              LzForm.input(
                hint: 'Masukkan Quantity',
                onChange: (v) => controller.hitungOtomatis(),
                label: 'Qty',
                keyboard: Tit.number,
                formatters: [Formatter.currency()],
                model: forms.key('qty'),
              ),
              LzForm.input(
                hint: 'Masukkan ID Satuan',
                label: 'Satuan',
                model: forms.key('satuan'),
              ),
            ],
          ),

          // Satuan

          // Harga Satuan
          Intrinsic(
            gap: 10,
            children: [
              LzForm.input(
                hint: 'Masukkan Harga Satuan',
                label: 'Harga Satuan',
                keyboard: Tit.number,
                onChange: (v) => controller.hitungOtomatis(),
                formatters: [Formatter.currency()],
                model: forms.key('harga_satuan'),
              ),
              LzForm.input(
                hint: 'Masukkan Harga Diskon',
                label: 'Harga Diskon',
                keyboard: Tit.number,
                formatters: [Formatter.currency()],
                onChange: (v) => controller.hitungOtomatis(),
                model: forms.key('harga_diskon'),
              ),
            ],
          ),

          // Harga Diskon

          // PPN
          Intrinsic(
            gap: 10,
            children: [
              LzForm.input(
                hint: 'Masukkan Nilai PPN',
                label: 'PPN',
                keyboard: Tit.number,
                formatters: [Formatter.currency()],
                onChange: (v) => controller.hitungOtomatis(),
                model: forms.key('ppn'),
              ),
              LzForm.input(
                hint: 'Masukkan Total PPN',
                label: 'Total PPN',
                keyboard: Tit.number,
                formatters: [Formatter.currency()],
                onChange: (v) => controller.hitungOtomatis(),
                model: forms.key('total_ppn'),
              ),
            ],
          ),

          // Total PPN

          // Sub Total
          Intrinsic(
            gap: 10,
            children: [
              LzForm.input(
                hint: 'Masukkan Sub Total',
                label: 'Sub Total',
                keyboard: Tit.number,
                formatters: [Formatter.currency()],
                onChange: (v) => controller.hitungOtomatis(),
                model: forms.key('sub_total'),
              ),
              LzForm.input(
                hint: 'Masukkan Harga Modal',
                label: 'Harga Modal',
                keyboard: Tit.number,
                formatters: [Formatter.currency()],
                onChange: (v) => controller.hitungOtomatis(),
                model: forms.key('harga_modal'),
              ),
            ],
          ),

          // Ongkir
          LzForm.input(
            hint: 'Masukkan Harga Ongkir',
            label: 'Ongkir',
            keyboard: Tit.number,
            formatters: [Formatter.currency()],
            model: forms.key('ongkir'),
            onChange: (v) => controller.hitungOtomatis(),
          ),

          // Harga Modal

          // Lokasi
          LzForm.input(
            hint: 'Masukkan Lokasi Material',
            label: 'Lokasi',
            model: forms.key('lokasi'),
          ),

          // Supplier
          LzForm.select(
            hint: 'Pilih Suplier',
            label: 'Suplier',
            model: forms.key('supplier'),
            style: OptionPickerStyle(withSearch: true),
            onTap: () => controller.openSupp(),
          ),

          // Keterangan
          LzForm.input(
            maxLines: 9,
            hint: 'Masukkan Keterangan Material',
            label: 'Keterangan',
            model: forms.key('keterangan'),
          ),
        ],
      ),
    );
  }
}
