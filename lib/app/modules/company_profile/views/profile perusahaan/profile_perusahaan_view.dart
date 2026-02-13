import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/company_profile.dart';
import 'package:qrm_dev/app/modules/company_profile/controllers/profile%20perusahaan%20controller/profile_perusahaan_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';

class ProfilePerusahaanView extends GetView<ProfilePerusahaanController> {
  final CompanyProfile? data;

  const ProfilePerusahaanView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfilePerusahaanController());

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Profile Perusahaan',
        actions: [
          IconButton(
              onPressed: controller.onSubmit,

              icon: Icon(Hi.tick03))
        ],
      ).appBar,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return LzListView(
          gap: 20,
          children: [
            Text(
              'Profil Perusahaan (Bali)',
              style: CustomTextStyle.title(),
            ),

            /// ========================
            /// INFORMASI PERUSAHAAN
            /// ========================
            LzForm.input(
              label: 'Nama Perusahaan',
              hint: 'Masukkan nama perusahaan',
              model: controller.forms.key('nama_perusahaan'),
            ),

            LzForm.input(
              label: 'Alamat',
              hint: 'Masukkan alamat perusahaan',
              maxLines: 3,
              model: controller.forms.key('alamat'),
            ),

            /// ========================
            /// KONTAK
            /// ========================
            LzForm.input(
              label: 'Telepon Kantor',
              hint: 'Masukkan telepon kantor',
              model: controller.forms.key('telp_kantor'),
            ),

            LzForm.input(
              label: 'Telepon HP',
              hint: 'Masukkan telepon HP',
              model: controller.forms.key('telp_hp'),
            ),

            LzForm.input(
              label: 'Email 1',
              hint: 'Masukkan email utama',
              model: controller.forms.key('email1'),
            ),

            LzForm.input(
              label: 'Email 2',
              hint: 'Masukkan email tambahan',
              model: controller.forms.key('email2'),
            ),

            LzForm.input(
              label: 'Fax',
              hint: 'Masukkan nomor fax',
              model: controller.forms.key('fax'),
            ),

            LzForm.input(
              label: 'Website',
              hint: 'Masukkan website perusahaan',
              model: controller.forms.key('web'),
            ),

            /// ========================
            /// SOSIAL MEDIA
            /// ========================
            LzForm.input(
              label: 'Instagram',
              hint: 'Masukkan username instagram',
              model: controller.forms.key('instagram'),
            ),

            LzForm.input(
              label: 'YouTube',
              hint: 'Masukkan channel youtube',
              model: controller.forms.key('youtube'),
            ),

            LzForm.input(
              label: 'Facebook',
              hint: 'Masukkan facebook',
              model: controller.forms.key('fb'),
            ),

            /// ========================
            /// REKENING BANK
            /// ========================
            LzForm.input(
              label: 'Bank 1',
              hint: 'Nama Bank',
              model: controller.forms.key('bank1'),
            ),

            LzForm.input(
              label: 'Rekening 1',
              hint: 'Nomor Rekening',
              model: controller.forms.key('rek1'),
            ),

            LzForm.input(
              label: 'Bank 2',
              hint: 'Nama Bank',
              model: controller.forms.key('bank2'),
            ),

            LzForm.input(
              label: 'Rekening 2',
              hint: 'Nomor Rekening',
              model: controller.forms.key('rek2'),
            ),

            LzForm.input(
              label: 'Bank 3',
              hint: 'Nama Bank',
              model: controller.forms.key('bank3'),
            ),

            LzForm.input(
              label: 'Rekening 3',
              hint: 'Nomor Rekening',
              model: controller.forms.key('rek3'),
            ),

            SizedBox(height: 30),

            Text(
              'Profil Perusahaan (Bali)',
              style: CustomTextStyle.title(),
            ),

            LzForm.input(
              label: 'Nama Perusahaan (JKT)',
              model: controller.forms.key('nama_perusahaan_jkt'),
            ),

            LzForm.input(
              label: 'Alamat (JKT)',
              maxLines: 3,
              model: controller.forms.key('alamat_jkt'),
            ),

            LzForm.input(
              label: 'Telepon Kantor (JKT)',
              model: controller.forms.key('telp_kantor_jkt'),
            ),

            LzForm.input(
              label: 'Telepon HP (JKT)',
              model: controller.forms.key('telp_hp_jkt'),
            ),

            LzForm.input(
              label: 'Email 1 (JKT)',
              model: controller.forms.key('email1_jkt'),
            ),

            LzForm.input(
              label: 'Email 2 (JKT)',
              model: controller.forms.key('email2_jkt'),
            ),

            LzForm.input(
              label: 'Fax (JKT)',
              model: controller.forms.key('fax_jkt'),
            ),

            LzForm.input(
              label: 'Website (JKT)',
              model: controller.forms.key('web_jkt'),
            ),

            LzForm.input(
              label: 'Instagram (JKT)',
              model: controller.forms.key('instagram_jkt'),
            ),

            LzForm.input(
              label: 'YouTube (JKT)',
              model: controller.forms.key('youtube_jkt'),
            ),

            LzForm.input(
              label: 'Facebook (JKT)',
              model: controller.forms.key('fb_jkt'),
            ),

            /// ===== BANK JKT =====

            LzForm.input(
              label: 'Bank 1 (JKT)',
              model: controller.forms.key('bank1_jkt'),
            ),

            LzForm.input(
              label: 'Rekening 1 (JKT)',
              model: controller.forms.key('rek1_jkt'),
            ),

            LzForm.input(
              label: 'Bank 2 (JKT)',
              model: controller.forms.key('bank2_jkt'),
            ),

            LzForm.input(
              label: 'Rekening 2 (JKT)',
              model: controller.forms.key('rek2_jkt'),
            ),

            LzForm.input(
              label: 'Bank 3 (JKT)',
              model: controller.forms.key('bank3_jkt'),
            ),

            LzForm.input(
              label: 'Rekening 3 (JKT)',
              model: controller.forms.key('rek3_jkt'),
            ),
          ],
        );
      }),
    );
  }
}
