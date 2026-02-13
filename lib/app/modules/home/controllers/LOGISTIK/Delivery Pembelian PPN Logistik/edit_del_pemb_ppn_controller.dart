import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_pemb_ppn/del_pemb_ppn.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_pemb_ppn/detail.dart';

class EditDelPembPpnController extends GetxController with Apis {
  DelPembPpn? data;
  DelPembPpn details = DelPembPpn();
  RxBool isLoading = true.obs;
  RxList<DetailDelPembPpn> cards = RxList([]);
  RxList<FormManager> formData = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();

  final formatRp =
      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
  Future getDetails(DelPembPpn? data) async {
    try {
      String? nohide = data?.noHide;
      final res = await api.delPembPpn.getDataNoHide(nohide);
      details = DelPembPpn.fromJson(res.data ?? {});
      cards.value = details.detail ?? [];

      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'item_id',
          'kode_material',
          'qty',
          'nama_barang',
          'jumlah_keluar',
          'berat_satuan',
          'total',
        ]);

        form.fill({
          'item_id': e.id,
          'kode_material': e.kodeMaterial ?? '-',
          'qty': e.qty?.toString() ?? '-',
          'nama_barang': e.namaBarang ?? '',
        });

        return form;
      }).toList();
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  final forms = LzForm.make([
    'no_pembelian',
    'no_delivery',
    'kode_material',
    'shipment_date',
    'received_date',
    'lokasi_pengiriman',
    'penerima',
    'ekspedisi',
    'harga_ekspedisi',
  ]);

  @override
  void onReady() {
    super.onReady();
    if (data != null) {
      forms.fill(data!.toJson());
      getDetails(data!);
    }
  }

  RxList<FormManager> formPo = RxList([]);

  RxString caraPembayaran = ''.obs;

  List<Map<String, dynamic>> po = [];
  List<Map<String, dynamic>> sat = [];

  Future openPo() async {
    final query = {'limit': 'all'};
    try {
      if (po.isEmpty) {
        final res = await api.pembPpn.getData(query).ui.loading();
        po = List<Map<String, dynamic>>.from(res.data ?? []);
        logg('[OPEN_PO] jumlah data PO: ${po.length}');
      }

      forms.set('no_pembelian', '').options(
            po
                .where((e) => e['no_pembelian'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['no_pembelian'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void onSelectPo(String id) {
    final selected = po.firstWhere(
      (e) => e['id'].toString() == id,
      orElse: () => <String, dynamic>{},
    );

    if (selected.isEmpty) return;

    final details = List<Map<String, dynamic>>.from(selected['detail'] ?? []);

    formDetails.clear();
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
      form.set('total', '0');

      formDetails.add(form);
    }
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

      formDetails[index].set('kode_material', '').options(
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
      final isCreateBaru = (details.detail == null || details.detail!.isEmpty);

      final itemIds = isCreateBaru
          ? []
          : formDetails
              .map((form) {
                final id = form.get('item_id');
                return id is int ? id : int.tryParse('$id');
              })
              .whereType<int>()
              .toList();

      final namaBarangs = formDetails
          .map((e) => e.get('nama_barang')?.toString() ?? '')
          .toList();

      final kodeMaterials = formDetails
          .map((e) => e.get('kode_material')?.toString() ?? '')
          .toList();

      final qtys =
          formDetails.map((e) => e.get('qty')?.toString() ?? '0').toList();

      final beratSatuans = formDetails
          .map((e) => e.get('berat_satuan')?.toString() ?? '0')
          .toList();

      final jumlahKeluars = formDetails
          .map((e) => e.get('jumlah_keluar')?.toString() ?? '0')
          .toList();

      final payload = {
        "no_pembelian": forms.get('no_pembelian') ?? '',
        'item_id': itemIds,
        "shipment_date": forms.get('shipment_date') ?? '',
        "received_date": forms.get('received_date') ?? '',
        "lokasi_pengiriman": forms.get('lokasi_pengiriman') ?? '',
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

      final res = await api.delPembPpn
          .updateData(payload, data!.noHide!)
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
      final form = formDetails[index];

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
