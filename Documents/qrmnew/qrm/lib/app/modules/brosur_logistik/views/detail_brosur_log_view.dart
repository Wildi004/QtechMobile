import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/data_mandor/data_mandor.dart';
import 'package:qrm/app/modules/surat_internal/controllers/surat_internal_controller.dart';

class DetailBrosurLogView extends GetView<DataMandor> {
  DetailBrosurLogView({
    super.key,
    required this.nama,
    required this.tglUpload,
  });
  final String? nama;
  final String? tglUpload;

  final OutlineInputBorder borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.black,
      width: 2,
    ),
  );
  final TextEditingController namaController = TextEditingController();
  final TextEditingController tglUploadController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    namaController.text = nama ?? '';
    tglUploadController.text = tglUpload ?? '';
    Get.lazyPut(() => SuratInternalController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Brosur Logistik',
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
        padding: const EdgeInsets.all(10),
        child: LzListView(
          children: [
            // LzButton(
            //   text: 'Download File PDF',
            //   onTap: () {},
            // ),
            TextFormField(
              readOnly: true,
              controller: namaController,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: 'Nama Brosur',
                  labelStyle: TextStyle(fontWeight: Fw.bold),
                  border: borderStyle,
                  focusedBorder: borderStyle.copyWith(
                    borderSide: borderStyle.borderSide.copyWith(
                      color: const Color.fromARGB(255, 0, 61, 230),
                      width: 2,
                    ),
                  )),
            ),
            15.height,
            TextFormField(
              readOnly: true,
              controller: tglUploadController,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: 'Tanggal Upload',
                  labelStyle: TextStyle(fontWeight: Fw.bold),
                  border: borderStyle,
                  focusedBorder: borderStyle.copyWith(
                    borderSide: borderStyle.borderSide.copyWith(
                      color: const Color.fromARGB(255, 0, 61, 230),
                      width: 2,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
