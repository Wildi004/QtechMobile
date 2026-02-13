import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pengajuan_logistik/detail.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/rab_logistik/rab_detail.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/rab_logistik/rab_logistik.dart';

class CreatePengajuanLogistikController extends GetxController with Apis {
  DetailPengajuanLogistik? created;
  RxBool isLoading = true.obs;
  RxBool isSubmitted = false.obs;

  final forms = LzForm.make(['no_pengajuan', 'tgl_pengajuan', 'dep_name']);

  RxList<FormManager> formRabs = RxList([]);
  RxList<String> types = RxList([]);

  RxInt grandTotal = 0.obs;

  List<RabLogistik> dataRab = [];
  List<RabDetaillogistik> dataRabDetails = [];
  List<DetailPengajuanLogistik> dataPengajuan = [];

  @override
  void onInit() {
    createPengajuan();
    super.onInit();
  }

  Future<void> createPengajuan() async {
    try {
      isLoading.value = true;
      final res = await api.pengajuanGlobal.createPengajuanLogistik();
      forms.fill(res.data ?? {});
      created = DetailPengajuanLogistik.fromJson(res.data ?? {});
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void removeRab(int index) {
    List rabs = formRabs.map((e) => e.value['type'] ?? 'None').toList();

    formRabs.removeAt(index);
    types.removeAt(index);
    rabs.removeAt(index);

    if (formRabs.isEmpty) {
      grandTotal.value = 0;
    } else {
      grandTotal.value = formRabs
          .map((e) => (e.get('total') ?? '0').numeric)
          .reduce((a, b) => a + b);
    }

    Utils.timer(() {
      for (var i = 0; i < formRabs.length; i++) {
        formRabs[i].set('type', rabs[i]);
      }
    }, 100.ms);
  }

  void addRab() {
    String type = types.isEmpty ? 'None' : types[0];

    final form =
        LzForm.make(['type', 'nama_item', 'jumlah', 'satuan', 'total']);

    formRabs.insert(0, form);
    formRabs[0].fill({'type': type});

    types.insert(0, type);

    Utils.timer(() {
      for (int i = 0; i < types.length; i++) {
        formRabs[i].set('type', types[i]);
      }
    }, 100.ms);
  }

  Future<void> getRab(String value, int index) async {
    if (value == 'RAB' && dataRabDetails.isEmpty) {
      final res =
          await api.rabGlobal.getRabDetailLogistik(limit: 'all').ui.loading();
      dataRabDetails = RabDetaillogistik.fromJsonList(res.data);
    }

    types[index] = value;

    if (value == 'None') {
      formRabs[index].set('type', 'None');
      formRabs[index].set('nama_item', '');
      formRabs[index].set('satuan', '');
      formRabs[index].set('jumlah', '');
      formRabs[index].set('total', '');
      formRabs[index].set('item_id', 0);
    }

    if (value == 'RAB') {
      // 🔹 Reset data manual sebelumnya supaya tidak nyangkut
      formRabs[index].set('type', 'RAB');
      formRabs[index].set('nama_item', '');
      formRabs[index].set('satuan', '');
      formRabs[index].set('jumlah', '');
      formRabs[index].set('total', '');
      formRabs[index].set('item_id', 0);
    }

    if (formRabs.isEmpty) {
      grandTotal.value = 0;
    } else {
      grandTotal.value = formRabs
          .map((e) => (e.get('total') ?? '0').numeric)
          .fold(0, (a, b) => a + b);
    }
  }

  Future<void> deletePengajuan(String noHide) async {
    try {
      await api.pengajuanGlobal.deleteDataLogistik(noHide);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void setUnit(String value, int index) {
    final item = dataRabDetails.firstWhere(
      (e) => e.namaItem == value,
      orElse: () => RabDetaillogistik(),
    );

    if (item.total != null) {
      formRabs[index]
          .set('satuan', item.total.currency(separator: ',', prefix: ''));

      formRabs[index].set('jumlah', '1');

      countTotal(index);
    }
  }

  void countTotal(int index) {
    int unit = (formRabs[index].get('satuan') ?? '').numeric;
    int qty = (formRabs[index].get('jumlah') ?? '').numeric;

    int total = unit * qty;
    formRabs[index].set('total', total.currency(separator: ',', prefix: ''));

    grandTotal.value = formRabs
        .map((e) => (e.get('total') ?? '0').numeric)
        .reduce((a, b) => a + b);
  }

  Future<void> onSubmit() async {
    try {
      if (created == null) {
        return Toast.show('Tidak dapat diproses.');
      }

      final jenisRabs = types.map((e) => e == 'None' ? 'NonRAB' : e).toList();

      final namaBarangs =
          formRabs.map((e) => e.get('nama_item') ?? '').toList();

      final qtys =
          formRabs.map((e) => (e.get('jumlah') ?? '0').numeric).toList();
      final hargas =
          formRabs.map((e) => (e.get('satuan') ?? '0').numeric).toList();

      final itemIds = formRabs
          .map((form) {
            final id = form.get('item_id');
            return id is int ? id : null;
          })
          .whereType<int>()
          .toList();

      final rabIds = formRabs.map((form) {
        final namaItem = form.get('nama_item');
        final matched = dataRabDetails.firstWhere(
          (d) => d.namaItem == namaItem,
          orElse: () => RabDetaillogistik(),
        );
        return matched.id ?? 0;
      }).toList();

      final payload = {
        'no_pengajuan': created!.noPengajuan,
        'item_id': itemIds,
        'rab_id': rabIds,
        'jenis_rab': jenisRabs,
        'nama_barang': namaBarangs,
        'qty': qtys,
        'harga': hargas,
      };

      final res = await api.pengajuanGlobal
          .updatePengajuanlogistik(payload, created!.noHide!)
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
}
/*Future<void> onSubmit() async {
    try {
      if (created == null) {
        return Toast.show('Tidak dapat diproses.');
      }

      final itemIds = formDetail
          .map((form) {
            final id = form.get('item_id');
            return int.tryParse(id.toString());
          })
          .whereType<int>()
          .toList();

      final namaBarangs = formDetail
          .map((e) => e.get('nama_barang')?.toString() ?? '')
          .toList();

      final kodeMaterials = formDetail
          .map((e) => e.get('kode_material')?.toString() ?? '')
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

        "no_po": forms.get('no_po') ?? '',
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

      final res = await api.delPoPpn
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
  }*/
