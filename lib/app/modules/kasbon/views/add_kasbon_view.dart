import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/kasbon.dart';
import 'package:qrm_dev/app/modules/kasbon/controllers/add_kasbon_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class AddKasbonView extends GetView<AddKasbonController> {
  final Kasbon? data;
  const AddKasbonView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddKasbonController());

    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: data == null ? 'Buat Kasbon' : 'Edit Kasbon',
        actions: [
          IconButton(
              onPressed: () {
                controller.onSubmit();
              },
              icon: Icon(Hi.tick03))
        ],
      ).appBar,
      body: LzListView(
        gap: 25,
        children: [
          LzForm.input(
            hint: 'Inputkan Nomor Pengajuan',
            label: 'No Pengajuan',
            model: forms.key('no_pengajuan'),
          ),
          LzForm.input(
            hint: 'Pilih Tanggal',
            label: 'Tanggal Kasbon',
            model: forms.key('tgl_kasbon'),
            suffixIcon: Hi.calendar02,
            onTap: () {
              LzPicker.date(
                context,
                initDate: forms.get('tgl_kasbon').toDate(),
                onSelect: (date) {
                  forms.set('tgl_kasbon', date.format());
                },
              );
            },
          ),
          LzForm.input(
            hint: 'Inputkan Jumlah',
            label: 'Jumlah',
            keyboard: Tit.number,
            model: forms.key('jml'),
            formatters: [Formatter.currency()],
          ),
          LzForm.input(
            hint: 'Inputkan Keterangan',
            label: 'Keterangan',
            model: forms.key('keterangan'),
          ),
        ],
      ),
    );
  }
}
