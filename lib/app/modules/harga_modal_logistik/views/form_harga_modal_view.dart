import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/modal_logistik.dart';
import 'package:qrm/app/modules/harga_modal_logistik/controllers/form_harga_modal_controller.dart';

class FormHargaModalView extends GetView<FormHargaModalController> {
  final ModalLogistik? data;

  const FormHargaModalView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormHargaModalController());
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Buat Harga Modal Logistik',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Hi.file01,
                color: Colors.white,
              ))
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: ['4CA1AF'.hex, '808080'.hex],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LzListView(
          autoCache: true, // set true, jika inputannya ada banyak
          children: [
            LzForm.input(
                label: 'kode_material', model: forms.key('kode_material')),
            LzForm.input(label: 'Nama', model: forms.key('nama')),
            Row(
              children: [
                Expanded(
                  child: LzForm.input(
                      hint: 'Inputkan tanggal',
                      label: 'Tanggal Upload',
                      model: forms.key('tgl_input'),
                      suffixIcon: Hi.calendar02,
                      onTap: () {
                        LzPicker.date(context,
                            initDate: forms.get('tgl_input').toDate(),
                            onSelect: (date) {
                          forms.set('tgl_input', date.format());
                        });
                      }),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: LzForm.input(
                      hint: 'Inputkan tanggal',
                      label: 'Tanggal Upload',
                      model: forms.key('tgl_berlaku'),
                      suffixIcon: Hi.calendar02,
                      onTap: () {
                        LzPicker.date(context,
                            initDate: forms.get('tgl_berlaku').toDate(),
                            onSelect: (date) {
                          forms.set('tgl_berlaku', date.format());
                        });
                      }),
                ),
              ],
            )..gap(10),
            LzForm.input(
              label: 'qty',
              model: forms.key('qty'),
            ),
            LzForm.input(
              label: 'satuan',
              model: forms.key('satuan'),
            ),
            LzForm.input(
              label: 'harga_satuan',
              model: forms.key('harga_satuan'),
            ),
            SizedBox(
              width: 15,
            ),
            LzForm.input(
                label: 'harga_diskon',
                model: forms.key('harga_diskon'),
                maxLines: 4),
            Row(
              children: [
                Expanded(
                    child: LzForm.input(
                  label: 'ppn',
                  model: forms.key('ppn'),
                )),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: LzForm.input(
                  label: 'total_ppn',
                  model: forms.key('total_ppn'),
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: LzForm.input(
                  label: 'sub_total',
                  model: forms.key('sub_total'),
                )),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: LzForm.input(
                  label: 'ongkir',
                  model: forms.key('ongkir'),
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: LzForm.input(
                  label: 'harga_modal',
                  model: forms.key('harga_modal'),
                )),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: LzForm.input(
                  label: 'supplier',
                  model: forms.key('supplier'),
                )),
              ],
            ),
            LzForm.input(
                label: 'lokasi', model: forms.key('lokasi'), maxLines: 4),
            LzForm.input(
                label: 'Keterangan',
                model: forms.key('keterangan'),
                maxLines: 4),
            LzButton(
              text: data == null ? 'Submit' : 'Update',
              onTap: () {
                controller.onSubmit(data?.id);
              },
            ).margin(all: 20),
          ],
        ),
      ),
      // bottomNavigationBar: LzButton(
      //   text: 'Simpan',
      //   onTap: () {
      //     Get.defaultDialog(
      //       title: 'Konfirmasi',
      //       titleStyle: TextStyle(fontWeight: Fw.bold),
      //       middleText: 'Apakah Anda yakin ingin menyimpan perubahan?',
      //       middleTextStyle: TextStyle(
      //         fontSize: MediaQuery.of(context).size.height * 0.018,
      //       ),
      //       textConfirm: 'Ya',
      //       buttonColor: Colors.blue,
      //       textCancel: 'Batal',
      //       confirmTextColor: Colors.white,
      //       onConfirm: () {
      //         Get.back(); // Tutup dialog
      //         controller.onSubmit(); // Jalankan fungsi simpan
      //       },
      //     );
      //   },
      // ).margin(blr: 30)
    );
  }
}
