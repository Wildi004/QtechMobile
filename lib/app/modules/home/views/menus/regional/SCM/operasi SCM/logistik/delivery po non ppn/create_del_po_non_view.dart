import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_po_non_ppn/del_po_non_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Del%20PO%20Non%20PPN/create_del_po_non_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreateDelPoNonView extends GetView<CreateDelPoNonController> {
  final DelPoNonPpn? data;
  const CreateDelPoNonView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateDelPoNonController());
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
            title: 'Form Delivery',
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
                model: forms.key('lokasi_kirim'),
                maxLines: 99,
              ),
              Intrinsic(
                gap: 10,
                children: [
                  LzForm.select(
                    label: 'No. PO',
                    hint: 'Pilih No. PO',
                    model: forms.key('no_po_nonppn'),
                    style: OptionPickerStyle(withSearch: true),
                    onTap: () => controller.openPo(),
                    onChange: (val) {
                      final selected = controller.po.firstWhereOrNull(
                        (e) => e['no_po_nonppn'] == val,
                      );

                      if (selected != null) {
                        controller.onSelectPo(selected['id'].toString());
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
                              model: form.key('jumlah_keluar'),
                              keyboard: Tit.number,
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
                              enabled: false,
                              model: form.key('total'),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    );
                  }),
                );
              }),
            ],
          )),
    );
  }
}
