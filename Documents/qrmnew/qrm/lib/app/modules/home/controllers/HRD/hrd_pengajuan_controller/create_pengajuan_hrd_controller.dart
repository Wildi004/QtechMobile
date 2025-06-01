import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CreatePengajuanHrdController extends GetxController {
  final noPengajuan = TextEditingController();
  final tglPengajuan = TextEditingController();
  final departemen = TextEditingController();
  final keterangan = TextEditingController();
  RxInt tab = 0.obs;

  var tambahanList = <Map<String, TextEditingController>>[].obs;
  var pengajuanId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tambahFormBaru();
  }

  Future<bool> createPengajuan() async {
    try {
      String token = GetStorage().read('token') ?? '';

      var response = await http.post(
        Uri.parse('https://laravel.apihbr.link/api/hrd/pengajuan/departemen'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        noPengajuan.text = data['no_pengajuan'] ?? '';
        tglPengajuan.text = data['tgl_pengajuan'] ?? '';
        departemen.text = data['dep_name'] ?? '';
        pengajuanId.value = data['id'];

        Get.snackbar('Sukses', 'Pengajuan berhasil dibuat');
        return true;
      } else {
        Get.snackbar('Gagal', 'Status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    }
  }

  void removeForm(int index) {
    tambahanList.removeAt(index);
  }

  void tambahFormBaru() {
    tambahanList.add({
      "field1": TextEditingController(), // tgl

      "field2": TextEditingController(), // nama_barang
      "field3": TextEditingController(), // qty
      "field4": TextEditingController(), // harga
    });
  }

  void updatePengajuan() async {
    List<String> tanggal = [];
    List<String> namaBarang = [];
    List<int> qty = [];
    List<int> harga = [];

    for (var item in tambahanList) {
      final tgl = item['field1']!.text.trim();
      final nama = item['field2']!.text.trim();
      final qtyVal = int.tryParse(item['field3']!.text.trim()) ?? 0;
      final hargaVal = int.tryParse(item['field4']!.text.trim()) ?? 0;

      if (nama.isNotEmpty) {
        tanggal.add(tgl);
        namaBarang.add(nama);
        qty.add(qtyVal);
        harga.add(hargaVal);
      }
    }

    final body = {
      "tgl_pengajuan": tglPengajuan.text.trim(),
      "tanggal_per_item": tanggal,
      "nama_barang": namaBarang,
      "qty": qty,
      "harga": harga,
    };

    try {
      String token = GetStorage().read('token') ?? '';

      final response = await http.patch(
        Uri.parse(
            'https://laravel.apihbr.link/api/hrd/pengajuan/departemen/${pengajuanId.value}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Berhasil', 'Data berhasil diupdate');
      } else {
        Get.snackbar('Gagal', 'Gagal update: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }
}
