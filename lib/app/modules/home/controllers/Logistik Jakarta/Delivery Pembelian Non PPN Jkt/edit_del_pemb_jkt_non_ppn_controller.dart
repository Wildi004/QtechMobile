import 'package:get/get.dart' hide Bindings;
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_pemb_non_ppn/del_pemb_non_ppn.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_pemb_non_ppn/detail.dart';

class EditDelPembNonPpnController extends GetxController with Apis {
  DelPembNonPpn? data;
  DelPembNonPpn details = DelPembNonPpn();
  RxBool isLoading = true.obs;
  RxList<DetailDelPembNon> cards = RxList([]);
  RxList<FormManager> formData = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();

  final formatRp =
      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
  Future getDetails(DelPembNonPpn? data) async {
    try {
      String? nohide = data?.noHide;
      final res = await api.delPembNonPpn.getDataNoHide(nohide);
      details = DelPembNonPpn.fromJson(res.data ?? {});
      cards.value = details.detail ?? [];

      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'item_id',
          'qty',
          'nama_barang',
          'jumlah_keluar',
          'berat_satuan',
          'total',
        ]);

        final totalHargaVal = num.tryParse(e.total.toString()) ?? 0;

        form.fill({
          'item_id': e.id,
          'qty': e.qty?.toString() ?? '-',
          'nama_barang': e.namaBarang ?? '',
          'jumlah_keluar': e.jumlahKeluar?.toString() ?? '-',
          'berat_satuan': e.beratSatuan?.toString() ?? '',
          'total': formatRp.format(totalHargaVal),
        });

        return form;
      }).toList();
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future getDetailData(String? nohide) async {
    try {
      Bindings.onRendered(() async {
        Toast.overlay('Loading...', onCancel: () {});

        if (data == null) {
          final res = await api.delPembNonPpn.getDataNoHide(nohide);
          data = DelPembNonPpn.fromJson(res.data ?? {});
        }

        forms.fill(data!.toJson());

        await getPemb(data?.noPembelian);

        Toast.dismiss();
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  final forms = LzForm.make([
    'no_pembelian_nonppn',
    'no_delivery',
    'shipment_date',
    'received_date',
    'lokasi_pengiriman',
    'penerima',
    'ekspedisi',
    'harga_ekspedisi',
  ]);

  @override
  void onReady() async {
    super.onReady();
    if (data != null) {
      logg('=== [onReady] noPembelian yang dikirim: ${data?.noPembelian}');
      await getPemb(data?.noPembelian);
      forms.fill(data!.toJson());
      await getDetails(data!);
    }
  }

  RxList<FormManager> formPo = RxList([]);

  RxString caraPembayaran = ''.obs;

  List<Map<String, dynamic>> po = [];
  List<Map<String, dynamic>> sat = [];
  List<Map<String, dynamic>> pos = [];

  Future<void> getPemb(String? nohide) async {
    logg('=== [getPemb] Mulai ambil data Pembelian, nohide: $nohide');

    final query = {'limit': 'all'};
    final res = await api.pembNonPpn.getData(query).ui.loading();

    pos = List<Map<String, dynamic>>.from(res.data ?? []);
    logg('=== [getPemb] Jumlah pembelian dari API: ${pos.length}');
    logg(
        '=== [getPemb] Data pembelian pertama (sample): ${pos.isNotEmpty ? pos.first : 'Kosong'}');

    // cari berdasarkan no_pembelian_nonppn (bukan ID)
    final option = pos.firstWhere(
      (e) => e['no_pembelian_nonppn'].toString() == nohide.toString(),
      orElse: () => {},
    );

    if (option.isNotEmpty) {
      logg(
          '=== [getPemb] Pembelian ditemukan: ${option['no_pembelian_nonppn']} (${option['id']})');

      forms.set(
        'no_pembelian_nonppn',
        Option(option['no_pembelian_nonppn'], value: option['id']),
      );
    } else {
      logg('=== [getPemb] ❌ Pembelian dengan No $nohide tidak ditemukan!');
    }
  }

  Future openPemb() async {
    final query = {'limit': 'all'};
    try {
      if (po.isEmpty) {
        final res = await api.pembNonPpn.getData(query).ui.loading();
        po = List<Map<String, dynamic>>.from(res.data ?? []);
        logg('[OPEN_PO] jumlah data PO: ${po.length}');
      }

      forms.set('no_pembelian_nonppn', '').options(
            po
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
        'total'
      ]);

      form.set('item_id', d['id']?.toString() ?? '');
      form.set('nama_barang', d['nama_barang'] ?? '');
      form.set('qty', d['qty']?.toString() ?? '0');
      form.set('jumlah_keluar', d['jumlah_keluar']?.toString() ?? '0');
      form.set('berat_satuan', d['berat_satuan']?.toString() ?? '0');
      form.set('total', '0');

      formDetails.add(form);
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

      final qtys =
          formDetails.map((e) => e.get('qty')?.toString() ?? '0').toList();

      final beratSatuans = formDetails
          .map((e) => e.get('berat_satuan')?.toString() ?? '0')
          .toList();

      final jumlahKeluars = formDetails
          .map((e) => e.get('jumlah_keluar')?.toString() ?? '0')
          .toList();

      final payload = {
        "no_pembelian_nonppn": forms.get('no_pembelian_nonppn') ?? '',
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
