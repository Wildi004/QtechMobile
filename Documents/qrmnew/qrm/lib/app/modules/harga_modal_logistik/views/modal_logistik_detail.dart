import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/harga_modal_logistik/controllers/harga_modal_logistik_controller.dart';

class ModalLogistikDetail extends GetView<HargaModalLogistikController> {
  ModalLogistikDetail({
    super.key,
    required this.id,
    required this.kodeMaterial,
    required this.nama,
    required this.tglInput,
    required this.tglBerlaku,
    required this.qty,
    required this.satuan,
    required this.hargaSatuan,
    required this.hargaDiskon,
    required this.ppn,
    required this.totalPpn,
    required this.subTotal,
    required this.ongkir,
    required this.hargaModal,
    required this.lokasi,
    required this.userId,
    required this.supplier,
    required this.keterangan,
    required this.userName,
    required this.supplierName,
  });
  final int? id;
  final String? kodeMaterial;
  final String? nama;
  final String? tglInput;
  final String? tglBerlaku;
  final String? qty;
  final String? satuan;
  final String? hargaSatuan;
  final String? hargaDiskon;
  final String? ppn;
  final String? totalPpn;
  final String? subTotal;
  final String? ongkir;
  final String? hargaModal;
  final String? lokasi;
  final int? userId;
  final int? supplier;
  final String? keterangan;
  final String? userName;
  final String? supplierName;
  final OutlineInputBorder borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.black,
      width: 2,
    ),
  );

  final TextEditingController idController = TextEditingController();
  final TextEditingController kodeMaterialController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController tglInputController = TextEditingController();
  final TextEditingController tglBerlakuController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController satuanController = TextEditingController();
  final TextEditingController hargaSatuanController = TextEditingController();
  final TextEditingController hargaDiskonController = TextEditingController();
  final TextEditingController ppnController = TextEditingController();
  final TextEditingController totalPpnController = TextEditingController();
  final TextEditingController subTotalController = TextEditingController();
  final TextEditingController ongkirController = TextEditingController();
  final TextEditingController hargaModalController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController serIdaController = TextEditingController();
  final TextEditingController supplierController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController supplierNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    idController.text = id?.toString() ?? '';
    kodeMaterialController.text = kodeMaterial ?? '';
    namaController.text = nama ?? '';
    tglInputController.text = tglInput ?? '';
    tglBerlakuController.text = tglBerlaku ?? '';
    qtyController.text = qty ?? '';
    satuanController.text = satuan ?? '';
    hargaSatuanController.text = hargaSatuan ?? '';
    hargaDiskonController.text = hargaDiskon ?? '';
    ppnController.text = ppn ?? '';
    totalPpnController.text = totalPpn ?? '';
    subTotalController.text = subTotal ?? '';
    ongkirController.text = ongkir ?? '';
    hargaModalController.text = hargaModal ?? '';
    lokasiController.text = lokasi ?? '';
    serIdaController.text = userId?.toString() ?? '';
    supplierController.text = supplier?.toString() ?? '';
    keteranganController.text = keterangan ?? '';
    userNameController.text = userName ?? '';
    supplierNameController.text = supplierName ?? '';

    Get.lazyPut(() => HargaModalLogistikController());

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Harga Modal",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 6, 91, 122),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: LzListView(
              children: [
                TextFormField(
                  readOnly: true,
                  controller: kodeMaterialController,
                  maxLines: 1,
                  decoration: InputDecoration(
                      labelText: 'Kode Material',
                      labelStyle: TextStyle(fontWeight: Fw.bold),
                      border: borderStyle,
                      focusedBorder: borderStyle.copyWith(
                        borderSide: borderStyle.borderSide.copyWith(
                          color: const Color.fromARGB(255, 0, 61, 230),
                          width: 2,
                        ),
                      )),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  readOnly: true,
                  controller: namaController,
                  maxLines: 1,
                  decoration: InputDecoration(
                      labelText: 'Nama Material',
                      labelStyle: TextStyle(fontWeight: Fw.bold),
                      border: borderStyle,
                      focusedBorder: borderStyle.copyWith(
                        borderSide: borderStyle.borderSide.copyWith(
                          color: const Color.fromARGB(255, 0, 61, 230),
                          width: 2,
                        ),
                      )),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Kemasan',
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
                        readOnly: true,
                        controller: satuanController,
                        decoration: InputDecoration(
                            labelText: 'Satuan',
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
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: tglInputController,
                        decoration: InputDecoration(
                            labelText: 'Tanggal input',
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
                        readOnly: true,
                        controller: tglBerlakuController,
                        decoration: InputDecoration(
                            labelText: 'Berlaku Sampai',
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
                const SizedBox(height: 15),
                TextFormField(
                  readOnly: true,
                  controller: hargaSatuanController,
                  maxLines: 1,
                  decoration: InputDecoration(
                      labelText: 'Harga Price List',
                      labelStyle: TextStyle(fontWeight: Fw.bold),
                      border: borderStyle,
                      focusedBorder: borderStyle.copyWith(
                        borderSide: borderStyle.borderSide.copyWith(
                          color: const Color.fromARGB(255, 0, 61, 230),
                          width: 2,
                        ),
                      )),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  readOnly: true,
                  controller: hargaDiskonController,
                  maxLines: 1,
                  decoration: InputDecoration(
                      labelText: 'Harga Setelah Diskon',
                      labelStyle: TextStyle(fontWeight: Fw.bold),
                      border: borderStyle,
                      focusedBorder: borderStyle.copyWith(
                        borderSide: borderStyle.borderSide.copyWith(
                          color: const Color.fromARGB(255, 0, 61, 230),
                          width: 2,
                        ),
                      )),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  readOnly: true,
                  controller: ppnController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: 'PPN %',
                    labelStyle: TextStyle(fontWeight: Fw.bold),
                    border: borderStyle,
                    focusedBorder: borderStyle.copyWith(
                      borderSide: borderStyle.borderSide.copyWith(
                        color: const Color.fromARGB(255, 0, 61, 230),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: totalPpnController,
                        decoration: InputDecoration(
                            labelText: 'Total PPN',
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
                        readOnly: true,
                        controller: subTotalController,
                        decoration: InputDecoration(
                            labelText: ' Harga + PPN',
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
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: ongkirController,
                        decoration: InputDecoration(
                            labelText: 'Ongkir',
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
                        readOnly: true,
                        controller: hargaModalController,
                        decoration: InputDecoration(
                            labelText: ' Harga Modal',
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
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: supplierNameController,
                        decoration: InputDecoration(
                            labelText: 'Nama Supplier',
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
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: 'Franco',
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
                const SizedBox(height: 15),
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
            )));
  }
}
