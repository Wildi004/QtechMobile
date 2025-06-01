import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/notulen/notulen.dart';
import 'package:qrm/app/modules/notulen/controllers/notulen_controller.dart';

class DetailNotulen extends GetView<NotulenController> {
  DetailNotulen(
      {super.key,
      this.notulen,
      required this.judul,
      required this.isi,
      required this.sifat,
      required this.tgl,
      required this.departemen,
      required this.jumlah});
  final Notulen? notulen;
  final String? judul;
  final String? isi;
  final int? sifat;
  final String? tgl;
  final int? departemen;
  final int? jumlah;

  final TextEditingController judulController = TextEditingController();
  final TextEditingController isiController = TextEditingController();

  final TextEditingController sifatController = TextEditingController();
  final TextEditingController tglController = TextEditingController();

  final TextEditingController dptController = TextEditingController();
  final TextEditingController jmlCntroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => NotulenController());
    final forms = controller.forms;

    if (notulen != null) {
      forms.fill(notulen!.toJson());

      // atau satu persatu seperti ini
      // forms.fill({'name': data?.name});
      // notulen/8gPy5c4TShKRps4BZurXIkn0dgL43t7TP7icnoMj.png = SALAH
      // https://qinar.com/storage/images/notulen/8gPy5c4TShKRps4BZurXIkn0dgL43t7TP7icnoMj.png = BENAR
    }

    judulController.text = judul ?? '';
    isiController.text = isi ?? '';
    sifatController.text = sifat?.toString() ?? '';
    tglController.text = tgl ?? '';
    dptController.text = departemen?.toString() ?? '';
    jmlCntroller.text = jumlah?.toString() ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notulen",
          style: TextStyle(color: Colors.white, fontWeight: Fw.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 91, 122),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Touch(
                  onTap: () {},
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Colors.blueAccent,
                          Color.fromARGB(255, 16, 63, 131)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Download File PDF',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      readOnly: true,
                      controller: judulController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Judul Topik / Rapat',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            controller: sifatController,
                            decoration: InputDecoration(
                              labelText: 'Sifat',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            controller: tglController,
                            decoration: InputDecoration(
                              labelText: 'Tanggal Rapat',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            controller: dptController,
                            decoration: InputDecoration(
                              labelText: 'Departemen',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            controller: jmlCntroller,
                            decoration: InputDecoration(
                              labelText: 'Jumlah Peserta',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      readOnly: true,
                      controller: isiController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: 'Isi Pembahasan Rapat',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    // LzButton(
                    //   text: notulen == null ? 'Simpan' : 'Update',
                    //   onTap: () => controller.onSubmit(notulen?.id),
                    // ).margin(blr: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
