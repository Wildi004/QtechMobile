import 'package:get/get.dart' hide Bindings;

import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/modal_logistik.dart';

class EditHargaModalController extends GetxController with Apis {
  final forms = LzForm.make([
    'kode_material',
    'nama',
    'tgl_berlaku',
    'qty',
    'satuan',
    'harga_satuan',
    'harga_diskon',
    'ppn',
    'total_ppn',
    'sub_total',
    'ongkir',
    'harga_modal',
    'lokasi',
    'supplier',
    'keterangan',
  ]);
  ModalLogistik? details;

  Future getDetailData(int id) async {
    try {
      Bindings.onRendered(() async {
        Toast.overlay('Loading...', onCancel: () {});

        if (details == null) {
          final res = await api.modalLogistik.getDataDetail(id);
          details = ModalLogistik.fromJson(res.data ?? {});
        }

        forms.fill(details!.toJson());

        await getSup(details?.supplier);

        Toast.dismiss();
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxString fileName = ''.obs;
  Rxn<ModalLogistik> modal = Rxn<ModalLogistik>();
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
      final form = forms.validate(required: ['kode_material']);
      if (form.ok) {
        final payload = form.value;
        payload['supplier'] = forms.extra('supplier');

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
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxList<FormManager> supId = RxList<FormManager>();

  List<Map<String, dynamic>> sup = [];
  Future openSupp() async {
    // final query = {'limit': 'all'};

    try {
      if (sup.isEmpty) {
        final res = await api.supplier.getData().ui.loading();
        sup = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      forms.set('supplier', '').options(
            sup
                .where((e) => e['nama_perusahaan'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['nama_perusahaan'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
      logg('== Suplier terpilih: ${forms.get('supplier')}');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future getSup(int? id) async {
    // pastikan data supplier sudah ada
    if (sup.isEmpty) {
      final res = await api.supplier.getData();
      sup = List<Map<String, dynamic>>.from(res.data ?? []);
    }

    // buat options dulu
    forms.set('supplier', '').options(
          sup
              .where((e) => e['nama_perusahaan'] != null && e['id'] != null)
              .map((e) => {
                    'label': e['nama_perusahaan'].toString(),
                    'value': e['id'].toString(),
                  })
              .toList(),
        );

    // baru set value berdasarkan id
    final option = sup.firstWhere((e) => e['id'] == id, orElse: () => {});
    if (option['id'] != null) {
      forms.set(
          'supplier',
          Option(option['nama_perusahaan'].toString(),
              value: option['id'].toString()));
    }
  }
}
