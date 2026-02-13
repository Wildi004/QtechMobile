import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pemb_non_ppn/pemb_non_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/Logistik%20Jakarta/Pembelian%20Non%20PPN%20Logistik%20Jkt/create_pemb_jkt_non_ppn_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreatePembNonPpnJktView extends GetView<CreatePembJktNonPpnController> {
  final PembNonPpn? data;
  const CreatePembNonPpnJktView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreatePembJktNonPpnController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
        appBar: CustomAppbar(
          title: 'Form Pembelian Non PPN',
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
              hint: 'Masukkan NO. Pembelian',
              enabled: false,
              label: 'NO. Pembelian',
              maxLines: 99,
              model: forms.key('no_pembelian_nonppn'),
            ),
            LzForm.input(
              hint: 'Masukkan Invoice',
              label: 'Invoice',
              model: forms.key('no_invoice'),
            ),
            Intrinsic(
              gap: 10,
              children: [
                LzForm.select(
                  hint: 'Masukkan Shipment',
                  label: 'shipment',
                  model: forms.key('shipment'),
                  onTap: () async {
                    final data = await controller.getShipment().overlay();
                    controller.forms
                        .set('shipment')
                        .options(data.labelValue('name'));
                  },
                ),
                LzForm.select(
                  hint: 'Masukkan Jenis Pembayaran',
                  label: 'Jenis Pembayaran',
                  model: forms.key('jenis_pembayaran'),
                  onTap: () async {
                    final data = await controller.getPemb().overlay();
                    controller.forms
                        .set('jenis_pembayaran')
                        .options(data.labelValue('name')); //
                  },
                ),
              ],
            ),
            Intrinsic(
              gap: 10,
              children: [
                LzForm.input(
                  label: 'Tanggal Beli',
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
                      label: 'Tanggal PO',
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
                    key: ValueKey(controller.cards[i]),
                    gap: 10,
                    children: [
                      // tombol hapus item
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Data ${controller.formPo.length - i}',
                              style: Gfont.bold.copyWith(fontSize: 16)),
                          IconButton(
                            onPressed: () => controller.removePo(i),
                            icon: Icon(Icons.delete, color: Colors.red),
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
                          ),

                          LzForm.select(
                            label: 'Satuan',
                            style: OptionPickerStyle(withSearch: true),
                            hint: 'Pilih Satuan',
                            model: controller.formPo[i].key('satuan_id'),
                            onTap: () => controller.openSat(i),
                            onChange: (val) {
                              controller.formPo[i]
                                  .set('satuan_id', int.tryParse(val) ?? 0);
                            },
                          ),
                          // LzForm.select(
                          //   label: 'Sat',
                          //   hint: 'Masukan Satuan',
                          //   model: form.key('satuan_id'),
                          //   onTap: () =>
                          //       controller.openSat(i), // perlu passing index
                          // ),
                        ],
                      ),

                      Intrinsic(
                        gap: 10,
                        children: [
                          LzForm.input(
                            label: 'Harga',
                            formatters: [Formatter.currency()],
                            hint: 'Masukan Harga',
                            model: form.key('harga_satuan'),
                          ),
                          LzForm.input(
                            label: 'Diskon',
                            hint: 'Masukan Diskon',
                            model: form.key('diskon'),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              );
            }),

            Intrinsic(
              gap: 10,
              children: [
                LzForm.input(
                  label: 'diskon_ttl',
                  hint: 'diskon_ttl',
                  maxLength: 3,
                  model: forms.key('diskon_ttl'),
                ),
                LzForm.input(
                  label: 'biaya_kirim',
                  hint: 'Masukan biaya_kirim',
                  maxLength: 3,
                  model: forms.key('biaya_kirim'),
                ),
              ],
            ),

            Divider(
              color: Colors.grey.shade700,
              thickness: 1,
            ),
          ],
        ));
  }
}
