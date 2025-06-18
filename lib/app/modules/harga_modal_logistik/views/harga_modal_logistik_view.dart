import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/modal_logistik.dart';
import 'package:qrm/app/modules/harga_modal_logistik/controllers/harga_modal_logistik_controller.dart';
import 'package:qrm/app/modules/harga_modal_logistik/views/edit_harga_modal_view.dart';
import 'package:qrm/app/modules/harga_modal_logistik/views/form_harga_modal_view.dart';
import 'package:qrm/app/modules/harga_modal_logistik/views/modal_logistik_detail.dart';

class HargaModalLogistikView extends StatelessWidget {
  final HargaModalLogistikController controller =
      Get.put(HargaModalLogistikController());

  HargaModalLogistikView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Harga Modal',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: ['4CA1AF'.hex, '808080'.hex],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: controller.updateSearchQuery,
                    decoration: InputDecoration(
                      hintText: "Cari...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                LzButton(
                  icon: Hi.addSquare,
                  onTap: () {
                    Get.to(() => FormHargaModalView())?.then((data) {
                      if (data != null) {
                        controller.insertData(ModalLogistik.fromJson(data));
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: Obx(() {
                bool isLoading = controller.isLoading.value;
                final logistik = controller.rxHargaModal;
                final itemWidth = MediaQuery.of(context).size.width - 30;

                if (isLoading) {
                  return Center(child: LzLoader.bar());
                }

                if (logistik.isEmpty) {
                  return Empty(
                    message: 'Tidak ada data apa pun.',
                    onTap: () => controller.getLogistik(),
                  );
                }

                return LzListView(
                    padding: Ei.sym(v: 20),
                    onRefresh: () => controller.getLogistik(),
                    onScroll: (scroll) {
                      if (scroll.atBottom(100)) {
                        controller.onPaginate();
                      }
                    },
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: logistik.map((data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Material(
                                color:
                                    Colors.red, // supaya tidak menimpa gradient
                                borderRadius: BorderRadius.circular(15),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => ModalLogistikDetail(
                                          id: data.id,
                                          kodeMaterial: data.kodeMaterial,
                                          nama: data.nama,
                                          tglInput: data.tglInput,
                                          tglBerlaku: data.tglBerlaku,
                                          qty: data.qty,
                                          satuan: data.satuan,
                                          hargaSatuan: data.hargaSatuan,
                                          hargaDiskon: data.hargaDiskon,
                                          ppn: data.ppn,
                                          totalPpn: data.totalPpn,
                                          subTotal: data.subTotal,
                                          ongkir: data.ongkir,
                                          hargaModal: data.hargaModal,
                                          lokasi: data.lokasi,
                                          userId: data.userId,
                                          supplier: data.supplier,
                                          keterangan: data.keterangan,
                                          userName: data.userName,
                                          supplierName: data.supplierName,
                                        ));
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    width: itemWidth,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color.fromARGB(
                                              255, 54, 145, 220),
                                          const Color.fromARGB(
                                              255, 73, 173, 255),
                                          const Color.fromARGB(255, 14, 63, 210)
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            data.kodeMaterial ?? 'tidak ada',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Get.to(() => EditHargaModalView(
                                                    data: data))?.then((value) {
                                                  if (value != null) {
                                                    controller.updateData(
                                                        ModalLogistik.fromJson(
                                                            value),
                                                        data.id!);
                                                  }
                                                });
                                              },
                                              icon: Icon(Hi.edit01,
                                                  color: Colors.white),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Get.defaultDialog(
                                                  title: 'Konfirmasi',
                                                  titleStyle: TextStyle(
                                                      fontWeight: Fw.bold),
                                                  middleText:
                                                      'Apakah Anda yakin ingin menghapus data ini?',
                                                  middleTextStyle: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.018,
                                                  ),
                                                  textConfirm: 'Ya',
                                                  buttonColor: Colors.blue,
                                                  textCancel: 'Batal',
                                                  confirmTextColor:
                                                      Colors.white,
                                                  onConfirm: () {
                                                    Get.back();
                                                    controller
                                                        .deleteData(data.id!);
                                                  },
                                                );
                                              },
                                              icon: Icon(Hi.delete02,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        }).toList(),
                      ),
                      Obx(() =>
                          LzLoader.bar().lz.hide(!controller.isPaginate.value))
                    ]);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
