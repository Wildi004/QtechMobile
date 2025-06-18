import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/ptj_hrd/ptj_hrd.dart';
import 'package:qrm/app/data/models/saldo_ptj.dart';
import 'package:http/http.dart' as http;
import 'package:qrm/app/data/services/storage/storage.dart';
import 'package:path/path.dart' as p;
import 'package:qrm/app/widgets/file_viewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../data/models/ptj_hrd/detail_ptj.dart';

class DetailPtjHrdController extends GetxController with Apis {
  PtjHrd? data;
  final isFilled = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'id',
    'no_ptj',
    'tgl_ptj',
    'total',
    'status_dir_keuangan',
    'status_gm_bsd',
    'created_at',
    'no_hide',
    'type',
    'created_name',
    'approved_name',
    'saldo',
    'approval_name',
    'dep_name',
    'id',
    'no_ptj',
    'tgl_beli',
    'nama_barang',
    'qty',
    'harga_satuan',
    'total_harga',
    'image',
    'status_acc',
    'status_acc_dir',
    'status_acc_dirut',
    'komentar_dirut',
    'komentar',
    'komentar_dir',
    'created_at',
    'no_hide',
    'adendum',
    'proyek_item_name',
    'detail_pengajuan_name',
    'akun_name',
    'perkiraan_name',
  ]);

  RxList<FormManager> formRabs = RxList([]);

  final id = Get.parameters['id'];

  PtjHrd details = PtjHrd();
  RxList<DetailPtj> cards = RxList([]);

  Future getDetails(PtjHrd data) async {
    try {
      String nohide = data.noHide ?? '';
      final res = await api.ptjHrd.getDataByNoHide(nohide);
      details = PtjHrd.fromJson(res.data ?? {});
      cards.value = details.detailPtj ?? [];
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getSaldo() async {
    try {
      final res = await api.saldoPtj.getData();
      logg(res.data); // Ini boleh untuk cek respon

      if (res.data is Map<String, dynamic>) {
        final saldo = SaldoPtj.fromJson(res.data);
        final saldoValue =
            saldo.saldoAkhirFormat ?? saldo.saldoAkhir?.toString() ?? '0';
        forms.set('saldo', saldoValue);
      } else {
        forms.set('saldo', '0');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future<void> openFileWithToken(String fileName) async {
    try {
      final url = 'https://laravel.apihbr.link/files/$fileName';

      final token = storage.read('token');

      logg('Bearer token: $token');
      logg('URL file: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      logg('Response code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final contentType = response.headers['content-type'] ?? '';
        logg('Content-Type: $contentType');

        if (!contentType.contains('application/pdf') &&
            !contentType.contains('image') &&
            !contentType.contains('application')) {
          Toast.error('Response bukan file valid');
          return;
        }

        final dir = await getTemporaryDirectory();
        final filePath = '${dir.path}/$fileName';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        final result = await OpenFilex.open(filePath);
        logg('Open file result: ${result.message}');
      } else {
        logg('Response body: ${response.body}');
        Toast.error('Gagal membuka file (code: ${response.statusCode})');
      }
    } catch (e, s) {
      logg('Error: $e\n$s');
      Toast.error('Error membuka file: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (data != null) {
      forms.fill(data!.toJson());
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    getSaldo();
  }
}
