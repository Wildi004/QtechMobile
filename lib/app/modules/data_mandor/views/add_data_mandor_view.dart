import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/data_mandor/data_mandor.dart';
import 'package:qrm/app/modules/surat_internal/controllers/surat_internal_controller.dart';

class AddDataMandorView extends GetView<DataMandor> {
  AddDataMandorView({
    super.key,
  });

  final OutlineInputBorder borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.black,
      width: 2,
    ),
  );

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SuratInternalController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Data Mandor',
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
            TextFormField(
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: 'Nama',
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
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: 'Nomor KTP',
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
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: 'Nomor HP',
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
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: 'Alamat KTP',
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
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: 'Alamat Domisili',
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
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: 'Status',
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
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Penilaian Harga (0-20)',
                        labelStyle: TextStyle(fontWeight: Fw.bold),
                        border: borderStyle,
                        focusedBorder: borderStyle.copyWith(
                          borderSide: borderStyle.borderSide.copyWith(
                            color: const Color.fromARGB(255, 0, 61, 230),
                            width: 2,
                          ),
                        )),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: ' Kualitas Pekerjaan (0-20)',
                        labelStyle: TextStyle(fontWeight: Fw.bold),
                        border: borderStyle,
                        focusedBorder: borderStyle.copyWith(
                          borderSide: borderStyle.borderSide.copyWith(
                            color: const Color.fromARGB(255, 0, 61, 230),
                            width: 2,
                          ),
                        )),
                  ),
                ),
              ],
            ),
            15.height,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Ketepatan Waktu (0-20)',
                        labelStyle: TextStyle(fontWeight: Fw.bold),
                        border: borderStyle,
                        focusedBorder: borderStyle.copyWith(
                          borderSide: borderStyle.borderSide.copyWith(
                            color: const Color.fromARGB(255, 0, 61, 230),
                            width: 2,
                          ),
                        )),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: ' Kepatuhan Safety (0-20)',
                        labelStyle: TextStyle(fontWeight: Fw.bold),
                        border: borderStyle,
                        focusedBorder: borderStyle.copyWith(
                          borderSide: borderStyle.borderSide.copyWith(
                            color: const Color.fromARGB(255, 0, 61, 230),
                            width: 2,
                          ),
                        )),
                  ),
                ),
              ],
            ),
            15.height,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Penilaian Komunikasi (0-20)',
                        labelStyle: TextStyle(fontWeight: Fw.bold),
                        border: borderStyle,
                        focusedBorder: borderStyle.copyWith(
                          borderSide: borderStyle.borderSide.copyWith(
                            color: const Color.fromARGB(255, 0, 61, 230),
                            width: 2,
                          ),
                        )),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Spesialis Pekerjaan (0-20)',
                        labelStyle: TextStyle(fontWeight: Fw.bold),
                        border: borderStyle,
                        focusedBorder: borderStyle.copyWith(
                          borderSide: borderStyle.borderSide.copyWith(
                            color: const Color.fromARGB(255, 0, 61, 230),
                            width: 2,
                          ),
                        )),
                  ),
                ),
              ],
            ),
            15.height,
            TextFormField(
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: 'Nilai Total',
                  labelStyle: TextStyle(fontWeight: Fw.bold),
                  border: borderStyle,
                  focusedBorder: borderStyle.copyWith(
                    borderSide: borderStyle.borderSide.copyWith(
                      color: const Color.fromARGB(255, 0, 61, 230),
                      width: 2,
                    ),
                  )),
            ),
            20.height,
            LzButton(
              text: 'Simpan',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
