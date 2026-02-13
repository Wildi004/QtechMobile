import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/aset_elektronik.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Aset%20Elektronik/aset_elektronik_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class DetailAsetElektronikView extends GetView<AsetElektronikController> {
  final AsetElektronik? data;

  const DetailAsetElektronikView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    if (data != null) {
      final json = data!.toJson();
      json['harga'] = formatRupiah(json['harga']);
      forms.fill(json);
    }

    final image = data?.image;
    final image2 = data?.image2;
    controller.setToken();

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Detail Aset Elektronik',
      ).appBar,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: LzListView(
                gap: 10,
                children: [
                  LzForm.input(
                    enabled: false,
                    label: 'Kode Aset',
                    model: forms.key('kode_asset'),
                  ),
                  LzForm.input(
                    maxLines: 99,
                    enabled: false,
                    label: 'Nama Aset',
                    model: forms.key('nama_asset'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Kondisi',
                    model: forms.key('kondisi'),
                  ),
                  LzForm.input(
                    enabled: false,
                    maxLines: 99,
                    label: 'Merk',
                    model: forms.key('merk'),
                  ),
                  LzForm.input(
                    maxLines: 99,
                    enabled: false,
                    label: 'Penanggung Jawab',
                    model: forms.key('penanggung_jawab_name'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Tanggal Beli',
                          model: forms.key('tgl_beli'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Tanggal Pemberian',
                          model: forms.key('tgl_pemberian'),
                        ),
                      ),
                    ],
                  ),
                  LzForm.input(
                    enabled: false,
                    maxLines: 99,
                    label: 'Harga',
                    model: forms.key('harga'),
                  ),
                  Row(
                    children: [
                      LzImage(image,
                          radius: 40,
                          fit: BoxFit.contain,
                          previewable: true,
                          size: 100,
                          headers: {
                            'Authorization': 'Bearer ${controller.token}'
                          }),
                      20.width,
                      LzImage(image2,
                          radius: 40,
                          fit: BoxFit.contain,
                          previewable: true,
                          size: 100,
                          headers: {
                            'Authorization': 'Bearer ${controller.token}'
                          }),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Keterangan',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      10.height,
                      Html(
                        data: data?.keterangan ?? '',
                        style: {
                          "body": Style(
                            fontSize: FontSize(14),
                            margin: Margins.all(0),
                            padding: HtmlPaddings.all(0),
                          ),
                        },
                      ),
                    ],
                  ),
                  20.height,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String formatRupiah(dynamic value) {
  if (value == null || value.toString().isEmpty) return 'Rp 0';

  final number = int.tryParse(value.toString()) ?? 0;

  return NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  ).format(number);
}
