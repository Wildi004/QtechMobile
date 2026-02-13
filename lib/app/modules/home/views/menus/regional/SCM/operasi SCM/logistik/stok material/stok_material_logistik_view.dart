import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/stok_material.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Stok%20Material/stok_material_logistik_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/stok%20material/create_stok_material_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/stok%20material/edit_stok_material_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/stok%20material/stok_material_logistik_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_rupiah.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class StokMaterialLogistikView extends GetView<StokMaterialLogistikController> {
  const StokMaterialLogistikView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => StokMaterialLogistikController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    final icons = [
      Hi.view,
      Hi.edit01,
      Hi.delete01,
    ];

    final options = DropOption.of(
      ['Info', 'Edit', 'Delete'],
      critical: ['Delete'],
      icons: icons,
      focused: [1],
    );
    return Unfocuser(
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Stok Material',
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => CreateStokMaterialLogistikView())?.then((data) {
                    if (data != null) {
                      controller.insertData(StokMaterial.fromJson(data));
                    }
                  });
                },
                icon: Icon(Hi.add01))
          ],
        ).appBar,
        resizeToAvoidBottomInset: false,
        body: Obx(() {
          bool isLoading = controller.isLoading.value;
          final data = controller.data;

          if (isLoading) {
            return Center(child: CustomLoading());
          }

          if (data.isEmpty) {
            return Empty(
              message: 'Tidak ada Surat Keluar.',
              onTap: () => controller.getData(),
            );
          }

          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: SearchQuery.searchInput(
                        onChanged: controller.updateSearchQuery,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: LzListView(
                  padding: Ei.sym(
                    h: 20,
                  ),
                  onRefresh: () => controller.getData(),
                  onScroll: (scroll) {
                    if (scroll.atBottom(100)) {
                      controller.onPaginate();
                    }
                  },
                  children: [
                    SizedBox(height: 10),
                    ...data.generate((item, i) {
                      return Droplist(
                        options: options,
                        builder: (key, action) {
                          return CustomScalaContainer(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                key:
                                    key, // penting supaya droplist tau element yg dibungkus
                                width: itemWidth,
                                padding: const EdgeInsets.all(10),
                                decoration: CustomDecoration.validator(),
                                child: Column(
                                  crossAxisAlignment: Caa.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: Maa.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.namaMaterialName ?? '-',
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins()
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontWeight: Fw.bold),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            action.show((value) {
                                              if (value.index == 0) {
                                                Get.to(() =>
                                                    StokMaterialLogistikDetailView(
                                                        data: item))?.then(
                                                    (value) {});
                                              } else if (value.index == 1) {
                                                Get.to(() =>
                                                    EditStokMaterialLogistikView(
                                                        data: item))?.then(
                                                    (value) {
                                                  if (value != null) {
                                                    controller.updateData(
                                                      StokMaterial.fromJson(
                                                          value),
                                                      item.id!,
                                                    );
                                                  }
                                                });
                                              } else if (value.index == 2) {
                                                CustomDelete.show(
                                                  context: context,
                                                  title: 'Konfirmasi Hapus',
                                                  message:
                                                      'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                                  onConfirm: () {
                                                    controller
                                                        .deleteData(item.id!);
                                                  },
                                                );
                                              }
                                            });
                                          },
                                          icon: Icon(Hi.leftToRightListBullet),
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Stok : ',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          TextSpan(
                                            text: '${item.qty}',
                                            style:
                                                GoogleFonts.poppins().copyWith(
                                              color: Colors.white,
                                              fontWeight: Fw.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Harga Pembelian : ',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          CurrencyHelper.formatRupiah(
                                              item.hargaBeli),
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins().copyWith(
                                            color: Colors.white,
                                            fontWeight: Fw.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                    Obx(() =>
                        CustomLoading().lz.hide(!controller.isPaginate.value)),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
