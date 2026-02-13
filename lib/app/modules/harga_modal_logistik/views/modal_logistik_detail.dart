import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/modal_logistik.dart';
import 'package:qrm_dev/app/modules/harga_modal_logistik/controllers/harga_modal_logistik_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class ModalLogistikDetail extends GetView<HargaModalLogistikController> {
  final ModalLogistik? data;
  const ModalLogistikDetail({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.put(HargaModalLogistikController());
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Harga Modal Logistik Detail',
      ).appBar,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: LzListView(
                gap: 20,
                children: [
                  LzForm.input(
                    enabled: false,
                    label: 'Kode Material',
                    model: forms.key('kode_material'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Nama',
                    model: forms.key('nama'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Tanggal Input',
                          model: forms.key('tgl_input'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Tanggal Berlaku',
                          model: forms.key('tgl_berlaku'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Qty',
                          model: forms.key('qty'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Satuan',
                          model: forms.key('satuan'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Harga Satuan',
                          model: forms.key('harga_satuan'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Harga Diskon',
                          model: forms.key('harga_diskon'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'PPN',
                          model: forms.key('ppn'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Total PPN',
                          model: forms.key('total_ppn'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Sub Total',
                          model: forms.key('sub_total'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Ongkir',
                          model: forms.key('ongkir'),
                        ),
                      ),
                    ],
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Harga Modal',
                    model: forms.key('harga_modal'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Lokasi',
                          model: forms.key('lokasi'),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'User Name',
                          model: forms.key('user_name'),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Supplier Name',
                    model: forms.key('supplier_name'),
                  ),
                  LzForm.input(
                    enabled: false,
                    maxLines: 99,
                    label: 'Keterangan',
                    model: forms.key('keterangan'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
