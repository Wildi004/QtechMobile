import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/po_non/po_non.dart';

class CreatePoNonController extends GetxController with Apis {
  PoNon? created;
  RxBool isSubmitted = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'no_po_nonppn',
    'suplier_id',
    'tgl_po',
    'tgl_dikirim',
    'lokasi_pengiriman',
    'cara_pembayaran',
    'term_from',
    'freight_cost',
    'term_to',
    'dp',
    'sub_total',
    'grand_total',
    'dp_amount',
  ]);

  RxList<FormManager> formRabs = RxList([]);
  RxList<String> types = RxList([]);

  RxInt grandTotal = 0.obs;

  @override
  void onInit() {
    createPengajuan();
    super.onInit();
  }

  Future deleteData(String noHide) async {
    try {
      final res = await api.poNon.deleteData(noHide).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      isLoading.refresh();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future<void> createPengajuan() async {
    try {
      isLoading.value = true;
      final res = await api.poNon.createData();
      forms.fill(res.data ?? {});
      created = PoNon.fromJson(res.data ?? {});
      logg('createPengajuan response: ${res.data}');
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  RxList<FormManager> formPo = RxList([]);
  RxList<int> cards = <int>[].obs;
  RxString caraPembayaran = ''.obs;

  void addPo() {
    final form = LzForm.make([
      'nama_barang',
      'satuan_id',
      'unit_price',
      'qty',
      'diskon',
      'amount',
    ]);
    satuans.insert(0, null);
    formPo.insert(0, form);
    final newId = (cards.isEmpty ? 0 : (cards.first + 1));
    cards.insert(0, newId);
  }

  void removePo(int index) {
    formPo.removeAt(index);
    satuans.removeAt(index);

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
        'no_po_nonppn',
        'tgl_po',
        'tgl_dikirim',
        'jenis_pembayaran',
        'suplier_id',
        'lokasi_pengiriman',
      ]);
      if (!head.ok) {
        Get.snackbar('Error', 'Form utama belum lengkap!');
        return;
      }
      for (var f in formPo) {
        f.validate(required: [
          'nama_barang',
          'satuan_id',
          'unit_price',
          'qty',
          'diskon',
        ]);
      }

      final payload = {
        ...forms.value,
        'no_po_nonppn': created!.noPoNonppn,
        'satuan_id': satuans,
        'suplier_id': sup.firstWhere(
          (e) => e['nama_perusahaan'] == forms.get('suplier_id'),
          orElse: () => {'id': null},
        )['id'],
        'nama_barang': formPo.map((e) => e.get('nama_barang') ?? '').toList(),
        'unit_price': formPo
            .map((e) =>
                (e.get('unit_price') ?? '0').toString().numeric.toString())
            .toList(),
        'qty': formPo
            .map((e) => (e.get('qty') ?? '0').toString().numeric.toString())
            .toList(),
        'diskon': formPo
            .map((e) => (e.get('diskon') ?? '0').toString().numeric.toString())
            .toList(),
      };
      final res = await api.poNon
          .updateData(payload, created!.noHide!)
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

  List satuans = [];
  void onSelectSatuan(int index) {
    try {
      satuans[index] = formPo[index].extra('satuan_id');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void hitungTotal() {
    double subTotal = 0.0;
    for (var f in formPo) {
      double qty = double.tryParse(f.get('qty').toString()) ?? 0.0;
      double harga = f.get('unit_price').toString().numeric.toDouble();
      double diskon = double.tryParse(f.get('diskon').toString()) ?? 0.0;
      double amount = qty * harga * (1 - (diskon / 100));
      String formattedAmount =
          amount.toString().currency().replaceAll('\$', '');
      f.set('amount', 'Rp $formattedAmount');
      subTotal += amount;
    }
    double freight =
        double.tryParse(forms.get('freight_cost').toString()) ?? 0.0;
    double grand = subTotal + freight;
    double dpPercent = double.tryParse(forms.get('dp').toString()) ?? 0.0;
    double dpAmount = grand * dpPercent / 100;
    String formattedSubTotal =
        subTotal.toString().currency().replaceAll('\$', '');
    String formattedGrand = grand.toString().currency().replaceAll('\$', '');
    String formattedDp = dpAmount.toString().currency().replaceAll('\$', '');
    forms.set('sub_total', 'Rp $formattedSubTotal');
    forms.set('grand_total', 'Rp $formattedGrand');
    forms.set('dp_amount', 'Rp $formattedDp');
  }
}
