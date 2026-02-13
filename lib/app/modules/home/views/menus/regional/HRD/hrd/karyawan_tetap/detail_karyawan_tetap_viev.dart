import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tetap.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/form_karyawan_tetap_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class DetailKaryawanTetapViev extends GetView<FormKaryawanTetapController> {
  const DetailKaryawanTetapViev({super.key, this.data});
  final KaryawanTetap? data;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<FormKaryawanTetapController>()) {
      Get.lazyPut(() => FormKaryawanTetapController());
    }

    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }
    return SafeArea(
      top: false,
      child: Scaffold(
          appBar: CustomAppbar(title: 'Karyawan tetap detail').appBar,
          body: LzListView(
            gap: 10,
            children: [
              LzForm.input(
                label: 'Nama Lengkap',
                model: forms.key('name'),
                enabled: false,
                maxLines: 5,
              ),
              LzForm.input(
                label: 'Email Karyawan',
                model: forms.key('email'),
                enabled: false,
                maxLines: 5,
              ),
              LzForm.input(
                label: 'No Telepon',
                model: forms.key('no_telp'),
                enabled: false,
              ),
              Row(
                children: [
                  Expanded(
                    child: LzForm.input(
                      label: 'Tanggal Bergabung',
                      model: forms.key('tgl_bergabung'),
                      enabled: false,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: LzForm.input(
                      label: 'No Induk',
                      model: forms.key('no_induk'),
                      enabled: false,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: LzForm.input(
                      label: 'Prosentase',
                      model: forms.key('prosentase'),
                      enabled: false,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: LzForm.input(
                      label: 'Golongan',
                      model: forms.key('golongan'),
                      enabled: false,
                    ),
                  ),
                ],
              ),
              LzForm.input(
                label: 'No KTP',
                model: forms.key('no_ktp'),
                enabled: false,
                maxLines: 5,
              ),
              LzForm.input(
                label: 'Foto Profil',
                model: forms.key('image'),
                enabled: false,
              ),
              Row(
                children: [
                  Expanded(
                    child: LzForm.input(
                      label: 'Role',
                      model: forms.key('role'),
                      enabled: false,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: LzForm.input(
                      label: 'Departemen',
                      model: forms.key('dept'),
                      enabled: false,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: LzForm.input(
                      label: 'Regional Office',
                      model: forms.key('regional'),
                      enabled: false,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: LzForm.input(
                      label: 'Regional KTP',
                      model: forms.key('regional_ktp'),
                      enabled: false,
                    ),
                  ),
                ],
              ),
              LzForm.input(
                label: 'Alamat KTP',
                model: forms.key('alamat_ktp'),
                enabled: false,
                maxLines: 5,
              ),
              LzForm.input(
                label: 'Alamat Domisili',
                model: forms.key('alamat_domisili'),
                enabled: false,
                maxLines: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: LzForm.input(
                      label: 'Tempat Lahir',
                      model: forms.key('tempat_lahir'),
                      enabled: false,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: LzForm.input(
                      label: 'Tanggal Lahir',
                      model: forms.key('tgl_lahir'),
                      enabled: false,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: LzForm.input(
                      label: 'Jenis Kelamin',
                      model: forms.key('gender'),
                      enabled: false,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: LzForm.input(
                      label: 'Agama',
                      model: forms.key('agama'),
                      enabled: false,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: LzForm.input(
                      label: 'Status Kawin',
                      model: forms.key('status_kawin_id'),
                      enabled: false,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: LzForm.input(
                      label: 'Status Karyawan',
                      model: forms.key('status_karyawan'),
                      enabled: false,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: LzForm.input(
                      label: 'Status Aktif',
                      model: forms.key('is_active'),
                      enabled: false,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: LzForm.input(
                      label: 'Shift',
                      model: forms.key('shift'),
                      enabled: false,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: LzForm.input(
                      label: 'Building',
                      model: forms.key('building'),
                      enabled: false,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: LzForm.input(
                      label: 'ID Telegram',
                      model: forms.key('id_telegram'),
                      enabled: false,
                    ),
                  ),
                ],
              ),
              LzForm.input(
                label: 'Tanda Tangan (TTD)',
                model: forms.key('ttd'),
                enabled: false,
              ),
            ],
          )),
    );
  }
}

/*

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/ptj_hrd/ptj_hrd.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_ptj_controller/detail_ptj_hrd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class DetailPtjHrdView extends GetView<DetailPtjHrdController> {
  final PtjHrd? data;

  const DetailPtjHrdView({super.key, this.data});
  String statusValidasi(int? status) {
    switch (status) {
      case 0:
        return 'Tolak';
      case 1:
        return 'Terima';
      case 2:
        return '-';
      case 3:
        return 'Panding';
      case 4:
        return 'Cenceal';
      default:
        return 'Not Check';
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DetailPtjHrdController()..data = data);

    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.getDetails(data!);
      controller.getSaldo();
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: CustomAppbar(
        title: 'Detail ptj',
      ).appBar,
      body: Obx(() {
        bool loading = controller.isLoading.value;

        if (loading) {
          return  CustomLoading()
;
        }

        return Column(
          children: [
            Container(
              padding: Ei.all(20),
              decoration: BoxDecoration(border: Br.only(['b'])),
              child: Column(
                spacing: 16,
                children: [
                  LzForm.input(
                    label: 'No. PTJ',
                    enabled: false,
                    model: forms.key('no_ptj'),
                  ),
                  Intrinsic(
                    gap: 10,
                    children: [
                      LzForm.input(
                        label: 'Tanggal PTJ',
                        enabled: false,
                        model: forms.key('tgl_ptj'),
                      ),
                      LzForm.input(
                        label: 'Departemen',
                        enabled: false,
                        model: forms.key('dep_name'),
                      ),
                    ],
                  ),
                  LzForm.input(
                    label: 'Saldo',
                    enabled: false,
                    model: forms.key('saldo'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => LzListView(
                  gap: 10,
                  children: List.generate(controller.formDetails.length, (i) {
                    final form = controller.formDetails[i];
                    return LzCard(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Nama Barang',
                          enabled: false,
                          maxLines: 99,
                          model: form.key('nama_barang'),
                        ),
                        Intrinsic(
                          gap: 10,
                          children: [
                            LzForm.input(
                              label: 'Tanggal Beli',
                              enabled: false,
                              model: form.key('tgl_beli'),
                            ),
                            LzForm.input(
                              label: 'Image',
                              enabled: false,
                              model: form.key('image'),
                            ),
                          ],
                        ),
                        Intrinsic(
                          gap: 10,
                          children: [
                            LzForm.input(
                              label: 'Qty',
                              enabled: false,
                              model: form.key('qty'),
                            ),
                            LzForm.input(
                              label: 'Harga Satuan',
                              enabled: false,
                              model: form.key('harga_satuan'),
                            ),
                          ],
                        ),
                        LzForm.input(
                          label: 'Total',
                          enabled: false,
                          model: form.key('total_harga'),
                        ),
                      ],
                    );
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status Validasi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Dir BSD',
                                style: TextStyle(fontSize: 14),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black), // Garis sisi hitam
                                  borderRadius: BorderRadius.circular(
                                      4), // Opsional, biar ada radius sudut
                                ),
                                child: Text(
                                  statusToText(data?.statusGmBsd),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Dir. Keuangan',
                                style: TextStyle(fontSize: 14),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black), // Garis sisi hitam
                                  borderRadius:
                                      BorderRadius.circular(4), // Opsional
                                ),
                                child: Text(
                                  statusToText(data?.statusDirKeuangan),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                  }),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

Widget buildBuktiNotaField(String label, String? fileName, controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                fileName ?? '-',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (fileName != null)
              IconButton(
                icon: const Icon(Icons.remove_red_eye),
                onPressed: () {
                  controller.openFileWithToken(fileName);
                },
              ),
          ],
        ),
      ),
      const SizedBox(height: 10),
    ],
  );  Widget buildTextField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(value),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

}

*/
