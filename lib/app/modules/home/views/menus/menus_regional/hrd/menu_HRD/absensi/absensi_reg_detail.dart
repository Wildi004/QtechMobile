import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/notulen/notulen.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_absen_controller/absen_controller.dart';

class AbsensiRegDetail extends GetView<AbsenController> {
  AbsensiRegDetail(
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
    Get.lazyPut(() => AbsenController());
    // final forms = controller.forms;

    // if (notulen != null) {
    //   forms.fill(notulen!.toJson());

    //   // atau satu persatu seperti ini
    //   // forms.fill({'name': data?.name});
    // }

    judulController.text = judul ?? '';
    isiController.text = isi ?? '';
    sifatController.text = sifat?.toString() ?? '';
    tglController.text = tgl ?? '';
    dptController.text = departemen?.toString() ?? '';
    jmlCntroller.text = jumlah?.toString() ?? '';

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Absensi",
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LzButton(
                  color: const Color.fromARGB(255, 146, 181, 70),
                  icon: Hi.noteEdit,
                  onTap: () {},
                ),
                LzButton(
                  color: const Color.fromARGB(255, 176, 12, 1),
                  icon: Hi.delete02,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 10),
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
