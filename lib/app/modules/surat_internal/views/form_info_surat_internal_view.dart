import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/surat_internal/controllers/surat_internal_controller.dart';

class FormInfoSuratInternalView extends GetView<SuratInternalController> {
  FormInfoSuratInternalView({
    super.key,
    required this.id,
    required this.nama,
    required this.keterangan,
    required this.image,
    required this.tglUpload,
    required this.userId,
    required this.userName,
  });
  final int? id;
  final String? nama;
  final String? keterangan;
  final String? image;
  final String? tglUpload;
  final int? userId;
  final String? userName;
  final OutlineInputBorder borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.black,
      width: 2,
    ),
  );
  final TextEditingController idController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController tglUploadController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    idController.text = id?.toString() ?? '';
    namaController.text = nama ?? '';
    keteranganController.text = keterangan ?? '';
    imageController.text = image ?? '';
    tglUploadController.text = tglUpload ?? '';
    userIdController.text = userId?.toString() ?? '';
    userNameController.text = userName ?? '';

    Get.lazyPut(() => SuratInternalController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Surat Inernal',
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
            LzButton(
              text: 'Download File PDF',
              onTap: () {},
            ),
            30.height,
            TextFormField(
              readOnly: true,
              controller: namaController,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: 'Nama Surat',
                  labelStyle: TextStyle(fontWeight: Fw.bold),
                  border: borderStyle,
                  focusedBorder: borderStyle.copyWith(
                    borderSide: borderStyle.borderSide.copyWith(
                      color: const Color.fromARGB(255, 0, 61, 230),
                      width: 2,
                    ),
                  )),
            ),
            30.height,
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
            30.height,
            TextFormField(
              readOnly: true,
              controller: userNameController,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: 'Di Buat Oleh',
                  labelStyle: TextStyle(fontWeight: Fw.bold),
                  border: borderStyle,
                  focusedBorder: borderStyle.copyWith(
                    borderSide: borderStyle.borderSide.copyWith(
                      color: const Color.fromARGB(255, 0, 61, 230),
                      width: 2,
                    ),
                  )),
            ),
            30.height,
            TextFormField(
              readOnly: true,
              controller: keteranganController,
              maxLines: 3,
              decoration: InputDecoration(
                  labelText: 'Keterangan',
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
