import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';
import 'package:qrm_dev/app/modules/settings/views/menus%20setting/bonus_karyawan/controllers/bonus_karyawan_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class BonusKaryawanView extends StatelessWidget {
  final BonusKaryawanController controller = Get.put(BonusKaryawanController());

  BonusKaryawanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppbar(title: 'Bonus Karyawan'),
      body: Column(
        children: [
          _buildHeader(context),
          _buildSaldo(context),
          Expanded(
            // ⬅️ INI KUNCI UTAMA
            child: Obx(() {
              bool isLoading = controller.isloading.value;
              final suratInternal = controller.rxBuku;

              if (isLoading) {
                return Center(child: CustomLoading());
              }

              if (suratInternal.isEmpty) {
                return Empty(
                  message: 'Tidak ada data.',
                  onTap: () => controller.getData(),
                );
              }

              return LzListView(
                padding: Ei.sym(v: 20, h: 20),
                onRefresh: () => controller.getData(),
                onScroll: (scroll) {
                  if (scroll.atBottom(100)) {
                    controller.onPaginate();
                  }
                },
                children: [
                  ...controller.grouped.map((group) {
                    final isOpen = controller.expandedKeys.contains(group.key);

                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            if (isOpen) {
                              controller.expandedKeys.remove(group.key);
                            } else {
                              controller.expandedKeys.add(group.key);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(12),
                            decoration: CustomDecoration.validator(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  group.label,
                                  style: CustomTextStyle.title(),
                                ),
                                Icon(
                                  isOpen
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                ),
                              ],
                            ),
                          ),
                        ),
                        AnimatedCrossFade(
                          duration: 250.ms,
                          crossFadeState: isOpen
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          firstChild: Column(
                            children: group.items.map((item) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, left: 10),
                                child: LzCard(
                                  children: [
                                    Text(
                                      item.name ?? 'tidak di temukan',
                                      style: CustomTextStyle.title(),
                                    ),
                                    Text(
                                      'Keterangan : ${item.keterangan ?? 'tidak ada'}',
                                      style: CustomTextStyle.subtitle(),
                                    ),
                                    Text(
                                      'Jumlah : ${item.jumlah ?? 'tidak ada'}',
                                      style: CustomTextStyle.subtitle(),
                                    ),
                                    Text(
                                      'Tanggal Bonus : ${item.tglBonus ?? 'tidak ada'}',
                                      style: CustomTextStyle.subtitle(),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          secondChild: const SizedBox.shrink(),
                        ),
                      ],
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

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18), // lembut
            blurRadius: 24, // semakin besar = semakin halus
            spreadRadius: 0,
            offset: const Offset(0, 10), // bayangan ke bawah
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: width * 0.04),
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Color.fromARGB(255, 231, 231, 231),
        ),
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
                    style: CustomTextStyle.title(),
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
                  style: CustomTextStyle.subtitle(),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaldo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: ['#5B2A2A'.hex, '#8B4A4A'.hex],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("SISA SALDO ANDA",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            Text(
              "Rp. ,-",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
