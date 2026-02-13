import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pemb_non_ppn/pemb_non_ppn.dart';

class CreatePembJktNonPpnController extends GetxController with Apis {
  PembNonPpn? created;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'no_pembelian_nonppn',
    'tgl_beli',
    'shipment',
    'suplier_id',
    'term_from',
    'term_to',
    'jenis_pembayaran',
  ]);

  RxList<FormManager> formRabs = RxList([]);
  RxList<String> types = RxList([]);

  RxInt grandTotal = 0.obs;

  @override
  void onInit() {
    createPengajuan();
    super.onInit();
  }

  Future<void> createPengajuan() async {
    try {
      isLoading.value = true;
      final res = await api.pembNonPpn.createDatajkt();
      forms.fill(res.data ?? {});
      created = PembNonPpn.fromJson(res.data ?? {});
      logg('createPengajuan response: ${res.data}');
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  RxList<FormManager> formPo = RxList([]);
  RxList<int> cards = <int>[].obs;
  List cat = [];
  RxString caraPembayaran = ''.obs;

  void addPo() {
    final form = LzForm.make([
      'kode_material',
      'nama_barang',
      'satuan_id',
      'harga_satuan',
      'qty',
      'diskon',
    ]);

    formPo.insert(0, form);
    final newId = (cards.isEmpty ? 0 : (cards.first + 1));
    cards.insert(0, newId);

    cat.insert(0, null);
  }

  void removePo(int index) {
    formPo.removeAt(index);

    if (formPo.isEmpty) {
    } else {}
  }

  Future<void> onSubmit([int? id]) async {
    try {
      if (created == null) {
        return Toast.show('Tidak dapat diproses.');
      }
      logg('== forms value: ${forms.value}');

      final head = forms.validate(required: [
        'tgl_beli',
        'no_invoice',
        'cara_pembayaran',
        'jenis_pembayaran',
        'suplier_id',
        'diskon_ttl',
        'biaya_kirim',
      ]);
      if (!head.ok) {
        Get.snackbar('Error', 'Form utama belum lengkap!');
        return;
      }
      for (var f in formPo) {
        f.validate(required: [
          'kode_material',
          'nama_barang',
          'satuan_id',
          'harga_satuan',
          'qty',
          'diskon',
        ]);
      }
      final itemIds = formRabs
          .map((form) {
            final id = form.get('item_id');
            return id is int ? id : null;
          })
          .whereType<int>()
          .toList();
      final invalidKodeMaterial = formPo.any((f) {
        final kode = f.get('kode_material');
        return kode == null || kode.toString().isEmpty;
      });

      if (invalidKodeMaterial) {
        Get.snackbar('Error', 'Kode material belum lengkap!');
        return;
      }

      final payload = {
        ...forms.value,
        'item_id': itemIds,
        'kode_material': formPo
            .map((e) => (e.get('kode_material') ?? '').toString())
            .toList(),
        'no_po_nonppn': created!.noPembelianNonppn,
        'satuan_id': formPo.map((e) {
          final v = e.extra('satuan_id');
          return v == null ? null : int.tryParse(v.toString());
        }).toList(),
        'suplier_id': sup.firstWhere(
          (e) => e['nama_perusahaan'] == forms.get('suplier_id'),
          orElse: () => {'id': null},
        )['id'],
        'nama_barang': formPo.map((e) => e.get('nama_barang') ?? '').toList(),
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
          .updateDatajkt(payload, created!.noHide!)
          .ui
          .loading('Memproses...');

      if (res.status) {
        Get.back(result: res.data);

        Get.snackbar('Berhasil', res.message ?? '');
      }
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
        final res = await api.stokMaterial.getDataJkt(query).ui.loading();
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

  Future<List<Map>> getShipment() async {
    return shipment;
  }

  final shipment = [
    {'name': 'Pick Up'},
    {'name': 'Delivery'},
  ];

  Future<List<Map>> getPemb() async {
    return pemb;
  }

  final pemb = [
    {'name': 'Normal'},
    {'name': 'Backup Cek'},
  ];
  RxList<FormManager> supId = RxList<FormManager>();
  List<Map<String, dynamic>> sup = [];
  Future openSupp() async {
    final query = {'limit': 'all'};

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
      logg('== Suplier terpilih: ${forms.get('suplier_id')}');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxList<FormManager> satId = RxList<FormManager>();
  List<Map<String, dynamic>> sat = [];

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
}
