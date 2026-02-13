import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/po_non/po_non.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Po%20Non%20Ppn/create_po_non_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreatePoNonView extends GetView<CreatePoNonController> {
  final PoNon? data;
  const CreatePoNonView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreatePoNonController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (!controller.isSubmitted.value && controller.created != null) {
          await controller.deleteData(controller.created!.noHide!);
        }
      },
      child: Scaffold(
          appBar: CustomAppbar(
            title: 'Form PO (Non PPN)',
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
                enabled: false,
                label: 'NO. PO',
                maxLines: 99,
                model: forms.key('no_po_nonppn'),
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
                    model: forms.key('tgl_dikirim'),
                    suffixIcon: Hi.calendar02,
                    onTap: () {
                      LzPicker.date(context,
                          minDate: DateTime(1900),
                          initDate: forms.get('tgl_dikirim').toDate(),
                          onSelect: (date) {
                        forms.set('tgl_dikirim', date.format());
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

              LzForm.input(
                hint: 'Masukkan Lokasi Pengiriman',
                label: 'Lokasi Pengiriman',
                model: forms.key('lokasi_pengiriman'),
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
                              keyboard: TextInputType.number,
                              model: form.key('qty'),
                              onChange: (val) => controller.hitungTotal(),
                            ),
                            LzForm.select(
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
                          ],
                        ),
                        Intrinsic(
                          gap: 10,
                          children: [
                            LzForm.input(
                              label: 'Harga',
                              formatters: [Formatter.currency()],
                              keyboard: TextInputType.number,
                              hint: 'Masukan Harga',
                              onChange: (val) => controller.hitungTotal(),
                              model: form.key('unit_price'),
                            ),
                            LzForm.input(
                              label: 'Diskon',
                              keyboard: TextInputType.number,
                              hint: 'Masukan Diskon',
                              onChange: (val) => controller.hitungTotal(),
                              model: form.key('diskon'),
                            ),
                          ],
                        ),
                        LzForm.input(
                          label: 'Amount',
                          readOnly: true,
                          onChange: (val) => controller.hitungTotal(),
                          model: form.key('amount'),
                        ),
                      ],
                    );
                  }),
                );
              }),

              LzForm.input(
                label: 'Sub Total',
                onChange: (val) => controller.hitungTotal(),
                readOnly: true,
                model: forms.key('sub_total'),
              ),
              Intrinsic(
                gap: 10,
                children: [
                  LzForm.input(
                    label: 'DP',
                    hint: 'Masukan DP',
                    keyboard: TextInputType.number,
                    onChange: (val) => controller.hitungTotal(),
                    maxLength: 3,
                    model: forms.key('dp'),
                  ),
                  LzForm.input(
                    label: 'DP Amount',
                    model: forms.key('dp_amount'),
                    readOnly: true,
                  ),
                ],
              ),
              LzForm.input(
                label: 'grand Total',
                onChange: (val) => controller.hitungTotal(),
                readOnly: true,
                model: forms.key('grand_total'),
              ),
              LzForm.input(
                label: 'Freight Cost',
                keyboard: TextInputType.number,
                onChange: (val) => controller.hitungTotal(),
                hint: 'Masukan Freight Cost',
                model: forms.key('freight_cost'),
              ),

              Divider(
                color: Colors.grey.shade700,
                thickness: 1,
              ),
            ],
          )),
    );
  }
}
