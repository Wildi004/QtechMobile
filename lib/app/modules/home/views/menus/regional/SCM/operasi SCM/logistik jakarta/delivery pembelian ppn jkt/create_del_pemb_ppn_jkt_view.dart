import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_pemb_ppn/del_pemb_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/Logistik%20Jakarta/Delivery%20Pembelian%20PPN%20Jkt/create_del_pemb_ppn_jkt_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreateDelPembPpnJktView extends GetView<CreateDelPembPpnJktController> {
  final DelPembPpn? data;
  const CreateDelPembPpnJktView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateDelPembPpnJktController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
        appBar: CustomAppbar(
          title: 'Form Delivery Pembelian',
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
              enabled: false,
              label: 'NO. Pembelian',
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
            Intrinsic(
              gap: 10,
              children: [
                LzForm.select(
                  label: 'No. Pembelian',
                  hint: 'Pilih No. Pembelian',
                  model: forms.key('no_pembelian'),
                  style: OptionPickerStyle(withSearch: true),
                  onTap: () => controller.openPemb(),
                  onChange: (val) {
                    final selected = controller.pemb.firstWhereOrNull(
                      (e) => e['no_pembelian'] == val,
                    );

                    if (selected != null) {
                      controller.onSelectPemb(selected['id'].toString());
                    }
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
                          Text(
                            'Barang ${i + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          LzForm.select(
                            hint: 'Pilih Kode Material',
                            label: 'Kode Material',
                            model: form.key('kode_material'),
                            style: OptionPickerStyle(withSearch: true),
                            onTap: () => controller.openKodeMat(i),
                          ),
                          LzForm.input(
                            label: 'Nama Barang',
                            model: form.key('nama_barang'),
                            enabled: false,
                            maxLines: 12,
                          ),
                          LzForm.input(
                            label: 'Qty',
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
                            label: 'Berat Satuan',
                            keyboard: Tit.number,
                            model: form.key('berat_satuan'),
                            onChange: (val) {
                              controller.hitungTotal(i);
                            },
                          ),
                          LzForm.input(
                              label: 'Total',
                              model: form.key('total'),
                              enabled: false),
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
