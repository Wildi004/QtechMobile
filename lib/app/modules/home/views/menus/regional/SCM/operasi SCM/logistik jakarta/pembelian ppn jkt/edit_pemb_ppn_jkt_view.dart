import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pembelian_ppn/pembelian_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Pembelian%20PPN/edit_pemb_ppn_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class EditPembPpnView extends GetView<EditPembPpnController> {
  final PembelianPpn? data;
  const EditPembPpnView({super.key, this.data});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EditPembPpnController());
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
          title: 'Edit Pembelian PPN',
          actions: [
            IconButton(
              onPressed: () {
                controller.onSubmit();
              },
              icon: Icon(Hi.tick04),
            ),
          ],
        ).appBar,
        body: LzListView(
          gap: 10,
          children: [
            LzForm.input(
              hint: 'Masukkan NO. Pembelian',
              label: 'NO. Pembelian',
              maxLines: 99,
              model: forms.key('no_pembelian'),
            ),
            LzForm.input(
              hint: 'Masukkan NO. Invoice',
              label: 'NO. Invoice',
              maxLines: 99,
              model: forms.key('no_invoice'),
            ),
            Intrinsic(
              gap: 10,
              children: [
                LzForm.input(
                  label: 'Tanggal PO',
                  hint: 'Format: YYYY-MM-DD',
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
            LzForm.select(
              hint: 'Masukkan Shipment',
              label: 'Shipment',
              model: forms.key('shipment'),
              onTap: () async {
                final data = await controller.getShipment().overlay();
                controller.forms
                    .set('shipment')
                    .options(data.labelValue('name'));
              },
            ),
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
                return Center(child: Text("Belum ada item PO"));
              }
              return LzListView(
                shrinkWrap: true,
                gap: 20,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                autoCache: true,
                children: controller.formPo.generate((form, i) {
                  return LzCard(
                    gap: 10,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Data ${controller.formPo.length - i}',
                              style: Gfont.bold.copyWith(fontSize: 16)),
                          IconButton(
                            onPressed: () => controller.removePo(i),
                            icon: Icon(Hi.delete02, color: Colors.red),
                          ),
                        ],
                      ),
                      LzForm.select(
                        hint: 'Masukkan Kode Material',
                        style: OptionPickerStyle(maxLines: 2, withSearch: true),
                        label: 'Kode Material',
                        onTap: () => controller.openStok(i),
                        model: form.key('kode_material'),
                      ),
                      LzForm.input(
                        hint: 'Masukkan Nama Barang',
                        label: 'Nama Barang',
                        model: form.key('nama_barang'),
                      ),
                      Intrinsic(
                        gap: 10,
                        children: [
                          LzForm.input(
                            label: 'Qty',
                            hint: 'Masukan Qty',
                            model: form.key('qty'),
                            keyboard: Tit.number,
                            onChange: (v) => controller.hitungTotal(),
                          ),
                          LzForm.select(
                            label: 'Satuan',
                            style: OptionPickerStyle(withSearch: true),
                            hint: 'Pilih Satuan',
                            model: controller.formPo[i].key('satuan_id'),
                            onTap: () => controller.openSat(i),
                            onChange: (val) {
                              controller.formPo[i];
                              form.set('satuan_id', int.tryParse(val) ?? 0);
                              controller.onSelectSatuan(i);
                            },
                          ),
                        ],
                      ),
                      Intrinsic(
                        gap: 10,
                        children: [
                          LzForm.input(
                            label: 'Harga',
                            formatters: [Formatter.currency()],
                            keyboard: Tit.number,
                            hint: 'Masukan Harga',
                            model: form.key('harga_satuan'),
                            onChange: (v) => controller.hitungTotal(),
                          ),
                          LzForm.input(
                            label: 'Diskon',
                            keyboard: Tit.number,
                            hint: 'Masukan Diskon',
                            model: form.key('diskon'),
                            onChange: (v) => controller.hitungTotal(),
                          ),
                        ],
                      ),
                      LzForm.input(
                        label: 'Total Harga',
                        model: form.key('total_harga'),
                        readOnly: true,
                      ),
                    ],
                  );
                }),
              );
            }),
            LzForm.input(
              label: 'DPP Pembelian',
              readOnly: true,
              model: forms.key('dpp_pembelian'),
            ),
            Intrinsic(
              gap: 10,
              children: [
                LzForm.input(
                  label: 'Diskon Total',
                  keyboard: Tit.number,
                  hint: 'Masukan Diskon Total',
                  model: forms.key('diskon_ttl'),
                  onChange: (v) => controller.hitungTotal(),
                ),
                LzForm.input(
                  label: 'Biaya Kirim',
                  keyboard: Tit.number,
                  hint: 'Masukan Biaya Kirim',
                  model: forms.key('biaya_kirim'),
                  onChange: (v) => controller.hitungTotal(),
                ),
              ],
            ),
            Intrinsic(
              gap: 10,
              children: [
                LzForm.input(
                  label: 'PPN',
                  keyboard: Tit.number,
                  hint: 'Masukan PPN',
                  model: forms.key('ppn'),
                  onChange: (v) => controller.hitungTotal(),
                ),
                LzForm.input(
                  label: 'PPN Total',
                  readOnly: true,
                  model: forms.key('ppn_total'),
                ),
              ],
            ),
            LzForm.input(
              label: 'Total Pembelian',
              readOnly: true,
              model: forms.key('total_pembelian'),
            ),
            Divider(
              color: Colors.grey.shade700,
              thickness: 1,
            ),
          ],
        ));
  }
}
