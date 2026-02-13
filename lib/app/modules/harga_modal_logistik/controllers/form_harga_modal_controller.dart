import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/modal_logistik.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class FormHargaModalController extends GetxController with Apis {
  final forms = LzForm.make([
    "kode_material",
    "nama",
    "tgl_input",
    "tgl_berlaku",
    "qty",
    "satuan",
    "harga_satuan",
    "harga_diskon",
    "ppn",
    "total_ppn",
    "sub_total",
    "ongkir",
    "harga_modal",
    "lokasi",
    "user_id",
    'lokasi',
    "supplier",
    "keterangan"
  ]);
  File? file;
  RxString fileName = ''.obs;
  Rxn<ModalLogistik> modalLogistik = Rxn<ModalLogistik>();

  final satuan = [
    {'name': 'm2'},
    {'name': 'can'},
    {'name': 'box'},
    {'name': 'pcs'},
    {'name': 'sheet'},
    {'name': 'm1'},
    {'name': 'm3'},
    {'name': 'ls'},
    {'name': 'unit'},
    {'name': 'titik'},
    {'name': 'bh'},
    {'name': 'm'},
    {'name': 'kg'},
    {'name': 'pail'},
    {'name': 'p'},
    {'name': 'bag'},
    {'name': 'drum'},
    {'name': 'roll'},
    {'name': 'tube'},
    {'name': 'each'},
    {'name': 'lembar'},
    {'name': 'dirigen'},
    {'name': 'ball'},
    {'name': 'dus'},
    {'name': 'sak'},
    {'name': 'ongkir'},
    {'name': 'full'},
    {'name': 'bulan'},
    {'name': 'hari'},
    {'name': 'pack'},
    {'name': 'btg'},
    {'name': 'kaleng'},
    {'name': 'cm'},
    {'name': 'org'},
    {'name': 'thn'},
    {'name': 'set'},
    {'name': 'view'},
    {'name': 'lot'},
    {'name': 'kali'},
    {'name': 'gate'},
    {'name': 'galon'},
    {'name': 'liter'},
    {'name': 'OH'},
    {'name': 'lusin'},
    {'name': 'tabung'},
    {'name': 'ton'},
  ];

  Future<List<Map>> getSatuan() async {
    return satuan;
  }

  RxList<FormManager> supplierID = RxList<FormManager>();
  List<Map<String, dynamic>> supplier = [];

  Future openSupplier() async {
    try {
      if (supplier.isEmpty) {
        final res = await api.supplier.getData().ui.loading();
        supplier = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      forms.set('supplier', '').options(
            supplier
                .where((e) => e['nama_perusahaan'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['nama_perusahaan'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future getSupplier(int? id) async {
    final res = await api.supplier.getData();
    supplier = List<Map<String, dynamic>>.from(res.data ?? []);

    if (supplier.isNotEmpty) {
      // Contoh jika ingin label = role, value = role (tidak pakai id sebagai value)
      supplierID[0].set('supplier', '').options(
            supplier
                .where((e) => e['nama_perusahaan'] != null)
                .map((e) => {
                      'label': e['nama_perusahaan'].toString(),
                      'value': e['nama_perusahaan']
                          .toString(), // value = label (role)
                    })
                .toList(),
          );
    } else {
      supplierID[0].set('supplier', '').options([]);
    }

    if (id != null) {
      final result = supplier.firstWhere(
        (e) => e['id'] == id,
        orElse: () => {},
      );

      if (result.isNotEmpty && result['nama_perusahaan'] != null) {
        forms.set(
          'supplier',
          Option(result['nama_perusahaan'].toString(),
              value: result['nama_perusahaan'].toString()),
        );
      }
    }
  }

  @override
  void onInit() {
    super.onInit();

    supplierID.add(LzForm.make(['building_id']));
  }

  void hitungOtomatis() {
    // Ambil nilai dari form dan ubah ke angka (default 0 kalau kosong)
    final hargaSatuan = double.tryParse(
            forms.get('harga_satuan')?.toString().replaceAll(',', '') ?? '') ??
        0;
    final hargaDiskon = double.tryParse(
            forms.get('harga_diskon')?.toString().replaceAll(',', '') ?? '') ??
        0;
    final ppn = double.tryParse(forms.get('ppn')?.toString() ?? '') ?? 0;
    final ongkir = double.tryParse(
            forms.get('ongkir')?.toString().replaceAll(',', '') ?? '') ??
        0;

    // Harga setelah diskon
    final hargaSetelahDiskon = hargaSatuan - hargaDiskon;

    // Total PPN
    final totalPpn = (hargaSetelahDiskon * (ppn / 100));

    // Subtotal
    final subTotal = hargaSetelahDiskon + totalPpn;

    // Harga Modal
    final hargaModal = subTotal + ongkir;

    // Set ke form (bulatkan biar rapi)
    forms
      ..set('total_ppn', totalPpn.round())
      ..set('sub_total', subTotal.round())
      ..set('harga_modal', hargaModal.round());
  }

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*', 'user_id']);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        // Tambahkan user dan supplier
        payload['user_id'] = auth.id;
        payload['supplier'] = forms.extra('supplier');

        // 🧹 Bersihkan semua angka yang mungkin ada koma/titik pemisah
        final fieldsToClean = [
          'harga_satuan',
          'harga_diskon',
          'ppn',
          'total_ppn',
          'sub_total',
          'ongkir',
          'harga_modal',
          'qty'
        ];

        for (final key in fieldsToClean) {
          if (payload[key] != null) {
            final cleaned =
                payload[key].toString().replaceAll(RegExp(r'[^\d]'), '');
            payload[key] = int.tryParse(cleaned) ?? 0;
          }
        }

        // Cek hasil payload
        logg('-- Payload final: $payload');

        // Kirim ke API
        if (id == null) {
          final res = await api.modalLogistik
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        } else {
          final res = await api.modalLogistik
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        }
      } else {
        logg(form.error);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
