import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/company_profile/controllers/profile%20perusahaan%20controller/profile_perusahaan_controller.dart';
import 'package:qrm_dev/app/modules/company_profile/views/icon/icon_perusahaan_view.dart';
import 'package:qrm_dev/app/modules/company_profile/views/logo/logo_company_view.dart';
import 'package:qrm_dev/app/modules/company_profile/views/struktur%20organisai/struktur_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/modules/company_profile/views/profile perusahaan/profile_perusahaan_view.dart';

class CompanyProfileView extends StatelessWidget {
  const CompanyProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Company Profile').appBar,
      body: LzListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AccountOption(
                options: [
                  Menu('Profile Perusahaan', Hi.file01),
                  Menu('Logo', Hi.image01),
                  Menu('Icon', Hi.star),
                  Menu('Struktur Organisasi', Hi.userGroup),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Menu {
  final String label;
  final IconData icon;

  const Menu(this.label, this.icon);
}

class AccountOption extends StatelessWidget {
  final List<Menu> options;
  const AccountOption({super.key, this.options = const []});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfilePerusahaanController());
    return Column(
      children: options.generate((menu, i) {
        return Touch(
          onTap: () {
            switch (menu.label) {
              case 'Profile Perusahaan':
                Get.to(() => const ProfilePerusahaanView(), arguments: 1);
                break;

              case 'Logo':
                Get.to(() => const LogoCompanyView(), arguments: 1);
                break;

              case 'Icon':
                Get.to(() => const IconPerusahaanView(), arguments: 1);

                break;

              case 'Struktur Organisasi':
                Get.to(() => const StrukturView(), arguments: 1);

                break;
            }
          },
          child: Container(
            padding: Ei.sym(v: MediaQuery.of(context).size.width * 0.04),
            decoration: BoxDecoration(
              border: Br.only(['t'], except: i == 0),
            ),
            child: Row(
              children: [
                Textr(
                  menu.label,
                  icon: menu.icon,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
                Icon(
                  Hi.arrowRight01,
                  size: MediaQuery.of(context).size.width * 0.05,
                )
              ],
            ).between,
          ),
        );
      }),
    );
  }
}
