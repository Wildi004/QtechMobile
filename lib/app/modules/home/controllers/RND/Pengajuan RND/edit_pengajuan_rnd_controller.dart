import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20it/pengajuan_it/detail.dart';
import 'package:qrm_dev/app/data/models/models%20it/pengajuan_it/pengajuan_it.dart';
import 'package:qrm_dev/app/data/models/models%20it/rab_it/rab_detail_validasi.dart';
import 'package:qrm_dev/app/data/models/models%20it/rab_it/rab_it.dart';

class EditPengajuanRndController extends GetxController with Apis {
  PengajuanIt? data;
  final isFilled = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'no_pengajuan',
    'sub_total',
    "tgl_pengajuan",
    "item_id",
    "rab_id",
    "nama_barang",
    "qty",
    "harga",
    'dep_name',
    'jenis_rab',
  ]);

  final id = Get.parameters['id'];

  PengajuanIt details = PengajuanIt();
  RxList<DetailPengajuanIt> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();

  // get dulu data
  Future getItems() async {
    final res = await api.rabGlobal.getDataRnd();
    dataRabDetails = RabDetailValidasi.fromJsonList(res.data);
  }

  Future getDetails(PengajuanIt data) async {
    try {
      isLoading.value = true;
      String nohide = data.noHide ?? '';

      // await getItems();
      final res = await api.pengajuanGlobal.getDataRndByNoHide(nohide);

      details = PengajuanIt.fromJson(res.data ?? {});
      cards.value = details.detail ?? [];

      created = DetailPengajuanIt.fromJson(res.data ?? {});

      final formatRp =
          NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

      formRabs.value = cards.map((e) {
        final form = LzForm.make(
            ['type', 'nama_item', 'jumlah', 'satuan', 'total', 'item_id']);

        final data = {
          'type': e.jenisRab == 'NonRAB' ? 'None' : 'RAB',
          'nama_item': e.namaBarang ?? '',
          'jumlah': '${e.qty ?? ''}',
          'satuan': formatRp.format(e.harga ?? 0),
          'total': formatRp.format(e.totalHarga ?? 0),
          'item_id': e.id,
        };

        form.fill(data);
        form.set('nama_item', data['nama_item']);

        return form;
      }).toList();

      types.value =
          cards.map((e) => e.jenisRab == 'NonRAB' ? 'None' : 'RAB').toList();
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void setData(PengajuanIt newData) {
    data = newData;
    forms.fill(newData.toJson());
    getDetails(newData);
  }

  @override
  void onInit() {
    super.onInit();

    if (data != null) {
      forms.fill(data!.toJson());
      getDetails(data!);
    }
  }

  RxList<FormManager> formRabs = RxList([]);
  RxList<String> types = RxList([]);
  DetailPengajuanIt? created;
  List<RabIt> dataRab = [];
  List<RabDetailValidasi> dataRabDetails = [];
  List<DetailPengajuanIt> dataPengajuan = [];
  RxInt grandTotal = 0.obs;

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

  void setUnit(String value, int index) {
    final item = dataRabDetails.firstWhere(
      (e) => e.namaItem == value,
      orElse: () => RabDetailValidasi(),
    );

    if (item.total != null) {
      formRabs[index]
          .set('satuan', item.total.currency(separator: ',', prefix: ''));
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

  Future<void> getRab(String value, int index) async {
    if (value == 'RAB' && dataRabDetails.isEmpty) {
      final res = await api.rabGlobal.getDataRabRndDetail().ui.loading();
      dataRabDetails = RabDetailValidasi.fromJsonList(res.data);
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

      final itemId = formRabs
          .map((form) {
            final id = form.get('item_id');
            return id is int ? id : int.tryParse('$id');
          })
          .whereType<int>()
          .toList();

      final rabIds = formRabs.map((form) {
        final namaItem = form.get('nama_item');
        final matched = dataRabDetails.firstWhere(
          (d) => d.namaItem == namaItem,
          orElse: () => RabDetailValidasi(),
        );
        return matched.id ?? 0;
      }).toList();

      final payload = {
        'no_pengajuan': created!.noPengajuan,
        'item_id': itemId,
        'rab_id': rabIds,
        'jenis_rab': jenisRabs,
        'nama_barang': namaBarangs,
        'qty': qtys,
        'harga': hargas,
      };

      final res = await api.pengajuanGlobal
          .updateDataPengajuanRnd(payload, created!.noHide!)
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
