import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_po_non_ppn/del_po_non_ppn.dart';

class CreateDelPoNonController extends GetxController with Apis {
  DelPoNonPpn? created;
  RxBool isSubmitted = false.obs;
  RxBool isLoading = true.obs;
  final forms = LzForm.make([
    'no_po_nonppn',
    'no_delivery',
    'kode_material',
    'shipment_date',
    'received_date',
    'lokasi_kirim',
    'penerima',
    'ekspedisi',
    'harga_ekspedisi',
  ]);

  @override
  void onInit() {
    createPo();
    super.onInit();
  }

  Future deleteData(String noHide) async {
    try {
      final res =
          await api.delPoNonPpn.deleteData(noHide).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      isLoading.refresh();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future<void> createPo() async {
    try {
      isLoading.value = true;
      final res = await api.delPoNonPpn.createData();
      forms.fill(res.data ?? {});
      created = DelPoNonPpn.fromJson(res.data ?? {});
      logg('[CREATE] createPengajuan response: ${res.data}');
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  RxList<FormManager> formPo = RxList([]);
  RxList<FormManager> formDetail = <FormManager>[].obs;
  RxString caraPembayaran = ''.obs;

  List<Map<String, dynamic>> po = [];
  List<Map<String, dynamic>> sat = [];
  Future openPo() async {
    final query = {'limit': 'all'};
    try {
      if (po.isEmpty) {
        final res = await api.poNon.getData(query).ui.loading();
        po = List<Map<String, dynamic>>.from(res.data ?? []);
        logg('[OPEN_PO] jumlah data PO: ${po.length}');
      }

      forms.set('no_po_nonppn', '').options(
            po
                .where((e) => e['no_po_nonppn'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['no_po_nonppn'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void onSelectPo(String id) {
    logg('[ON_SELECT_PO] id terpilih: $id');
    final selected = po.firstWhere(
      (e) => e['id'].toString() == id,
      orElse: () => <String, dynamic>{},
    );

    if (selected.isEmpty) {
      logg('[ON_SELECT_PO] PO tidak ditemukan');
      return;
    }

    final details = List<Map<String, dynamic>>.from(selected['detail'] ?? []);
    logg('[ON_SELECT_PO] Jumlah detail PO: ${details.length}');
    logg('[ON_SELECT_PO] Data detail: $details');

    formDetail.clear();
    for (var d in details) {
      final form = LzForm.make([
        'item_id',
        'nama_barang',
        'jumlah_keluar',
        'berat_satuan',
        'qty',
        'kode_material',
        'total'
      ]);
      form.set('item_id', d['id']?.toString() ?? '');
      form.set('nama_barang', d['nama_barang'] ?? '');
      form.set('qty', d['qty']?.toString() ?? '0');
      form.set('jumlah_keluar', d['jumlah_keluar']?.toString() ?? '0');
      form.set('berat_satuan', d['berat_satuan']?.toString() ?? '0');
      form.set('kode_material', d['kode_material'] ?? '');
      formDetail.add(form);
    }
    logg('[ON_SELECT_PO] formDetail count: ${formDetail.length}');
  }

  Future openKodeMat(int index) async {
    try {
      if (sat.isEmpty) {
        final res = await api.stokMaterial.getData().ui.loading();
        sat = List<Map<String, dynamic>>.from(res.data ?? []);
        logg('[OPEN_KODE_MAT] jumlah material: ${sat.length}');
      }

      if (sat.isEmpty) {
        Toast.warning('Data material masih kosong');
        return;
      }

      formDetail[index].set('kode_material', '').options(
            sat
                .where((e) => e['kode_material'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['kode_material'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future<void> onSubmit() async {
    try {
      if (created == null) {
        return Toast.show('Tidak dapat diproses.');
      }

      final itemIds = formDetail
          .map((form) {
            final id = form.get('item_id');
            return id is int ? id : null;
          })
          .whereType<int>()
          .toList();

      final namaBarangs = formDetail
          .map((e) => e.get('nama_barang')?.toString() ?? '')
          .toList();

      final kodeMaterials = formDetail.map((e) {
        final v = e.get('kode_material');
        return (v == null || v.toString().trim().isEmpty) ? null : v.toString();
      }).toList();

      final qtys =
          formDetail.map((e) => e.get('qty')?.toString() ?? '0').toList();

      final beratSatuans = formDetail
          .map((e) => e.get('berat_satuan')?.toString() ?? '0')
          .toList();

      final jumlahKeluars = formDetail
          .map((e) => e.get('jumlah_keluar')?.toString() ?? '0')
          .toList();

      final payload = {
        'no_delivery': created!.noDelivery,
        "no_po_nonppn": forms.get('no_po_nonppn') ?? '',
        'item_id': itemIds,
        "shipment_date": forms.get('shipment_date') ?? '',
        "received_date": forms.get('received_date') ?? '',
        "lokasi_kirim": forms.get('lokasi_kirim') ?? '',
        "penerima": forms.get('penerima') ?? '',
        "ekspedisi": forms.get('ekspedisi') ?? '',
        "harga_ekspedisi":
            num.tryParse(forms.get('harga_ekspedisi')?.toString() ?? '0') ?? 0,
        "nama_barang": namaBarangs,
        "kode_material": kodeMaterials,
        "qty": qtys,
        "berat_satuan": beratSatuans,
        "jumlah_keluar": jumlahKeluars,
      };
      logg('[PAYLOAD] $payload');
      final res = await api.delPoNonPpn
          .updateData(payload, created!.noHide!)
          .ui
          .loading('Memproses...');

      logg('[RESPONSE] ${res.data}');

      if (res.status) {
        Get.back(result: res.data);
        Get.snackbar('Berhasil', res.message ?? '');
      } else {
        Get.snackbar('Gagal', res.message.toString());
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void hitungTotal(int index) {
    try {
      final form = formDetail[index];

      final jumlah = double.tryParse(form.get('jumlah_keluar') ?? '0') ?? 0;
      final berat = double.tryParse(form.get('berat_satuan') ?? '0') ?? 0;
      final total = jumlah * berat;

      final formatter = NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
        decimalDigits: 0,
      );
      final totalFormatted = formatter.format(total);
      form.set('total', totalFormatted);
      logg(
          '[HITUNG_TOTAL] index: $index | jumlah: $jumlah | berat: $berat | total: $totalFormatted');
    } catch (e) {
      logg('[HITUNG_TOTAL_ERROR] $e');
    }
  }
}
