import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/settings/views/menus%20setting/data_diri/controllers/data_diri_controller.dart';

class DataDiriView extends StatelessWidget {
  final DataDiriController controller = Get.put(DataDiriController());

  DataDiriView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DATA DIRI"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.09),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/profile.jpg"),
              ),
              SizedBox(height: 8),
              Text("Edit Foto", style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16),
              buildTextField("ID Karyawan", controller.idKaryawan,
                  enabled: false),
              buildTextField("Email", controller.email, enabled: false),
              buildTextField("NIK", controller.nik, enabled: false),
              buildTextField("Nama Lengkap", controller.namaLengkap),
              buildTextField("Nomor Telepon", controller.nomorTelepon),
              buildTextField("Alamat", controller.alamat),
              Row(
                children: [
                  Expanded(
                      child: buildTextField(
                          "Tempat Lahir", controller.tempatLahir)),
                  SizedBox(width: 8),
                  Expanded(
                      child: buildTextField(
                          "Tanggal Lahir",
                          TextEditingController(
                              text: controller.tanggalLahir.value),
                          enabled: false)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: buildTextField("Agama", controller.agama)),
                  SizedBox(width: 8),
                  Expanded(
                      child: buildTextField(
                          "Jenis Kelamin", controller.jenisKelamin)),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: controller.simpanPerubahan,
                child: Text("Simpan Perubahan",
                    style: TextStyle(color: Colors.black)),
              ),
            ],
          ).gap(MediaQuery.of(context).size.width * 0.01)),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: enabled ? Colors.white : Colors.grey[300],
        ),
      ),
    );
  }
}
