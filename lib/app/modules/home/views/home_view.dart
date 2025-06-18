// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/services/storage/auth.dart';
import 'package:qrm/app/modules/capaian_kinerja/views/capaian/capaian_view.dart';
import 'package:qrm/app/modules/harga_modal_logistik/views/harga_modal_logistik_view.dart';
import 'package:qrm/app/modules/home/views/menus/regional/admin_view.dart';
import 'package:qrm/app/modules/home/views/menus/regional/bsd.dart';
import 'package:qrm/app/modules/home/views/menus/regional/finance_pusat.dart';
import 'package:qrm/app/modules/home/views/menus/regional/reg_barat.dart';
import 'package:qrm/app/modules/home/views/menus/regional/reg_pusat.dart';
import 'package:qrm/app/modules/home/views/menus/regional/reg_timur.dart';
import 'package:qrm/app/modules/kasbon/views/kasbon_test_vies.dart';
import 'package:qrm/app/modules/menu_edit/views/menu_edit_view.dart';
import 'package:qrm/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: LzListView(
        onRefresh: () => controller.onPageInit(),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: MediaQuery.of(context).size.width * 0.088,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LzImage(
                'ic_launcher.png',
                size: MediaQuery.of(context).size.height * 0.06,
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Hi.notification01,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: MediaQuery.of(context).size.width * 0.07,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    onPressed: () {
                      context.confirm(
                          title: 'Konfirmasi Logout',
                          message:
                              'Apakah Anda yakin ingin keluar dari akun ini?',
                          onConfirm: () => controller.logout());
                    },
                    icon: Icon(
                      Icons.logout,
                      size: MediaQuery.of(context).size.width * 0.07,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Center(
            child: Container(
              width: screenWidth * 0.9,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: ['4CA1AF'.hex, '808080'.hex],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 115, 115, 119),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                        future: Auth.user(),
                        builder: (context, snap) {
                          final user = snap.data;
                          return Text(
                            'Hi! ${user?.name}',
                            style: GoogleFonts.deliciousHandrawn().copyWith(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.08,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                    FutureBuilder(
                        future: Auth.user(),
                        builder: (context, snap) {
                          final user = snap.data;
                          return Text(
                            '${user?.role}',
                            style: GoogleFonts.notoSerif().copyWith(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Sisa Saldo',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Align(
                      child: Text(
                        'Rp 100,000,000-,',
                        style: GoogleFonts.libreBaskerville().copyWith(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.035,
                            fontWeight: Fw.bold),
                      ),
                    ),
                    // Obx(() {
                    //   final user = controller.user.value;

                    //   // contoh tanggal lahir
                    //   return LzCard(
                    //     style: LzCardStyle(stacked: true),
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Text(user?.alamatKtp ?? '-'),
                    //         ],
                    //       ).between,
                    //       Text(user?.agama ?? '-')
                    //     ],
                    //   );
                    // })
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.24,
            child: Obx(
              () => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final item = controller.items[index];

                  return Container(
                    width: MediaQuery.of(context).size.width * 0.49,
                    margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.025,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: ['467BF6'.hex, '5D688A'.hex],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        top: 10),
                    child: Column(
                      crossAxisAlignment: Caa.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (item['title']!.isNotEmpty)
                          Text(
                            item['title']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.007,
                        ),
                        if (item['date']!.isNotEmpty)
                          Text(
                            item['date']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.025,
                            ),
                          ),
                        if (item['location']!.isNotEmpty) ...[
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.036,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined,
                                  color: Colors.white),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              Text(
                                item['location']!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.026,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Menu Favorite",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
              TextButton(
                onPressed: () {
                  context.openBottomSheet(MenuEditView());
                },
                child: Text(
                  "Edit",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
              ),
            ],
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: MediaQuery.of(context).size.width * 0.01,
            runSpacing: MediaQuery.of(context).size.width * 0.03,
            children: List.generate(4, (i) {
              final label = [
                'Kasbon',
                'Capaian Kinerja',
                'Modal Logistik',
                'Notulen'
              ];

              final colors = [
                '5D688A'.hex,
                '4CA1AF'.hex,
                '9f68dd'.hex,
                '467bf6'.hex,
              ];
              final icons = [
                Hi.note,
                Hi.chartLineData02,
                Hi.note01,
                Hi.fileAttachment,
              ];
              return LayoutBuilder(
                builder: (context, constraints) {
                  double containerSize = constraints.maxWidth * 0.2;
                  double iconSize = constraints.maxWidth * 0.095;
                  return SizedBox(
                    width: containerSize * 1.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (i == 0) {
                              Get.to(() => KasbonTestVies(),
                                  transition: Transition.rightToLeft);
                            } else if (i == 1) {
                              context.openBottomSheet(CapaianView());
                            } else if (i == 2) {
                              Get.to(() => HargaModalLogistikView(),
                                  transition: Transition.fade);
                            } else if (i == 3) {
                              Get.toNamed(Routes.NOTULEN);
                            }
                          },
                          child: Container(
                            width: containerSize,
                            height: containerSize * 0.8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors[i],
                            ),
                            child: Icon(
                              icons[i],
                              color: Colors.white,
                              size: iconSize,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          label[i],
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: containerSize * 0.18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Column(
            children: [
              Row(
                crossAxisAlignment: Caa.start,
                children: [
                  Text(
                    "Menu Regional",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Obx(() {
                int active = controller.tabIndex.value;

                return LayoutBuilder(
                  builder: (context, constraints) {
                    double screenWidth = constraints.maxWidth;
                    double paddingV = screenWidth * 0.01;
                    double paddingH = screenWidth * 0.02;
                    double marginL = screenWidth * 0.02;
                    double borderRadius = screenWidth * 0.05;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: LzTabView(
                            tabs: const [
                              'Admin',
                              'CEO',
                              'BSD',
                              'Finance Pusat',
                              'Teknik',
                              'Regional Barat',
                              'Regional Timur'
                            ],
                            onTap: (key, i) {
                              controller.tabIndex.value = i;
                            },
                            builder: (label, i) {
                              bool isActive = active == i;

                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: paddingV, horizontal: paddingH),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? Color(0xFF467BF6)
                                      : const Color.fromARGB(
                                          255, 243, 238, 238),
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                margin:
                                    EdgeInsets.only(left: i == 0 ? 0 : marginL),
                                child: Text(
                                  label,
                                  style: TextStyle(
                                    color:
                                        isActive ? Colors.white : Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
              SizedBox(height: MediaQuery.of(context).size.width * 0.02),
              Obx(() {
                int tab = controller.tabIndex.value;

                return LayoutBuilder(
                  builder: (context, constraints) {
                    double containerHeight = constraints.maxWidth * 0.4;

                    Map<int, Widget> menus = {
                      0: SizedBox(height: containerHeight, child: AdminView()),
                      1: SizedBox(height: containerHeight, child: RegPusat()),
                      2: SizedBox(height: containerHeight, child: Bsd()),
                      3: SizedBox(
                          height: containerHeight, child: FinancePusat()),
                      4: SizedBox(
                          height: containerHeight,
                          child: Center(child: Text("Belum ada data"))),
                      5: SizedBox(height: containerHeight, child: RegBarat()),
                      6: SizedBox(height: containerHeight, child: RegTimur()),
                    };

                    return menus[tab] ??
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('Masih dalam tahap pengembangan'),
                        );
                  },
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
