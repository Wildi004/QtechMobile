import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/rab_validasi/rab_validasi.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/rabdetail.dart';
import 'package:qrm_dev/app/data/models/pengajuan%20global/pengajuan%20sudah%20validasi/pengajuan_sudah_validasi/detail.dart';

class FormPengajuanController extends GetxController with Apis {
  DetailValidasi? created;
  RxBool isLoading = true.obs;

  final forms = LzForm.make(['no_pengajuan', 'tgl_pengajuan', 'dep_name']);
  RxBool isSubmitted = false.obs;

  RxList<FormManager> formRabs = RxList([]);
  RxList<String> types = RxList([]);

  RxInt grandTotal = 0.obs;

  List<RabValidasi> dataRab = [];
  List<Rabdetail1> dataRabDetails = [];
  List<DetailValidasi> dataPengajuan = [];

  @override
  void onInit() {
    createPengajuan();
    super.onInit();
  }

  Future<void> createPengajuan() async {
    try {
      isLoading.value = true;
      final res = await api.pengajuanGlobal.createPengajuanHrd();
      forms.fill(res.data ?? {});
      created = DetailValidasi.fromJson(res.data ?? {});
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

    final form = LzForm.make(
        ['type', 'nama_item', 'jumlah', 'satuan', 'total', 'item_id']);

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
      final res = await api.rabGlobal.getDataDetailRab().ui.loading();
      dataRabDetails = Rabdetail1.fromJsonList(res.data);
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

  void setUnit(String value, int index) {
    final item = dataRabDetails.firstWhere(
      (e) => e.namaItem == value,
      orElse: () => Rabdetail1(),
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

  Future<void> delete(String noHide) async {
    try {
      await api.pengajuanGlobal.deleteHrd(noHide);
    } catch (e, s) {
      Errors.check(e, s);
    }
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
          orElse: () => Rabdetail1(),
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
          .updateDataHrd(payload, created!.noHide!)
          .ui
          .loading('Memproses...');

      if (res.status) {
        isSubmitted.value = true;

        Get.back(result: res.data);

        Get.snackbar('Berhasil', res.message ?? '');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
