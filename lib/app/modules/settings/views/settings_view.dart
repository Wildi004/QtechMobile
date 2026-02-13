import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/models/user.dart';
import 'package:qrm_dev/app/modules/settings/views/menus%20setting/bonus_karyawan/views/bonus_karyawan_view.dart';
import 'package:qrm_dev/app/modules/settings/views/menus%20setting/buku_bank/views/buku_bank_view.dart';
import 'package:qrm_dev/app/modules/settings/views/menus%20setting/change%20regional/change_regional.dart';
import 'package:qrm_dev/app/modules/settings/views/menus%20setting/cuti/views/cuti_view.dart';
import 'package:qrm_dev/app/modules/settings/views/menus%20setting/password/views/password_view.dart';
import 'package:qrm_dev/app/modules/settings/controllers/settings_controller.dart';
import 'package:qrm_dev/app/modules/settings/views/setting%20widget/card_profile_setting_view.dart';
import 'package:qrm_dev/app/modules/settings/views/setting%20widget/cuti_profile_setting_view.dart';
import 'package:qrm_dev/app/routes/app_pages.dart';
import 'contoh_view.dart';
import 'menus setting/data_diri/views/form_profile_view.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CardProfileSettingView(),
          SizedBox(
            height: 20,
          ),
          CutiProfileSettingView(),
          Expanded(
            child: LzListView(
              onRefresh: () => controller.getUserLogged(),
              children: [
                GestureDetector(
                  child: Container(
                    child: Column(
                      children: [
                        Text('Umum', style: Gfont.fs20.bold),
                        AccountOption(
                          options: [
                            'Change Regional',
                            'Pengaturan',
                            'Keamanan',
                            'Notifikasi',
                          ].generate((l, i) => Menu(
                              l,
                              [
                                Hi.global,
                                Hi.settings01,
                                Hi.informationDiamond,
                                Hi.informationCircle,
                              ][i])),
                        ),
                        Touch(
                            onTap: () {
                              Get.to(() => ContohView());
                            },
                            child: Text('Menu', style: Gfont.fs20.bold)),
                        AccountOption(
                          options: [
                            'Data Diri',
                            'Password',
                            'Buku Bank',
                            'Bonus',
                            'Cuti'
                          ].generate(
                            (l, i) => Menu(
                                l,
                                [
                                  Hi.user,
                                  Hi.securityPassword,
                                  Hi.bank,
                                  Hi.moneyAdd02,
                                  Hi.noteDone
                                ][i]),
                          ),
                        ),
                      ],
                    ).start.gap(25),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Menu {
  final String label;
  final IconData icon;

  const Menu(this.label, this.icon);

  static List<Menu> list(
      {required List<String> labels, required List<IconData> icons}) {
    return List.generate(labels.length, (i) => Menu(labels[i], icons[i]));
  }
}

class AccountOption extends StatelessWidget {
  final List<Menu> options;
  const AccountOption({super.key, this.options = const []});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.generate((menu, i) {
        return Touch(
          key: ValueKey('menu_$i'),
          onTap: () {
            switch (menu.label) {
              case 'Pengaturan':
                Get.toNamed(Routes.PENGATURAN);

                break;
              case 'Data Diri':
                final controller = Get.find<SettingsController>();
                final user = controller.user.value;

                if (user != null) {
                  Get.to(() => FormProfileView(data: user))?.then((value) {
                    if (value != null) {
                      controller.updateData(User.fromJson(value));
                    }
                  });
                }
                break;

              case 'Password':
                context.openBottomSheet(const PasswordView());
                break;
              case 'Buku Bank':
                context.openBottomSheet(BukuBankView());
                break;
              case 'Change Regional':
                Get.to(() => ChangeRegional());
                break;
              case 'Bonus':
                context.openBottomSheet(BonusKaryawanView());

                break;
              case 'Cuti':
                context.openBottomSheet(CutiView());

                break;
            }
          },
          child: Container(
            padding: Ei.sym(v: MediaQuery.of(context).size.width * 0.04),
            decoration: BoxDecoration(border: Br.only(['t'], except: i == 0)),
            child: Row(
              children: [
                Textr(
                  menu.label,
                  icon: menu.icon,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04),
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
    ).start;
  }
}
