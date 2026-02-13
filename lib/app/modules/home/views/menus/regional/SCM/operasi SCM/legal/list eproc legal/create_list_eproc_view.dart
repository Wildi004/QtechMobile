import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20legal/list_eproc.dart';
import 'package:qrm_dev/app/modules/home/controllers/LEGAL/List%20Eproc%20Legal/create_list_eproc_legal_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreateListEprocView extends GetView<CreateListEprocLegalController> {
  final ListEproc? data;
  const CreateListEprocView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateListEprocLegalController());
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
        title: 'Buat Akun',
      ).appBar,
      body: LzListView(
        gap: 20,
        children: [
          LzForm.input(
            maxLines: 99,
            hint: 'Masukkan Nama Akun',
            label: 'Nama Akun',
            model: forms.key('nama_akun'),
          ),
          LzForm.input(
            maxLines: 99,
            hint: 'Masukkan Nama Eproc',
            label: 'Nama Eproc',
            model: forms.key('nama_eproc'),
          ),
          LzForm.input(
            maxLines: 99,
            hint: 'Masukkan Username',
            label: 'Username',
            model: forms.key('username'),
          ),
          LzForm.input(
            hint: 'Masukan Password',
            label: 'Masukan Password',
            model: forms.key('password'),
          ),
          LzForm.input(
            hint: 'Website',
            label: 'Masukan Url',
            model: forms.key('website'),
          ),
        ],
      ),
    );
  }
}
