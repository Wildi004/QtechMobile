import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/data_mandor/data_mandor.dart';
import 'package:qrm/app/data/models/data_mandor/detail.dart';
import 'package:qrm/app/modules/surat_internal/controllers/surat_internal_controller.dart';

class EditDataMandorView extends GetView<DataMandor> {
  EditDataMandorView({
    super.key,
    required this.id,
    required this.nama,
    required this.alamatKtp,
    required this.noHp,
    required this.alamatDomisili,
    required this.ktp,
    required this.kode,
    required this.createdAt,
    required this.createdBy,
    required this.status,
    required this.harga,
    required this.ketepatanWaktu,
    required this.kualitasPekerjaan,
    required this.kepatuhanSafety,
    required this.komunikasi,
    required this.nilaiTotal,
    required this.rating,
    required this.spesialis,
    required this.updateBy,
    required this.createdName,
    required this.updateName,
    required this.detail,
  });
  final int? id;
  final String? nama;
  final String? alamatKtp;
  final String? noHp;
  final String? alamatDomisili;
  final String? ktp;
  final String? kode;
  final int? createdAt;
  final int? createdBy;
  final int? status;
  final int? harga;
  final int? ketepatanWaktu;
  final int? kualitasPekerjaan;
  final int? kepatuhanSafety;
  final int? komunikasi;
  final int? nilaiTotal;
  final String? rating;
  final String? spesialis;
  final int? updateBy;
  final String? createdName;
  final String? updateName;
  final List<Detail>? detail;
  final OutlineInputBorder borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.black,
      width: 2,
    ),
  );
  final TextEditingController idController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatKtpC = TextEditingController();
  final TextEditingController noHpC = TextEditingController();
  final TextEditingController alamatDomisiliC = TextEditingController();
  final TextEditingController ktpC = TextEditingController();
  final TextEditingController kodeC = TextEditingController();
  final TextEditingController createdAtC = TextEditingController();
  final TextEditingController createdByC = TextEditingController();
  final TextEditingController statusC = TextEditingController();
  final TextEditingController hargaC = TextEditingController();
  final TextEditingController ketepatanWaktuC = TextEditingController();
  final TextEditingController kualitasPekerjaanC = TextEditingController();
  final TextEditingController kepatuhanSafetyC = TextEditingController();
  final TextEditingController komunikasiC = TextEditingController();
  final TextEditingController nilaiTotalC = TextEditingController();
  final TextEditingController ratingC = TextEditingController();
  final TextEditingController spesialisC = TextEditingController();
  final TextEditingController updateByC = TextEditingController();
  final TextEditingController createdNameC = TextEditingController();
  final TextEditingController updateNameC = TextEditingController();
  final TextEditingController detailC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    idController.text = id?.toString() ?? '';
    namaController.text = nama ?? '';
    alamatKtpC.text = alamatKtp ?? '';
    noHpC.text = noHp?.toString() ?? '';
    alamatDomisiliC.text = alamatDomisili ?? '';
    ktpC.text = ktp ?? '';
    kodeC.text = kode ?? '';
    createdAtC.text = createdAt?.toString() ?? '';
    createdByC.text = createdBy?.toString() ?? '';
    statusC.text = status?.toString() ?? '';
    hargaC.text = harga?.toString() ?? '';
    ketepatanWaktuC.text = ketepatanWaktu?.toString() ?? '';
    kualitasPekerjaanC.text = kualitasPekerjaan?.toString() ?? '';
    kepatuhanSafetyC.text = kepatuhanSafety?.toString() ?? '';
    komunikasiC.text = komunikasi?.toString() ?? '';
    nilaiTotalC.text = nilaiTotal?.toString() ?? '';
    ratingC.text = rating ?? '';
    spesialisC.text = spesialis ?? '';
    updateByC.text = updateBy?.toString() ?? '';
    createdNameC.text = createdName ?? '';
    updateNameC.text = updateName ?? '';
    detailC.text = detail?.toString() ?? '';
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
              controller: namaController,
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
              controller: ktpC,
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
              controller: noHpC,
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
              controller: alamatKtpC,
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
              controller: alamatDomisiliC,
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
              controller: statusC,
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
                    controller: hargaC,
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
                    controller: kualitasPekerjaanC,
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
                    controller: ketepatanWaktuC,
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
                    controller: kepatuhanSafetyC,
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
                    controller: komunikasiC,
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
                    controller: spesialisC,
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
              controller: nilaiTotalC,
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
              text: 'Download File PDF',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
