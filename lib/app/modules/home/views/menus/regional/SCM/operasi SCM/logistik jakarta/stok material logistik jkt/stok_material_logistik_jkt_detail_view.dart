import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/stok_material.dart';
import 'package:qrm_dev/app/modules/home/controllers/Logistik%20Jakarta/Stok%20Material%20Logistik%20Jkt/stok_material_logistik_jkt_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_rupiah.dart';

class StokMaterialLogistikJktDetailView
    extends GetView<StokMaterialLogistikJktController> {
  final StokMaterial? data;

  const StokMaterialLogistikJktDetailView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    if (data != null) {
      final datas = data!.toJson();

      datas['harga_beli'] = CurrencyHelper.formatRupiah(data!.hargaBeli);
      datas['ongkir'] = CurrencyHelper.formatRupiah(data!.ongkir);
      datas['harga_modal'] = CurrencyHelper.formatRupiah(data!.hargaModal);
      datas['total_modal'] = CurrencyHelper.formatRupiah(data!.totalModal);

      forms.fill(datas);
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Detail Stok Material',
      ).appBar,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: LzListView(
                gap: 10,
                children: [
                  LzForm.input(
                    enabled: false,
                    label: 'Kode Material',
                    maxLines: 999,
                    model: forms.key('kode_material'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Suplier',
                    maxLines: 999,
                    model: forms.key('suplier_id'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Brand',
                    maxLines: 999,
                    model: forms.key('brand'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Jenis Pekerjaan',
                    maxLines: 999,
                    model: forms.key('jenis_pekerjaan_name'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Jenis Material',
                    maxLines: 999,
                    model: forms.key('jenis_material_name'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Nama Material',
                    maxLines: 999,
                    model: forms.key('nama_material_name'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Dibuat Oleh',
                    maxLines: 999,
                    model: forms.key('created_by_name'),
                  ),
                  LzCard(
                    children: [
                      LzForm.input(
                        enabled: false,
                        label: 'Harga Beli',
                        maxLines: 999,
                        model: forms.key('harga_beli'),
                      ),
                      LzForm.input(
                        enabled: false,
                        label: 'Qty',
                        maxLines: 999,
                        model: forms.key('qty'),
                      ),
                      LzForm.input(
                        enabled: false,
                        label: 'Ongkir',
                        maxLines: 999,
                        model: forms.key('ongkir'),
                      ),
                      LzForm.input(
                        enabled: false,
                        label: 'Harga Modal',
                        maxLines: 999,
                        model: forms.key('harga_modal'),
                      ),
                      LzForm.input(
                        enabled: false,
                        label: 'Total Modal',
                        maxLines: 999,
                        model: forms.key('total_modal'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
