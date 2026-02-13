import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/inv_del_pemb_non_ppn/inv_del_pemb_non_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Invoice%20Delivery%20Pembelian%20Non%20PPN/create_inv_del_pemb_non_ppn_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreateInvDelPembNonPpnView
    extends GetView<CreateInvDelPembNonPpnController> {
  final InvDelPembNonPpn? data;
  const CreateInvDelPembNonPpnView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateInvDelPembNonPpnController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
        appBar: CustomAppbar(
          title: 'Form Inv',
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
              hint: 'Masukkan NO. Invoice',
              label: 'NO. Invoice',
              maxLines: 99,
              model: forms.key('no_invoice'),
            ),
            Intrinsic(
              gap: 10,
              children: [
                LzForm.input(
                  label: 'Tanggal Invoice',
                  hint: 'Format: YYYY-MM-DD',
                  model: forms.key('tgl_inv'),
                  suffixIcon: Hi.calendar02,
                  onTap: () {
                    LzPicker.date(context,
                        minDate: DateTime(1900),
                        initDate: forms.get('tgl_inv').toDate(),
                        onSelect: (date) {
                      forms.set('tgl_inv', date.format());
                    });
                  },
                ),
                LzForm.input(
                  hint: 'Upload Foto/Gambar Aset',
                  label: 'Gambar Aset',
                  model: forms.key('image'),
                  suffixIcon: Hi.image01,
                  readOnly: true,
                  onTap: () async {
                    final picker = ImagePicker();
                    final source = await Get.dialog<ImageSource>(
                      AlertDialog(
                        title: const Text(
                          'Pilih Salah satu',
                          style: TextStyle(fontWeight: Fw.bold),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Hi.cameraLens),
                              title: const Text('Kamera'),
                              onTap: () => Get.back(result: ImageSource.camera),
                            ),
                            ListTile(
                              leading: const Icon(Hi.image02),
                              title: const Text('Galeri'),
                              onTap: () =>
                                  Get.back(result: ImageSource.gallery),
                            ),
                          ],
                        ),
                      ),
                    );

                    if (source != null) {
                      final pickedFile = await picker.pickImage(source: source);
                      if (pickedFile != null) {
                        final path = pickedFile.path;
                        forms.set('image', path);
                        controller.fileName.value = path;
                        controller.file = File(path);
                      }
                    }
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
              label: 'Catatan',
              maxLines: 9,
              hint: 'Catatan',
              model: forms.key('catatan'),
              suffixIcon: Hi.calendar02,
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
            Intrinsic(
              gap: 10,
              children: [
                LzForm.select(
                  label: 'No. PO',
                  hint: 'Pilih No. PO',
                  model: forms.key('no_delivery'),
                  style: OptionPickerStyle(withSearch: true),
                  onTap: () => controller.openInv(),
                  onChange: (val) {
                    final selected = controller.po.firstWhereOrNull(
                      (e) => e['no_delivery'] == val,
                    );

                    if (selected != null) {
                      controller.onSelectPo(selected['no_hide']);
                    }
                  },
                ),
                LzForm.input(
                  label: 'Received Date',
                  hint: 'Format: YYYY-MM-DD',
                  model: forms.key('received_date'),
                  suffixIcon: Hi.calendar02,
                  enabled: false,
                  onTap: () {
                    LzPicker.date(context,
                        minDate: DateTime(1900),
                        initDate: forms.get('received_date').toDate(),
                        onSelect: (date) {
                      forms.set('received_date', date.format());
                    });
                  },
                ),
              ],
            ),
            Divider(
              color: Colors.grey.shade700,
              thickness: 1,
            ),
            Obx(() {
              if (controller.formDetail.isEmpty) {
                return Text('Belum ada detail barang');
              }

              return Column(
                children: controller.formDetail.generate((form, i) {
                  return Column(
                    children: [
                      LzCard(
                        padding: Ei.all(10),
                        gap: 10,
                        children: [
                          Text('Barang ${i + 1}', style: Gfont.bold),
                          LzForm.input(
                            label: 'Nama Barang',
                            model: form.key('nama_barang'),
                            enabled: false,
                          ),
                          LzForm.input(
                            label: 'Qty',
                            model: form.key('qty'),
                            enabled: false,
                          ),
                          LzForm.input(
                            label: 'Harga Satuan',
                            model: form.key('harga_satuan'),
                            formatters: [Formatter.currency()],
                            keyboard: Tit.number,
                            onChange: (val) => controller.hitungTotal(i),
                          ),
                          LzForm.input(
                            label: 'Total',
                            model: form.key('total'),
                            enabled: false,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }),
              );
            }),
            LzForm.input(
              label: 'Sub Total',
              model: controller.forms.key('subtotal'),
              enabled: false,
            ),
            Intrinsic(
              gap: 10,
              children: [
                LzForm.input(
                  keyboard: Tit.number,
                  label: 'Tax %',
                  formatters: [Formatter.currency()],
                  model: controller.forms.key('ppn'),
                  onChange: (val) => controller.onTaxChanged(val),
                ),
                LzForm.input(
                  label: 'Total Tax',
                  model: controller.forms.key('total_tax'),
                  enabled: false,
                ),
              ],
            ),
            LzForm.input(
              label: 'Grand Total',
              model: controller.forms.key('grand_total'),
              enabled: false,
            ),
          ],
        ));
  }
}
