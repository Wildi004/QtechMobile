import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/rab.dart';

class CreatePengajuanHrdController extends GetxController with Apis {
  final noPengajuan = TextEditingController();
  final tglPengajuan = TextEditingController();
  final departemen = TextEditingController();
  final keterangan = TextEditingController();
  RxInt tab = 0.obs;
  final listKey = GlobalKey<AnimatedListState>();
  RxInt grandTotal = 0.obs;
  RxList<Map<String, dynamic>> pengajuanItems = <Map<String, dynamic>>[].obs;

  var tambahanList = <Map<String, TextEditingController>>[].obs;
  var pengajuanId = 0.obs;

  @override
  void onInit() {
    super.onInit();

    tambahFormBaru();
    getTkdn();
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
        logg('Response body: ${response.body}');

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

  RxBool isLoading = true.obs;
  List<Rab> listrab = [];
  RxList<Rab> rxrab = <Rab>[].obs;
  Future<void> getTkdn() async {
    try {
      isLoading.value = true;

      final res = await api.rab.getData();
      logg('Response API RAB: ${res.body}'); // debug output

      final body = jsonDecode(res.body);

      if (body['data'] is List) {
        List data = body['data'];
        if (data.isNotEmpty) {
          logg('First item type: ${data[0].runtimeType}');
        }
        rxrab.value = Rab.fromJsonList(data);
      } else {
        logg('Data RAB bukan list: ${body['data'].runtimeType}');
      }
    } catch (e, s) {
      logg('Error di getTkdn: $e');
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  RxList<Map<String, dynamic>> listRAB = <Map<String, dynamic>>[].obs;

  Future<void> getDataRAB() async {
    try {
      String token = GetStorage().read('token') ?? '';
      final response = await http.get(
        Uri.parse('https://laravel.apihbr.link/api/hrd/rab/detail'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        listRAB.value = List<Map<String, dynamic>>.from(data);
        debugPrint('Data RAB berhasil diambil: ${listRAB.length} item');
      } else {
        Get.snackbar('Gagal', 'Gagal ambil data RAB: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }

  void removeForm(int index) {
    tambahanList.removeAt(index);
    listKey.currentState?.removeItem(
      index,
      (context, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          child: Container(
            padding: const EdgeInsets.all(12),
            color: Colors.orange.shade100,
            child: const Text('Menghapus...'),
          ),
        ),
      ),
    );
  }

  void tambahFormBaru() {
    final newForm = {
      "field1": TextEditingController(),
      "field2": TextEditingController(),
      "field3": TextEditingController(),
      "field4": TextEditingController(),
      "field5": TextEditingController(),
    };

    void updateTotal() {
      final jumlahText = newForm['field3']!.text;
      final hargaText = newForm['field4']!.text;

      int jumlah = int.tryParse(jumlahText) ?? 0;
      int harga = int.tryParse(hargaText) ?? 0;
      int total = jumlah * harga;
      newForm['field5']!.text = total.toString();
    }

    // Pasang listener sekali saat form baru dibuat
    newForm['field3']!.addListener(updateTotal);
    newForm['field4']!.addListener(updateTotal);

    tambahanList.insert(0, newForm);
    listKey.currentState?.insertItem(0);
  }

  void updatePengajuan() async {
    List<String> tanggal = [];
    List<String> namaBarang = [];
    List<int> qty = [];
    List<int> harga = [];
    List<int> totalharga = [];

    for (var item in tambahanList) {
      final tgl = item['field1']?.text.trim() ?? '';
      final nama = item['field2']?.text.trim() ?? '';
      final qtyVal = int.tryParse(item['field3']?.text.trim() ?? '') ?? 0;
      final hargaVal = int.tryParse(item['field4']?.text.trim() ?? '') ?? 0;
      final totalVal = int.tryParse(item['field5']?.text.trim() ?? '') ?? 0;

      tanggal.add(tgl);
      namaBarang.add(nama);
      qty.add(qtyVal);
      harga.add(hargaVal);
      totalharga.add(totalVal);
    }

    try {
      String token = GetStorage().read('token') ?? '';

      var response = await http.post(
        Uri.parse('https://laravel.apihbr.link/api/hrd/pengajuan/update'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "pengajuan_id": pengajuanId.value,
          "tanggal": tanggal,
          "nama_barang": namaBarang,
          "qty": qty,
          "harga": harga,
          "total_harga": totalharga,
          "grand_total": grandTotal.value,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Sukses', 'Pengajuan berhasil diupdate');
        logg('Update response: ${response.body}');
      } else {
        Get.snackbar('Gagal', 'Update gagal: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }

  void hitungGrandTotal() {
    int total = 0;
    for (var item in tambahanList) {
      int itemTotal = int.tryParse(item['field5']?.text ?? '0') ?? 0;
      total += itemTotal;
    }
    grandTotal.value = total;
  }
}
