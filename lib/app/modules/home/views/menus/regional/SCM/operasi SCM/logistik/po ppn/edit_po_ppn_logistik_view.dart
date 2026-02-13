import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/po_ppn/po_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Po%20Ppn/edit_po_ppn_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class EditPoPpnLogistikView extends GetView<EditPoPpnController> {
  final PoPpn? data;
  const EditPoPpnLogistikView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EditPoPpnController());
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
      controller.data = data;
      final datas = data!.toJson();

      forms.fill(datas);
      controller.getDetailData(data!.noHide!);

      if (controller.formDetails.isEmpty) {
        controller.getDetails(data!);
      }
    }

    return Scaffold(
        appBar: CustomAppbar(
          title: 'Edit PO PPN',
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
          gap: 10,
          children: [
            LzForm.input(
              hint: 'Masukkan NO. PO',
              label: 'NO. PO',
              maxLines: 99,
              model: forms.key('no_po'),
            ),
            Intrinsic(
              gap: 10,
              children: [
                LzForm.input(
                  label: 'Tanggal PO',
                  hint: 'Format: YYYY-MM-DD',
                  model: forms.key('tgl_po'),
                  suffixIcon: Hi.calendar02,
                  onTap: () {
                    LzPicker.date(context,
                        minDate: DateTime(1900),
                        initDate: forms.get('tgl_po').toDate(),
                        onSelect: (date) {
                      forms.set('tgl_po', date.format());
                    });
                  },
                ),
                LzForm.input(
                  label: 'Delivery Date',
                  hint: 'Format: YYYY-MM-DD',
                  model: forms.key('delivery_date'),
                  suffixIcon: Hi.calendar02,
                  onTap: () {
                    LzPicker.date(context,
                        minDate: DateTime(1900),
                        initDate: forms.get('delivery_date').toDate(),
                        onSelect: (date) {
                      forms.set('delivery_date', date.format());
                    });
                  },
                ),
              ],
            ),
            LzForm.select(
              hint: 'Pilih Suplier',
              label: 'Suplier',
              model: forms.key('suplier_id'),
              style: OptionPickerStyle(withSearch: true),
              onTap: () => controller.openSupp(),
            ),
            LzForm.select(
              hint: 'Masukkan Jenis Pembayaran',
              label: 'Jenis Pembayaran',
              model: forms.key('jenis_pembayaran'),
              onTap: () async {
                final data = await controller.getPemb().overlay();
                controller.forms
                    .set('jenis_pembayaran')
                    .options(data.labelValue('name'));
              },
            ),
            LzForm.input(
              hint: 'Masukkan Lokasi Pengiriman',
              label: 'Lokasi Pengiriman',
              model: forms.key('lokasi_pengiriman'),
              maxLines: 99,
            ),
            LzForm.input(
              hint: 'Masukkan Shipment',
              label: 'Shipment',
              model: forms.key('shipment'),
              maxLines: 99,
            ),
            LzForm.input(
              hint: 'Opsional',
              label: 'Catatan',
              model: forms.key('catatan'),
              maxLines: 99,
            ),
            // radio cara pembayaran
            LzForm.radio(
              model: forms.key('cara_pembayaran'),
              options: const ['Cash', 'Termin'],
              onChange: (val) {
                controller.caraPembayaran.value = val;
              },
            ),

            Obx(() {
              if (controller.caraPembayaran.value == 'Termin') {
                return Intrinsic(
                  gap: 10,
                  children: [
                    LzForm.input(
                      label: 'Tanggal PO',
                      hint: 'Format: YYYY-MM-DD',
                      model: forms.key('term_from'),
                      suffixIcon: Hi.calendar02,
                      onTap: () {
                        LzPicker.date(context,
                            minDate: DateTime(1900),
                            initDate: forms.get('term_from').toDate(),
                            onSelect: (date) {
                          forms.set('term_from', date.format());
                        });
                      },
                    ),
                    LzForm.input(
                      label: 'Delivery Date',
                      hint: 'Format: YYYY-MM-DD',
                      model: forms.key('term_to'),
                      suffixIcon: Hi.calendar02,
                      onTap: () {
                        LzPicker.date(context,
                            minDate: DateTime(1900),
                            initDate: forms.get('term_to').toDate(),
                            onSelect: (date) {
                          forms.set('term_to', date.format());
                        });
                      },
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            }),
            Divider(
              color: Colors.grey.shade700,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 200),
              child: LzButton(
                color: const Color.fromARGB(255, 22, 117, 195),
                icon: Hi.add01,
                onTap: () {
                  controller.addPo();
                },
              ),
            ),
            Obx(() {
              if (controller.formPo.isEmpty) {
                return const Center(child: Text("Belum ada item PO"));
              }

              return Column(
                children: List.generate(controller.formPo.length, (i) {
                  final form = controller.formPo[i];
                  final keyId =
                      (controller.card.length > i) ? controller.card[i] : i;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: LzCard(
                      key: ValueKey(keyId),
                      gap: 10,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Data ${controller.formPo.length - i}',
                              style: Gfont.bold.copyWith(fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () => controller.removePo(i),
                              icon: Icon(Hi.delete02, color: Colors.red),
                            ),
                          ],
                        ),

                        // isi form
                        LzForm.input(
                          hint: 'Masukkan Nama Barang',
                          label: 'Nama Barang',
                          model: form.key('nama_barang'),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: LzForm.input(
                                label: 'Qty',
                                hint: 'Masukan Qty',
                                keyboard: TextInputType.number,
                                model: form.key('qty'),
                                onChange: (val) => controller.hitungTotal(),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: LzForm.select(
                                label: 'Satuan',
                                style: OptionPickerStyle(withSearch: true),
                                hint: 'Pilih Satuan',
                                model: form.key('satuan_id'),
                                onTap: () => controller.openSat(i),
                                onChange: (val) {
                                  form.set('satuan_id', int.tryParse(val) ?? 0);
                                  controller.onSelectSatuan(i);
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: LzForm.input(
                                keyboard: TextInputType.number,
                                label: 'Harga',
                                formatters: [Formatter.currency()],
                                hint: 'Masukan Harga',
                                onChange: (val) => controller.hitungTotal(),
                                model: form.key('unit_price'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: LzForm.input(
                                label: 'Diskon',
                                keyboard: TextInputType.number,
                                hint: 'Masukan Diskon',
                                model: form.key('diskon'),
                                onChange: (val) => controller.hitungTotal(),
                              ),
                            ),
                          ],
                        ),
                        LzForm.input(
                          label: 'Amount',
                          readOnly: true,
                          model: form.key('amount'),
                        ),
                      ],
                    ),
                  );
                }),
              );
            }),

            Intrinsic(
              gap: 10,
              children: [
                LzForm.input(
                  label: 'Tax',
                  keyboard: TextInputType.number,
                  hint: 'Masukan Tax',
                  maxLength: 3,
                  onChange: (val) => controller.hitungTotal(),
                  model: forms.key('tax'),
                ),
                LzForm.input(
                  label: 'DP',
                  keyboard: TextInputType.number,
                  hint: 'Masukan DP',
                  maxLength: 3,
                  onChange: (val) => controller.hitungTotal(),
                  model: forms.key('dp'),
                ),
              ],
            ),
            LzForm.input(
              label: 'Freight Cost',
              keyboard: TextInputType.number,
              hint: 'Masukan Freight Cost',
              onChange: (val) => controller.hitungTotal(),
              model: forms.key('freight_cost'),
            ),
            Obx(() => LzCard(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Subtotal: Rp ${controller.subTotal.value}'),
                        Text('Tax: Rp ${controller.taxValue.value}'),
                        Text(
                            'Freight Cost: Rp ${controller.freightCostValue.value}'),
                        Text('Grand Total: Rp ${controller.grandTotal.value}'),
                        Text('DP: Rp ${controller.jmlDp.value}'),
                      ],
                    ),
                  ],
                )),

            Divider(
              color: Colors.grey.shade700,
              thickness: 1,
            ),
          ],
        ));
  }
}
