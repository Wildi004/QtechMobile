import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/stok_material.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Stok%20Material/edit_stok_material_logistik_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class EditStokMaterialLogistikView
    extends GetView<EditStokMaterialLogistikController> {
  final StokMaterial? data;
  const EditStokMaterialLogistikView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EditStokMaterialLogistikController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.getDetailData(data!.id!);
    }

    return Scaffold(
        appBar: CustomAppbar(
          title: 'Edit Stok Material',
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
          autoCache: true,
          gap: 20,
          children: [
            Column(
              children: [
                LzForm.input(
                  hint: 'Masukkan Kode Material',
                  label: 'Kode Material',
                  model: forms.key('kode_material'),
                ),
                LzForm.select(
                  hint: 'Pilih Jenis Pekerjaan',
                  label: 'Jenis Pekerjaan',
                  model: forms.key('jenispekerjaan_id'),
                  style: OptionPickerStyle(withSearch: true),
                  onTap: controller.getJobs,
                  onChange: (value) {
                    controller.forms
                        .set('jenismaterial_id', Option(''))
                        .enable();
                    controller.forms.set('namamaterial_id', Option(''));
                  },
                ),
                LzForm.select(
                  hint: 'Pilih Jenis Material',
                  label: 'Jenis Material',
                  model: forms.key('jenismaterial_id'),
                  style: OptionPickerStyle(withSearch: true),
                  enabled: false,
                  onTap: controller.getMaterialTypes,
                  onChange: (value) {
                    controller.forms
                        .set('namamaterial_id', Option(''))
                        .enable();
                  },
                ),
                LzForm.select(
                    hint: 'Pilih Nama Material',
                    label: 'Nama Material',
                    model: forms.key('namamaterial_id'),
                    style: OptionPickerStyle(withSearch: true),
                    enabled: false,
                    onTap: controller.getMaterials),
                LzForm.select(
                  hint: 'Pilih Suplier',
                  label: 'Suplier',
                  model: forms.key('suplier_id'),
                  style: OptionPickerStyle(withSearch: true),
                  onTap: () => controller.openSupp(),
                ),
                LzForm.input(
                  hint: 'Masukkan Brand',
                  label: 'Brand',
                  model: forms.key('brand'),
                ),
                LzForm.input(
                  hint: 'Masukkan Qty',
                  label: 'Qty',
                  formatters: [Formatter.currency()],
                  keyboard: TextInputType.number,
                  model: forms.key('qty'),
                ),
                LzForm.input(
                  hint: 'Masukkan Harga Beli',
                  label: 'Harga Beli',
                  formatters: [Formatter.currency()],
                  keyboard: TextInputType.number,
                  model: forms.key('harga_beli'),
                ),
                LzForm.input(
                  hint: 'Masukkan Ongkir',
                  formatters: [Formatter.currency()],
                  label: 'Ongkir',
                  keyboard: TextInputType.number,
                  model: forms.key('ongkir'),
                ),
                Intrinsic(gap: 10, children: [
                  LzForm.input(
                    hint: 'Harga Modal',
                    label: 'Harga Modal',
                    formatters: [Formatter.currency()],
                    keyboard: TextInputType.number,
                    model: forms.key('harga_modal'),
                  ),
                  LzForm.input(
                    hint: 'Total Modal',
                    label: 'Total Modal',
                    formatters: [Formatter.currency()],
                    keyboard: TextInputType.number,
                    model: forms.key('total_modal'),
                  ),
                ])
              ],
            )
          ],
        ));
  }
}
