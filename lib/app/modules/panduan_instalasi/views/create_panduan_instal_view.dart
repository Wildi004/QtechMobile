import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/panduan_instalasi.dart';
import 'package:qrm_dev/app/modules/panduan_instalasi/controllers/create_panduan_instal_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreatePanduanInstalView extends GetView<CreatePanduanInstalController> {
  final PanduanInstalasi? data;
  const CreatePanduanInstalView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreatePanduanInstalController());
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
                logg('dta');
              },
              icon: Icon(Hi.tick04))
        ],
        title: 'Buat Panduan Instalasi',
      ).appBar,
      body: LzListView(
        gap: 20,
        children: [
          LzForm.input(
            maxLines: 99,
            hint: 'Masukkan Nama Panduan',
            label: 'Nama Panduan',
            model: forms.key('nama'),
          ),
          LzForm.input(
            hint: 'Masukkan Link Panduan',
            label: 'Link Panduan',
            model: forms.key('link'),
          ),
        ],
      ),
    );
  }
}
