import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_pemb_non_ppn/del_pemb_non_ppn.dart';

class CreateDelPembNonPpnController extends GetxController with Apis {
  DelPembNonPpn? created;
  RxBool isLoading = true.obs;
  RxBool isSubmitted = false.obs;

  final forms = LzForm.make([
    'no_pembelian',
    'no_delivery',
    'shipment_date',
    'received_date',
    'ekspedisi',
    'penerima',
    'lokasi_pengiriman',
    'harga_ekspedisi',
  ]);

  @override
  void onInit() {
    createPemb();
    super.onInit();
  }

  Future<void> createPemb() async {
    try {
      isLoading.value = true;
      final res = await api.delPembNonPpn.createData();
      forms.fill(res.data ?? {});
      created = DelPembNonPpn.fromJson(res.data ?? {});
      logg('[CREATE] createPengajuan response: ${res.data}');
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteData(String noHide) async {
    try {
      final res =
          await api.delPembNonPpn.deleteData(noHide).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      isLoading.refresh();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxList<FormManager> formDetail = <FormManager>[].obs;
  List<Map<String, dynamic>> pemb = [];
  List<Map<String, dynamic>> sat = [];

  Future openPemb() async {
    final query = {'limit': 'all'};
    try {
      if (pemb.isEmpty) {
        final res = await api.pembNonPpn.getData(query).ui.loading();
        pemb = List<Map<String, dynamic>>.from(res.data ?? []);
        logg('[pembelian] jumlah data pembelian: ${pemb.length}');
      }

      forms.set('no_pembelian', '').options(
            pemb
                .where(
                    (e) => e['no_pembelian_nonppn'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['no_pembelian_nonppn'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void onSelectPemb(String id) {
    logg('[onSelectPemb] id terpilih: $id');
    final selected = pemb.firstWhere(
      (e) => e['id'].toString() == id,
      orElse: () => <String, dynamic>{},
    );

    if (selected.isEmpty) {
      logg('[onSelectPemb] PO tidak ditemukan');
      return;
    }

    final details = List<Map<String, dynamic>>.from(selected['detail'] ?? []);
    logg('[onSelectPemb] Jumlah detail PO: ${details.length}');
    logg('[onSelectPemb] Data detail: $details');

    formDetail.clear();
    for (var d in details) {
      final form = LzForm.make([
        'item_id',
        'nama_barang',
        'qty',
        'berat_satuan',
        'jumlah_keluar',
        'total',
      ]);

      form.set('item_id', d['id']?.toString() ?? '');
      form.set('nama_barang', d['nama_barang'] ?? '');
      form.set('qty', d['qty']?.toString() ?? '0');
      form.set('jumlah_keluar', d['jumlah_keluar']?.toString() ?? '0');
      form.set('berat_satuan', d['berat_satuan']?.toString() ?? '0');
      formDetail.add(form);
    }

    logg('[ON_SELECT_PO] formDetail count: ${formDetail.length}');
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
        "qty": qtys,
        "berat_satuan": beratSatuans,
        "jumlah_keluar": jumlahKeluars,
      };
      logg('[PAYLOAD] $payload');

      final res = await api.delPembNonPpn
          .updateData(payload, created!.noHide!)
          .ui
          .loading('Memproses...');

      logg('[RESPONSE] ${res.data}');

      if (res.status) {
        isSubmitted.value = true;
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
