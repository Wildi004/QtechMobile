import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/ekpedisi.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Ekpedisi%20Logistik/create_ekpedisi_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreateEkpedisiView extends GetView<CreateEkpedisiController> {
  final Ekpedisi? data;
  const CreateEkpedisiView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateEkpedisiController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.getDetails(data!.id!);
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Form Add',
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
        gap: 20,
        children: [
          LzForm.input(
            label: 'Nama',
            hint: 'Masukkan nama ekspedisi',
            model: forms.key('nama'),
            maxLines: 1,
          ),
          LzForm.input(
            label: 'No HP',
            hint: 'Masukkan nomor HP ekspedisi',
            keyboard: TextInputType.number,
            maxLines: 1,
            model: forms.key('no_hp'),
          ),
          LzForm.input(
            label: 'CP',
            hint: 'Masukkan nama contact person',
            maxLines: 1,
            model: forms.key('cp'),
          ),
          LzForm.input(
            label: 'HP CP',
            hint: 'Masukkan nomor HP contact person',
            keyboard: TextInputType.number,
            maxLines: 1,
            model: forms.key('hp_cp'),
          ),
          LzForm.input(
            label: 'Alamat',
            hint: 'Masukkan alamat lengkap ekspedisi',
            maxLines: 3,
            model: forms.key('alamat'),
          ),
          LzForm.input(
            label: 'Jenis',
            hint: 'Masukkan jenis ekspedisi',
            maxLines: 1,
            model: forms.key('jenis'),
          ),
          LzForm.select(
            hint: 'Status Aset',
            style: OptionPickerStyle(withSearch: true),
            label: 'Status Aset',
            model: forms.key('status'),
            onTap: () async {
              final data = await controller.getStatus().overlay();
              controller.forms
                  .set('status')
                  .options(data.labelValue('name', 'id'));
            },
          ),
          LzForm.input(
            label: 'Keterangan',
            hint: 'Tambahkan keterangan tambahan',
            maxLines: 3,
            model: forms.key('keterangan'),
          ),
        ],
      ),
    );
  }
}
