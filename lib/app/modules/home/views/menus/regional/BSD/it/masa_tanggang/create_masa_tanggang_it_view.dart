import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/masa_tanggang.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Masa%20Tanggang%20IT/create_masa_tanggang_it_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreateMasaTanggangItView extends GetView<CreateMasaTanggangItController> {
  final MasaTanggang? data;
  const CreateMasaTanggangItView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateMasaTanggangItController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        actions: [
          IconButton(
              onPressed: () {
                controller.onSubmit(data?.id);
              },
              icon: Icon(Hi.tick04))
        ],
        title: 'Form Masa Tanggang',
      ).appBar,
      body: LzListView(
        gap: 20,
        children: [
          LzForm.input(
            hint: 'Nama Hosting',
            label: 'Nama Hosting',
            model: controller.forms.key('nama_hosting'),
          ),
          LzForm.input(
            hint: 'Penyedia',
            label: 'Penyedia',
            model: controller.forms.key('penyedia'),
          ),
          LzForm.input(
              label: 'Tanggal Expired',
              model: forms.key('tgl_expired'),
              hint: 'Tanggal Expired',
              suffixIcon: Hi.calendar02,
              onTap: () {
                LzPicker.date(context,
                    initDate: forms.get('tgl_expired').toDate(),
                    onSelect: (date) {
                  forms.set('tgl_expired', date.format());
                });
              }),
        ],
      ),
    );
  }
}
