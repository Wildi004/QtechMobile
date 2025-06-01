import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataDiriController extends GetxController {
  var idKaryawan = TextEditingController(text: "QRM - 0000");
  var email = TextEditingController(text: "bareel@qrm15.com");
  var nik = TextEditingController(text: "5171293013930412");
  var namaLengkap = TextEditingController(text: "Bareel Husein");
  var nomorTelepon = TextEditingController(text: "081234567890");
  var alamat = TextEditingController(text: "Jalan Denpasar Bali No. 100");
  var tempatLahir = TextEditingController(text: "Jawa Timur");
  var tanggalLahir = "06 JANUARI 2025".obs;
  var agama = TextEditingController(text: "Islam");
  var jenisKelamin = TextEditingController(text: "Laki - Laki");

  void simpanPerubahan() {
    Get.snackbar("Sukses", "Perubahan telah disimpan",
        snackPosition: SnackPosition.BOTTOM);
  }
}
