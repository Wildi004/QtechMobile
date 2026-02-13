import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/kartu_stok.dart';
import 'package:qrm_dev/app/modules/home/controllers/Logistik%20Jakarta/Kartu%20Stok%20Jkt/kartu_stok_logistik_jkt_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class KartuStokJktByStrView extends GetView<KartuStokLogistikJktController> {
  final String? kodeStr;
  final KartuStok? data;

  const KartuStokJktByStrView({super.key, this.kodeStr, this.data});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (kodeStr != null) controller.getDetail(kodeStr!);
    });

    return Scaffold(
      appBar: CustomAppbar(title: 'Kartu Stok').appBar,
      body: Column(
        children: [
          if (data != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: LzCard(
                color: Colors.blue.shade50,
                children: [
                  DetailText(
                    title: "Brand Material",
                    value: data?.materialBrand ?? '-',
                  ),
                  DetailText(
                    title: "Kode Material",
                    value: data?.kodeMaterial ?? '-',
                  ),
                  DetailText(
                    title: "Nama Material",
                    value: data?.namaMaterial ?? '-',
                  ),
                  DetailText(
                    title: "Harga",
                    value: formatRupiah(data?.materialHargaModal),
                  ),
                ],
              ),
            ),

          // 🔽 List scrollable di bawahnya
          Expanded(
            child: Obx(() {
              if (controller.isDetailLoading.value) {
                return const Center(child: CustomLoading());
              }

              if (controller.detailDatas.isEmpty) {
                return Empty(
                  message: "Data tidak ditemukan",
                  onTap: () {
                    if (kodeStr != null) controller.getDetail(kodeStr!);
                  },
                );
              }

              return LzListView(
                padding: Ei.sym(h: 16, v: 10),
                onRefresh: () async {
                  if (kodeStr != null) await controller.getDetail(kodeStr!);
                },
                children: [
                  ...controller.detailDatas.generate((item, i) {
                    final label = controller.getLabel(item);
                    final noBukti = controller.getNoBukti(item);

                    return Padding(
                      padding: Ei.sym(v: 10),
                      child: InkWell(
                        onTap: () {
                          controller.openDetailByNoHide(item);
                        },
                        child: LzCard(
                          children: [
                            DetailText(
                              title: "Tanggal",
                              value: item.tgl ?? '-',
                            ),
                            if (label != null && noBukti != null) ...[
                              RichText(
                                text: TextSpan(
                                  text: "Jenis: ",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: label,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          controller.openDetailByNoHide(item);
                                        },
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "No Bukti: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      noBukti,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        controller.openDetailByNoHide(item),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              4), // jarak kecil antara teks dan ikon
                                      child: Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            DetailText(
                              title: "Masuk",
                              value: item.masuk?.toString() ??
                                  '-', // ✅ ubah jadi String
                            ),
                            DetailText(
                              title: "Keluar",
                              value: item.keluar?.toString() ??
                                  '-', // ✅ ubah jadi String
                            ),
                            const Divider(height: 20),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

String formatRupiah(String? value) {
  if (value == null || value.isEmpty) return '-';
  try {
    final number = int.parse(value);
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(number);
  } catch (e) {
    return value;
  }
}

class DetailText extends StatelessWidget {
  final String title;
  final String value;

  const DetailText({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "$title: ",
        style: const TextStyle(fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
