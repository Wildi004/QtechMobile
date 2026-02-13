import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/company_profile.dart';
import 'package:qrm_dev/app/modules/company_profile/controllers/profile%20perusahaan%20controller/edit_profile_perusahaan_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class EditProfilePerusahaanView
    extends GetView<EditProfilePerusahaanController> {
  final CompanyProfile? data;
  const EditProfilePerusahaanView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Profile Perusahaan',
        actions: [
          IconButton(
            onPressed: () {
              // controller.onSubmit(data?.id);
            },
            icon: Icon(Hi.tick03),
          )
        ],
      ).appBar,
      body: LzListView(
        gap: 25,
        children: [
          LzForm.input(
            hint: 'Inputkan Nama Perusahaan',
            label: 'Nama Perusahaan',
            model: controller.forms.key('nama_perusahaan'),
          ),
        ],
      ),
    );
  }
}
