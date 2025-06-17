import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ContextExtensionss;
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/services/image_file_token.dart';
import 'package:qrm/app/data/services/storage/auth.dart';
import 'package:qrm/app/modules/bonus_karyawan/views/bonus_karyawan_view.dart';
import 'package:qrm/app/modules/buku_bank/views/buku_bank_view.dart';
import 'package:qrm/app/modules/cuti/views/cuti_view.dart';
import 'package:qrm/app/modules/password/views/password_view.dart';
import 'package:qrm/app/modules/pengaturan/views/pengaturan_view.dart';
import 'package:qrm/app/modules/settings/controllers/settings_controller.dart';
import 'package:qrm/app/modules/settings/views/image.dart';
import '../../data_diri/views/form_profile_view.dart';

class SettingsView extends GetView<SettingsController> with Apis {
  SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final SettingsController controller = Get.put(SettingsController());

    return Scaffold(
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.3,
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: ['4CA1AF'.hex, '808080'.hex],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                border: Border.all(color: Colors.black),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.08,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(() {
                          final imageController = Get.find<ImageFileToken>();
                          final bytes = imageController.imageBytes.value;
                          final url = controller.user.value?.image ?? '';

                          return GestureDetector(
                            onTap: () {
                              if (bytes != null) {
                                // Kirim bytes ke fullscreen biar langsung tampil
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 600),
                                    reverseTransitionDuration:
                                        Duration(milliseconds: 600),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        FullScreenImageView(
                                            imageBytes: bytes, imageUrl: url),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return child;
                                    },
                                  ),
                                );
                              } else if (url.isNotEmpty) {
                                // Kalau bytes belum ada, fallback ke url langsung
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FullScreenImageView(imageUrl: url),
                                  ),
                                );
                              }
                            },
                            child: Hero(
                              tag: 'imageHero',
                              child: bytes != null
                                  ? Image.memory(
                                      bytes,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.grey[300],
                                      child: Icon(Icons.person),
                                    ),
                            ),
                          );
                        }),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.height * 0.02),
                  Transform.translate(
                    offset: Offset(
                      -MediaQuery.of(context).size.height * 0.03,
                      90,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                            future: Auth.user(),
                            builder: (context, snap) {
                              final user = snap.data;

                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  '${user?.name}',
                                  style:
                                      GoogleFonts.deliciousHandrawn().copyWith(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.027,
                                    fontWeight: Fw.bold,
                                    color: Colors.white,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              );
                            }),
                        FutureBuilder(
                            future: Auth.user(),
                            builder: (context, snap) {
                              final user = snap.data;

                              return SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    0.4, // Sesuaikan lebar
                                child: Text(
                                  '${user?.role}',
                                  style: GoogleFonts.notoSerif().copyWith(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.015,
                                    color: Colors.white,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                color: const Color.fromARGB(0, 131, 15, 15),
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [],
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  width: screenWidth * 0.9,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: ['467BF6'.hex, '5D688A'.hex],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Text(
                          'Februari - 2025',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.025,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Obx(() {
                        final cuti = controller.cuti.value;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildInfoBox("${cuti?.jmlCuti ?? '0'}", "Hari",
                                "Cuti", context),
                            _buildInfoBox("6", "Hari", "Izin", context),
                            _buildInfoBox("1000", "Menit", "Telat", context),
                          ],
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
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
                            'Pengaturan',
                            'Keamanan',
                            'Notifikasi',
                          ].generate((l, i) => Menu(
                              l,
                              [
                                Hi.settings01,
                                Hi.informationDiamond,
                                Hi.informationCircle,
                              ][i])),
                        ),
                        Text('Menu', style: Gfont.fs20.bold),
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
                context.openBottomSheet(const PengaturanView());
                break;
              case 'Data Diri':
                // Get.toNamed(Routes.DATA_DIRI);
                context.openBottomSheet(const FormProfileView());
                break;
              case 'Password':
                context.openBottomSheet(const PasswordView());
                break;
              case 'Buku Bank':
                context.openBottomSheet(BukuBankView());
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

Widget _buildInfoBox(
  final String number,
  final String unit,
  final String label,
  BuildContext context,
) {
  double fontSizes = MediaQuery.of(context).size.width * 0.05;
  return Padding(
    padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.04,
        right: MediaQuery.of(context).size.width * 0.04),
    child: Column(
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: number,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSizes,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: " $unit",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Text(label,
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: Fw.bold)),
      ],
    ),
  );
}
