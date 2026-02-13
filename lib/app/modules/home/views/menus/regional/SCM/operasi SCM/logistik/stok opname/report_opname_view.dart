import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Stok%20Opname/stok_opname_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class ReportOpnameView extends GetView<StokOpnameController> {
  final int? dataId;

  const ReportOpnameView({super.key, this.dataId});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (dataId != null) {
        controller.getDetail(dataId!);
      }
    });

    return Scaffold(
      appBar: CustomAppbar(title: 'Detail Opname').appBar,
      body: Obx(() {
        if (controller.isDetailLoading.value) {
          return const Center(child: CustomLoading());
        }

        if (controller.detailDatas.isEmpty) {
          return Empty(
            message: "Data tidak ditemukan",
            onTap: () {
              if (dataId != null) controller.getDetail(dataId!);
            },
          );
        }

        return LzListView(
          padding: Ei.sym(h: 16, v: 10),
          onRefresh: () async {
            if (dataId != null) {
              await controller.getDetail(dataId!);
            }
          },
          children: [
            ...controller.detailDatas.generate((item, i) {
              return Padding(
                  padding: Ei.sym(h: 10, v: 10),
                  child: LzCard(children: [
                    DetailText(
                        title: "Kode Material",
                        value: item.kodeMaterial ?? '-'),
                    DetailText(
                        title: "Nama Barang",
                        value: item.namaMaterialName ?? '-'),
                    DetailText(
                        title: "Qty Saat Ini", value: "${item.qty ?? 0}"),
                    DetailText(title: "Delpo", value: "${item.jmlpo ?? 0}"),
                    DetailText(
                        title: "Delpo Non", value: "${item.jmlpoNon ?? 0}"),
                    DetailText(
                        title: "Del Pembelian",
                        value: "${item.jmlpembelian ?? 0}"),
                    DetailText(
                        title: "Del Pembelian Non",
                        value: "${item.jmlpembelianNon ?? 0}"),
                    DetailText(title: "Return", value: "${item.jmlretur ?? 0}"),
                    DetailText(title: "SJ Int", value: "${item.jmlsjin ?? 0}"),
                    DetailText(title: "SJ Eks", value: "${item.jmlsjeks ?? 0}"),
                    DetailText(
                        title: "SJ Eks Non", value: "${item.jmlsjeksnon ?? 0}"),
                    DetailText(title: "Sisa Stok", value: "0"),
                  ]));
            }),
          ],
        );
      }),
    );
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
