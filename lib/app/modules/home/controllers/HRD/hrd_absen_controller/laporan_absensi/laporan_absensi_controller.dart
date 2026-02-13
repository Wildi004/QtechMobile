import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lazyui/lazyui.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrm_dev/app/core/utils/config.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class LaporanAbsensiController extends GetxController with Apis {
  RxInt tab = 0.obs;

  final forms = LzForm.make(
      ['regional', 'employee', 'periode', 'date', 'bulan', 'tahun']);

  List<Map<String, dynamic>> dataRegional = [];

  final regs = [
    {'name': 'Pusat'},
    {'name': 'Pusat-Finance'},
    {'name': 'Pusat-BSD'},
    {'name': 'Pusat-Teknik'},
    {'name': 'Timur'},
    {'name': 'Barat'},
  ];
  Future<List<Map>> getReg() async {
    return regs;
  }

  Future getRegional() async {
    try {
      if (dataRegional.isEmpty) {
        final res = await api.regional.getData().ui.loading();
        dataRegional = List<Map<String, dynamic>>.from(res.data ?? []);
      }
      final options = dataRegional.labelValue('regional', 'id');
      forms.set('regional').options(options);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Map<String, List<Map<String, dynamic>>> dataEmployee = {};

  Future getEmployee() async {
    try {
      String? regionalName = forms.get('regional');

      if ([null, ''].contains(regionalName)) {
        return Toast.show('Anda belum memilih regional');
      }

      if ((dataEmployee[regionalName] ?? []).isEmpty) {
        final res = await api.regional
            .getAllRegional(regional: regionalName)
            .ui
            .loading();

        dataEmployee[regionalName.toString()] =
            List<Map<String, dynamic>>.from(res.data ?? []);
      }

      final options = (dataEmployee[regionalName] ?? [])
          .map((e) => {
                'label': e['name'],
                'value': e['id'],
              })
          .toList();

      forms.set('employee').options(options);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future<void> onSubmit() async {
    try {
      Get.dialog(
        const Center(child: CustomLoading()),
        barrierDismissible: false,
      );

      final periode = forms.get('periode');
      final karyawan = forms.extra('employee');

      if (karyawan == null || karyawan.toString().isEmpty) {
        Toast.show('Silakan pilih karyawan terlebih dahulu');
        return;
      }

      if (periode == null || periode.toString().isEmpty) {
        Toast.show('Silakan pilih periode terlebih dahulu');
        return;
      }

      final payload = {'karyawan': karyawan};

      if (periode == 'Bulan/Tahun') {
        final bulan = forms.get('bulan');
        final tahun = forms.get('tahun');
        if (bulan == null || tahun == null) {
          Toast.show('Silakan pilih bulan dan tahun');
          return;
        }
        payload['bulan-tahun'] = '$tahun-${bulan.toString().padLeft(2, '0')}';
      } else if (periode == 'Tanggal') {
        final tanggal = forms.get('date');
        if (tanggal == null || tanggal.toString().isEmpty) {
          Toast.show('Silakan pilih tanggal');
          return;
        }
        payload['tanggal'] = tanggal;
      }

      logg('-- query: $payload');

      final uri = Uri.parse('${AppConfig.baseUrl}hrd/absensi/cetak').replace(
        queryParameters:
            payload.map((key, value) => MapEntry(key, value.toString())),
      );

      final token = GetStorage().read('token') ?? '';

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/pdf',
        },
      );

      if (response.statusCode != 200) {
        Toast.show('Gagal mendapatkan file. Status: ${response.statusCode}');
        return;
      }

      final bytes = response.bodyBytes;

      if (bytes.isEmpty) {
        Toast.show('File tidak valid atau kosong');
        return;
      }

      final dir = await getTemporaryDirectory();
      final filePath =
          '${dir.path}/absensi_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File(filePath);

      await file.writeAsBytes(bytes, flush: true);

      final result = await OpenFilex.open(file.path);
      logg('OpenFilex result: ${result.message}');
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      Get.back();
    }
  }
}
