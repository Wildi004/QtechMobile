import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_pemb_non_ppn/del_pemb_non_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Delivery%20Pembelian%20Non%20PPN%20Logistik/edit_del_pemb_non_ppn_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class EditDelPembNonPpnView extends GetView<EditDelPembNonPpnController> {
  final DelPembNonPpn? data;
  const EditDelPembNonPpnView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EditDelPembNonPpnController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.data = data;
      final datas = data!.toJson();

      forms.fill(datas);

      if (data != null && controller.data == null) {
        controller.data = data;
        controller.getDetailData(data!.noHide!);
      }
    }

    return Scaffold(
        appBar: CustomAppbar(
          title: 'Edit Delivery Pembelian Non PPN',
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
              hint: 'Masukkan NO. Delivery',
              enabled: false,
              label: 'NO. Delivery',
              maxLines: 99,
              model: forms.key('no_delivery'),
            ),
            Intrinsic(
              gap: 10,
              children: [
                LzForm.input(
                  label: 'Received Date',
                  hint: 'Format: YYYY-MM-DD',
                  model: forms.key('received_date'),
                  suffixIcon: Hi.calendar02,
                  onTap: () {
                    LzPicker.date(context,
                        minDate: DateTime(1900),
                        initDate: forms.get('received_date').toDate(),
                        onSelect: (date) {
                      forms.set('received_date', date.format());
                    });
                  },
                ),
                LzForm.input(
                  label: 'Shipment Date',
                  hint: 'Format: YYYY-MM-DD',
                  model: forms.key('shipment_date'),
                  suffixIcon: Hi.calendar02,
                  onTap: () {
                    LzPicker.date(context,
                        minDate: DateTime(1900),
                        initDate: forms.get('shipment_date').toDate(),
                        onSelect: (date) {
                      forms.set('shipment_date', date.format());
                    });
                  },
                ),
              ],
            ),
            Intrinsic(
              gap: 10,
              children: [
                LzForm.input(
                  hint: 'Ekpedisi',
                  label: 'Ekpedisi',
                  model: forms.key('ekspedisi'),
                ),
                LzForm.input(
                  hint: 'Penerima',
                  label: 'Penerima',
                  model: forms.key('penerima'),
                ),
              ],
            ),
            LzForm.input(
              hint: 'Masukkan Lokasi Pengiriman',
              label: 'Lokasi Pengiriman',
              model: forms.key('lokasi_pengiriman'),
              maxLines: 99,
            ),
            LzForm.input(
              label: 'Harga Ekpedisi',
              model: forms.key('harga_ekspedisi'),
              keyboard: Tit.number,
              formatters: [Formatter.currency()],
              maxLines: 12,
            ),
            LzForm.select(
              label: 'No. Pembelian',
              hint: 'Pilih No. Pembelian',
              model: forms.key('no_pembelian_nonppn'),
              style: OptionPickerStyle(withSearch: true),
              onTap: () => controller.openPemb(),
              onChange: (val) {
                final selected = controller.po.firstWhereOrNull(
                  (e) => e['no_pembelian_nonppn'] == val,
                );

                if (selected != null) {
                  controller.onSelectPo(selected['id'].toString());
                }
              },
            ),
            Divider(
              color: Colors.grey.shade700,
              thickness: 1,
            ),
            Obx(() {
              if (controller.formDetails.isEmpty) {
                return Text('Belum ada detail barang');
              }

              return Column(
                children: controller.formDetails.generate((form, i) {
                  return Column(
                    children: [
                      LzCard(
                        padding: Ei.all(10),
                        gap: 10,
                        children: [
                          LzForm.input(
                            label: 'Nama Barang',
                            model: form.key('nama_barang'),
                            enabled: false,
                            maxLines: 12,
                          ),
                          LzForm.input(
                            label: 'Qty',
                            keyboard: Tit.number,
                            model: form.key('qty'),
                            enabled: false,
                          ),
                          LzForm.input(
                            label: 'Jumlah Keluar',
                            keyboard: Tit.number,
                            model: form.key('jumlah_keluar'),
                            onChange: (val) {
                              controller.hitungTotal(i);
                            },
                          ),
                          LzForm.input(
                            keyboard: Tit.number,
                            label: 'Berat Satuan',
                            model: form.key('berat_satuan'),
                            onChange: (val) {
                              controller.hitungTotal(i);
                            },
                          ),
                          LzForm.input(
                            label: 'Total',
                            model: form.key('total'),
                            enabled: false,
                          ),
                        ],
                      ),
                      SizedBox(height: 20), // 👈 Jarak antar card
                    ],
                  );
                }),
              );
            }),
          ],
        ));
  }
}
