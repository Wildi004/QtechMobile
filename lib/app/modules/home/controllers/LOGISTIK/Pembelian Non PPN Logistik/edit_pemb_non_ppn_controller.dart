import 'package:get/get.dart' hide Bindings;
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pemb_non_ppn/detail.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pemb_non_ppn/pemb_non_ppn.dart';

class EditPembNonPpnController extends GetxController with Apis {
  PembNonPpn? data;
  PembNonPpn details = PembNonPpn();
  RxBool isLoading = true.obs;
  RxList<DetailPembNon> cards = RxList([]);
  RxList<FormManager> formData = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();
  PembNonPpn? details1;

  final formatRp =
      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
  Future getDetails(PembNonPpn? data) async {
    try {
      String? nohide = data?.noHide;
      final res = await api.pembNonPpn.getDataNoHide(nohide);
      details = PembNonPpn.fromJson(res.data ?? {});
      cards.value = (details.detail ?? []).cast<DetailPembNon>();

      formPo.value = cards.map((e) {
        final form = LzForm.make([
          'kode_material',
          'nama_barang',
          'qty',
          'satuan_id',
          'harga_satuan',
          'diskon',
          'total_harga',
        ]);

        form.fill({
          'kode_material': e.kodeMaterial ?? '-',
          'nama_barang': e.namaBarang ?? '',
          'qty': e.qty?.toString() ?? '0',
          'satuan_id': e.satuanId?.toString() ?? '',
          'harga_satuan': e.hargaSatuan?.toString() ?? '0',
          'diskon': e.diskon?.toString() ?? '0',
          'total_harga': e.totalHarga?.toString() ?? '0',
        });

        return form;
      }).toList();

      satuans = cards.map((e) => e.satuanId?.toString()).toList();
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future getDetailData(String nohide) async {
    try {
      Bindings.onRendered(() async {
        Toast.overlay('Loading...', onCancel: () {});

        if (details1 == null) {
          final res = await api.pembNonPpn.getDataNoHide(nohide);
          details1 = PembNonPpn.fromJson(res.data ?? {});
        }

        forms.fill(details1!.toJson());

        forms.set(
          'suplier_id',
          Option(details1!.suplierName ?? '-', value: details1!.suplierId),
        );

        await getSupp(details1!.suplierId);

        Toast.dismiss();
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  List<Map<String, dynamic>> sup = [];

  Future getSupp(int? id) async {
    final res = await api.supplier.getData();
    sup = List<Map<String, dynamic>>.from(res.data ?? []);

    final option = sup.firstWhere((e) => e['id'] == id, orElse: () => {});

    if (option['id'] != null) {
      // ✅ hanya satu kali set, dengan Option
      forms.set(
        'suplier_id',
        Option(option['nama_perusahaan'], value: option['id']),
      );
    }
  }

  final forms = LzForm.make([
    'no_pembelian_nonppn', //
    'shipment', //
    'tgl_beli', //
    'no_invoice', //
    'cara_pembayaran', //
    'jenis_pembayaran', //
    'term_from', //
    'term_to', //
    'suplier_id', //
    'diskon_ttl', //
    'ppn', //
    'biaya_kirim', //
    'total_harga', //
    'dpp_pembelian', //
    'ppn_total', //
    'total_pembelian', //
  ]);

  RxList<FormManager> formPo = RxList([]);
  RxList<int> card = <int>[].obs;
  List cat = [];
  void addPo() {
    final form = LzForm.make([
      'kode_material',
      'nama_barang',
      'qty',
      'satuan_id',
      'harga_satuan',
      'diskon',
      'total_harga',
    ]);

    formPo.insert(0, form);

    // item baru => id null
    cards.insert(0, DetailPembNon(id: null));
    satuans.insert(0, null);
    cat.insert(0, null);
  }

  void removePo(int index) {
    if (index >= 0 && index < formPo.length) {
      formPo.removeAt(index);
    }

    if (index >= 0 && index < cards.length) {
      cards.removeAt(index);
    }

    if (index >= 0 && index < cat.length) {
      cat.removeAt(index);
    }
    satuans.removeAt(index);
  }

  RxString caraPembayaran = ''.obs;

  Future onSubmit() async {
    try {
      // buat daftar required awal
      final requiredFields = [
        'no_pembelian_nonppn',
        'shipment',
        'tgl_beli',
        'no_invoice',
        'cara_pembayaran',
        'jenis_pembayaran',
        'suplier_id',
      ];

      // kalau pilih termin → tambahkan field tambahan
      final dataForm = Map<String, dynamic>.from(forms.value);

// hapus term_from dan term_to jika cash
      if (dataForm['cara_pembayaran'].toString().toLowerCase() == 'cash') {
        dataForm.remove('term_from');
        dataForm.remove('term_to');
      }

      final itemId = cards.map((e) => e.id).where((id) => id != null).toList();

      // validasi header
      final head = forms.validate(required: requiredFields);
      logg('📝 [onSubmit] Hasil validasi header: ${head.ok} - ${head.value}');

      if (!head.ok) {
        Get.snackbar('Error', 'Form utama belum lengkap!');
        return;
      }

      // pastikan field angka ada default value
      forms.set('diskon_ttl', forms.get('diskon_ttl') ?? '0');
      forms.set('ppn', forms.get('ppn') ?? '0');
      forms.set('biaya_kirim', forms.get('biaya_kirim') ?? '0');

      // validasi detail form
      for (var f in formPo) {
        final det = f.validate(required: [
          'kode_material',
          'nama_barang',
          'qty',
          'satuan_id',
          'harga_satuan',
          'diskon',
        ]);

        if (!det.ok) {
          final missingFields = [
            'kode_material',
            'nama_barang',
            'qty',
            'satuan_id',
            'harga_satuan',
            'diskon',
          ]
              .where(
                  (key) => f.get(key) == null || f.get(key).toString().isEmpty)
              .toList();

          logg('❌ Detail belum lengkap, field kosong: $missingFields');
          Get.snackbar('Error', 'Detail PO belum lengkap! ($missingFields)');
          return;
        }

        logg('✅ Detail valid: ${det.value}');
      }
      forms.set('biaya_kirim',
          forms.get('biaya_kirim')?.toString().replaceAll(',', '') ?? '0');
      forms.set('diskon_ttl',
          forms.get('diskon_ttl')?.toString().replaceAll(',', '') ?? '0');
      forms.set('ppn', forms.get('ppn')?.toString().replaceAll(',', '') ?? '0');

      final payload = {
        ...dataForm,
        'item_id': itemId,
        'suplier_id': (forms.extra('suplier_id') is Option)
            ? int.tryParse(
                (forms.extra('suplier_id') as Option).value.toString())
            : int.tryParse(forms.extra('suplier_id')?.toString() ?? '0'),
        'ppn': parseNumber(forms.get('ppn')),
        'kode_material': formPo.map((e) => e.get('kode_material')).toList(),
        'nama_barang': formPo.map((e) => e.get('nama_barang') ?? '').toList(),
        'satuan_id': satuans,
        'harga_satuan': formPo
            .map((e) =>
                (e.get('harga_satuan') ?? '0').toString().numeric.toString())
            .toList(),
        'qty': formPo
            .map((e) => (e.get('qty') ?? '0').toString().numeric.toString())
            .toList(),
        'diskon': formPo
            .map((e) => (e.get('diskon') ?? '0').toString().numeric.toString())
            .toList(),
      };

      final res = await api.pembNonPpn
          .updateData(payload, data!.noHide!)
          .ui
          .loading('Memproses...');

      if (res.status) {
        Get.back(result: res.data);
        Get.snackbar('Berhasil', res.message ?? '');
      } else {
        Toast.show(res.message ?? 'Gagal mengirim data');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  final shipment = [
    {'name': 'Pick Up'},
    {'name': 'Delivery'},
  ];
  Future<List<Map>> getShipment() async {
    return shipment;
  }

  RxList<FormManager> supId = RxList<FormManager>();

  RxList<FormManager> satId = RxList<FormManager>();
  List<Map<String, dynamic>> sat = [];

  Future openSupp() async {
    final query = {'limit': 'all'};
    logg(query);
    try {
      if (sup.isEmpty) {
        final res = await api.supplier.getData(query).ui.loading();
        sup = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      forms.set('suplier_id', '').options(
            sup
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

  Future openSat(int index) async {
    final query = {'limit': 'all'};

    try {
      if (sat.isEmpty) {
        final res = await api.satuanLogistik.getData(query).ui.loading();
        sat = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      formPo[index].set('satuan_id', '').options(
            sat
                .where((e) => e['satuan'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['satuan'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxList<FormManager> stokId = RxList<FormManager>();
  List<Map<String, dynamic>> stok = [];
  Future openStok(int index) async {
    final query = {'limit': 'all'};

    try {
      if (stok.isEmpty) {
        final res = await api.stokMaterial.getData(query).ui.loading();
        stok = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      final opts = stok
          .where((e) => e['kode_material'] != null && e['id'] != null)
          .map((e) => {
                'label': '${e['kode_material']}',
                'value': e['id'], // pastikan ini int
              })
          .toList();

      if (opts.isEmpty) {
        return;
      }

      formPo[index].set('kode_material', '').options(opts);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void hitungTotal() {
    double dpp = 0.0;

    // Hitung total harga per item
    for (var form in formPo) {
      double qty = double.tryParse(form.get('qty').toString()) ?? 0;
      double harga = double.tryParse(form
              .get('harga_satuan')
              .toString()
              .replaceAll('.', '')
              .replaceAll(',', '')) ??
          0;
      double diskon = double.tryParse(form.get('diskon').toString()) ?? 0;

      double total = qty * harga * (1 - (diskon / 100));
      form.set('total_harga', total.toStringAsFixed(0));

      dpp += total;
    }

    double diskonTotal =
        double.tryParse(forms.get('diskon_ttl').toString()) ?? 0;
    double ppnPersen = double.tryParse(
          forms.get('ppn').toString().replaceAll(RegExp(r'[^0-9.]'), ''),
        ) ??
        0;
    double biayaKirim =
        double.tryParse(forms.get('biaya_kirim').toString()) ?? 0;

    double ppnTotal = (dpp - diskonTotal) * (ppnPersen / 100);

    double totalPembelian = (dpp - diskonTotal) + ppnTotal + biayaKirim;

    forms.set('dpp_pembelian', dpp.toStringAsFixed(0));
    forms.set('ppn_total', ppnTotal.toStringAsFixed(0));
    forms.set('total_pembelian', totalPembelian.toStringAsFixed(0));
  }

  final pemb = [
    {'name': 'Normal'},
    {'name': 'Backup Cek'},
  ];

  Future<List<Map>> getPemb() async {
    return pemb;
  }

  int parseNumber(dynamic value) {
    if (value == null) return 0;
    final cleaned = value.toString().replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleaned) ?? 0;
  }

  List<String?> satuans = [];

  void onSelectSatuan(int index) {
    try {
      satuans[index] = formPo[index].extra('satuan_id');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
