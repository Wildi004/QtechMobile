import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrm_dev/app/data/models/notulen/notulen.dart';
import 'package:qrm_dev/app/modules/notulen/controllers/notulen_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';

class DetailNotulen extends GetView<NotulenController> {
  final Notulen? data;
  const DetailNotulen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.put(NotulenController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Notulen Detail',
      ).appBar,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: LzListView(
                gap: 20,
                children: [
                  LzForm.input(
                    enabled: false,
                    label: 'Judul',
                    maxLines: 99,
                    model: forms.key('judul'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Sifat',
                          model: forms.key('sifat'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Tanggal Rapat',
                          model: forms.key('tgl_rapat'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LzForm.input(
                          enabled: false,
                          label: 'Departemen',
                          model: forms.key('departemen'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            LzForm.input(
                              enabled: false,
                              label: 'Jumlah Peserta',
                              model: forms.key('jml_peserta'),
                            ),
                            Positioned(
                              right: 10,
                              top: 23,
                              bottom: 0,
                              child: IconButton(
                                icon: const Icon(Hi.eye),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (_) {
                                      final detail = data?.notulenDetail ?? [];

                                      return DraggableScrollableSheet(
                                        expand: false,
                                        initialChildSize: 0.9,
                                        minChildSize: 0.3,
                                        maxChildSize: 0.9,
                                        builder: (context, scrollController) {
                                          return Container(
                                            padding: const EdgeInsets.all(20),
                                            child: SingleChildScrollView(
                                              controller: scrollController,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 10),
                                                  if (detail.isEmpty)
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      decoration:
                                                          CustomDecoration
                                                              .validator(),
                                                      child: const Text(
                                                        'Tidak ada data peserta',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )
                                                  else
                                                    ...detail.map((e) {
                                                      return Column(
                                                        children: [
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12),
                                                            decoration:
                                                                CustomDecoration
                                                                    .validator(),
                                                            child: Text(
                                                              '${e.userName ?? '-'} (${e.roleName})',
                                                              style:
                                                                  CustomTextStyle
                                                                      .title(),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                        ],
                                                      );
                                                    }),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hasil Diskusi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 6),
                      FutureBuilder(
                        future: _handleIsi(context, data),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return snapshot.data ?? SizedBox();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<Widget> _handleIsi(BuildContext context, Notulen? data) async {
  String rawIsi = data?.isi ?? '';

  String isi = rawIsi
      .replaceAll('&nbsp;', ' ')
      .replaceAll(RegExp(r'font-feature-settings:[^;"]+;?'), '')
      .replaceAll(RegExp(r'<span[^>]*>'), '')
      .replaceAll('</span>', '')
      .replaceAll(RegExp(r'<img[^>]*src="data:image/[^"]*"[^>]*>'), '');

  String plainText = isi.replaceAll(RegExp(r'<[^>]*>'), '').trim();

  // GUNAKAN jumlah karakter
  if (plainText.length > 100) {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/notulen_${data!.id}.txt');
    await file.writeAsString(plainText);

    return ElevatedButton(
      child: Text('Hasil Diskusi'),
      onPressed: () async {
        await OpenFilex.open(file.path);
      },
    );
  } else {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Html(
        data: isi,
      ),
    );
  }
}
