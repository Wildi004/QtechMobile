import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/hrd_cuti.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';
import 'package:qrm_dev/app/modules/settings/views/menus%20setting/cuti/controllers/cuti_controller.dart';
import 'package:qrm_dev/app/modules/settings/views/menus%20setting/cuti/views/cuti_detail_view.dart';
import 'package:qrm_dev/app/modules/settings/views/menus%20setting/cuti/views/cuti_form.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class CutiView extends GetView<CutiController> {
  const CutiView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CutiController());
    return Scaffold(
      appBar: CustomAppbar(title: "Cuti"),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              _buildHeader(context),
              Positioned(
                top: MediaQuery.of(context).size.width * 0.18,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: _buildCutiInfo(context),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.2),
          Expanded(
            child: Obx(() {
              final data = controller.listCutiObs;

              if (data.isEmpty) {
                return Center(
                  child: Text(
                    'Belum ada pengajuan cuti',
                    style: TextStyle(color: Colors.black54),
                  ),
                );
              }

              return LzListView(
                padding: Ei.sym(h: 20, v: 20),
                onRefresh: () => controller.getData(),
                onScroll: (scroll) {
                  if (scroll.atBottom(100)) {
                    controller.onPaginate();
                  }
                },
                children: [
                  ...data.generate((item, i) {
                    return ListItemAnimasi(
                      index: i,
                      beginOffset: const Offset(-0.3, 0),
                      child: CustomScalaContainer(
                        child: Touch(
                          onTap: () {
                            Get.to(() => CutiDetailView(data: item));
                          },
                          margin: Ei.only(b: 10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: CustomDecoration.validator(),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.perihal ?? '-',
                                        style: CustomTextStyle.title(),
                                      ),
                                      Text(
                                        item.tglCuti ?? '-',
                                        style: CustomTextStyle.subtitle(),
                                      ),
                                      10.height,
                                      Intrinsic(children: [
                                        Text(
                                          'Validasi HRD :',
                                          style: CustomTextStyle.title(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Validasi Dir. BSD :',
                                          style: CustomTextStyle.title(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ]),
                                      Intrinsic(children: [
                                        Text(
                                          statusText(item.statusHrd),
                                          style: CustomTextStyle.subtitle(
                                            color:
                                                statusBgColor(item.statusHrd),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          statusText(item.statusDirKeuangan),
                                          style: CustomTextStyle.subtitle(
                                            color: statusBgColor(
                                                item.statusDirKeuangan),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ])
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  Obx(() =>
                      CustomLoading().lz.hide(!controller.isPaginate.value)),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 28,
              spreadRadius: 2,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Container(
          height: width * 0.28,
          padding: EdgeInsets.symmetric(vertical: width * 0.04),
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Color(0xFFF2F2F2),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: Auth.user(),
                  builder: (context, snap) {
                    final user = snap.data;
                    return SizedBox(
                      width: width * 0.8,
                      child: Text(
                        user?.name ?? '',
                        style: TextStyle(
                          fontSize: height * 0.025,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 4),
                FutureBuilder(
                  future: Auth.user(),
                  builder: (context, snap) {
                    final user = snap.data;
                    return Text(
                      user?.role ?? '',
                      style: TextStyle(
                        fontSize: height * 0.014,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCutiInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                    vertical: MediaQuery.of(context).size.width * 0.03),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 224, 224, 224)),
                child: Obx(() {
                  final cuti = controller.cuti.value;
                  return Text.rich(TextSpan(
                    children: [
                      TextSpan(
                        text: "Sisa Cuti Anda ",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "${cuti?.jmlCuti ?? '0'} ",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.055,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "Hari",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ));
                }),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.04),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 224, 224, 224),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.04),
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.04,
                      MediaQuery.of(context).size.width * 0.04),
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.35,
                      MediaQuery.of(context).size.width * 0.14),
                ),
                onPressed: () async {
                  final data = await Get.to(() => const CutiForm());

                  if (data != null) {
                    controller.insertData(HrdCuti.fromJson(data));
                  }
                },
                icon: Icon(Hi.addCircle,
                    color: Colors.black,
                    size: MediaQuery.of(context).size.width * 0.06),
                label: Text("Ajukan",
                    style: TextStyle(color: Colors.black, fontSize: 16)),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.03),
          Column(
            children: [
              Text(
                "Sisa cuti anda akan di reset kembali pada akhir tahun.",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    color: Colors.black54),
              ),
              Text(
                "Semakin lama anda cuti, semakin banyak potongan Gaji.",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    color: Colors.black54,
                    fontWeight: Fw.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String statusText(int? status) {
  switch (status) {
    case 0:
      return 'Belum Validasi';
    case 1:
      return 'Sudah Validasi';
    case 2:
      return 'Tolak';
    default:
      return '-';
  }
}

Color statusBgColor(int? status) {
  switch (status) {
    case 0:
      return Colors.orange;
    case 1:
      return Colors.green;
    case 2:
      return Colors.red;
    default:
      return Colors.grey;
  }
}
