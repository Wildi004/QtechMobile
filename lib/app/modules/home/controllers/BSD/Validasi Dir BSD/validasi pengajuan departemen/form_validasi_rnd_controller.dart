import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20it/pengajuan_it/detail.dart';
import 'package:qrm_dev/app/data/models/models%20it/pengajuan_it/pengajuan_it.dart';
import 'package:qrm_dev/app/data/models/models%20it/rab_it/rab_detail.dart';
import 'package:qrm_dev/app/data/models/models%20it/rab_it/rab_it.dart';

class FormValidasiRndController extends GetxController with Apis {
  PengajuanIt? data;
  final isFilled = false.obs;
  RxBool isLoading = true.obs;
  RxInt originalTotal = 0.obs;

  final forms = LzForm.make([
    'kesimpulan_status_validasi',
    'nama_barang',
    "harga",
    "qty",
    "status_acc",
    "komentar",
    'sub_total'
  ]);

  final id = Get.parameters['id'];

  PengajuanIt details = PengajuanIt();
  RxList<DetailPengajuanIt> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();

  Future getItems() async {
    final res = await api.rabGlobal.getDataRnd();
    dataRabDetails = RabDetailIt.fromJsonList(res.data);
  }

  Future getDetails(PengajuanIt data) async {
    try {
      isLoading.value = true;
      String nohide = data.noHide ?? '';

      final res = await api.pengajuanGlobal.getDataRndByNoHide(nohide);

      details = PengajuanIt.fromJson(res.data ?? {});
      cards.value = details.detail ?? [];

      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'nama_barang',
          'harga',
          'qty',
          'komentar',
          'status_acc',
        ]);

        form.fill({
          'nama_barang': e.namaBarang ?? '',
          'harga': e.harga?.toString() ?? '',
          'qty': e.qty?.toString() ?? '',
          'komentar': '',
          'status_acc': '',
        });

        return form;
      }).toList();
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void setData(PengajuanIt newData) {
    data = newData;

    final total = newData.subTotal ?? 0;

    originalTotal.value = total; // ⬅️ SIMPAN TOTAL ASLI

    forms.fill({
      'sub_total': total.toString(),
    });

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

  void onStatusAccChanged(String value) {
    if (value == 'Tolak') {
      forms.set('sub_total', '0');
    } else if (value == 'Acc') {
      forms.set('sub_total', originalTotal.value.toString());
    }
  }

  RxList<FormManager> formRabs = RxList([]);
  RxList<String> types = RxList([]);
  DetailPengajuanIt? created;
  List<RabIt> dataRab = [];
  List<RabDetailIt> dataRabDetails = [];
  List<DetailPengajuanIt> dataPengajuan = [];
  RxInt grandTotal = 0.obs;

  Future<List<Map>> getFinal() async {
    return gfinal;
  }

  final gfinal = [
    {'id': 1, 'name': 'Terima'},
    {'id': 2, 'name': 'Tolak'},
    {'id': 3, 'name': 'Pending'},
  ];

  Future<void> onSubmit(int? id) async {
    try {
      if (data == null) {
        return Toast.show('Data pengajuan tidak ditemukan.');
      }

      final kesimpulanValue =
          forms.get('kesimpulan_status_validasi')?.toString() ?? '';

      int kesimpulan;
      switch (kesimpulanValue) {
        case 'Terima':
          kesimpulan = 1;
          break;
        case 'Tolak':
          kesimpulan = 2;
          break;
        case 'Pending':
          kesimpulan = 3;
          break;
        default:
          return Toast.warning('Pilih kesimpulan validasi');
      }

      final itemId = <int>[];
      final namaBarang = <String>[];
      final qty = <int>[];
      final harga = <int>[];
      final statusAcc = <int>[];
      final komentar = <String>[];

      for (int i = 0; i < cards.length; i++) {
        final item = cards[i];
        final form = formDetails[i];

        itemId.add(item.id ?? 0);
        namaBarang.add(form.get('nama_barang') ?? '');
        qty.add((form.get('qty') ?? '0').numeric);
        harga.add((form.get('harga') ?? '0').numeric);
        final statusAccValue = form.get('status_acc')?.toString() ?? '';

        int acc;
        switch (statusAccValue) {
          case 'Acc':
            acc = 1;
            break;
          case 'Tolak':
            acc = 2;
            break;
          default:
            return Toast.warning(
              'Semua item harus dipilih status ACC',
            );
        }

        statusAcc.add(acc);

        komentar.add((form.get('komentar') ?? '').toString());
      }

      if (itemId.isEmpty) {
        return Toast.show('Tidak ada item yang bisa diproses.');
      }

      final int len = namaBarang.length;
      if ([qty, harga, statusAcc, komentar, itemId]
          .any((arr) => arr.length != len)) {
        return Toast.error('Jumlah data barang tidak konsisten.');
      }
      logg('item_id: ${itemId.length} => $itemId');
      logg('nama_barang: ${namaBarang.length} => $namaBarang');
      logg('qty: ${qty.length} => $qty');
      logg('harga: ${harga.length} => $harga');
      logg('status_acc: ${statusAcc.length} => $statusAcc');
      logg('komentar: ${komentar.length} => $komentar');

      final payload = {
        'kesimpulan_status_validasi': kesimpulan,
        'item_id': itemId,
        'nama_barang': namaBarang,
        'qty': qty,
        'harga': harga,
        'status_acc': statusAcc,
        'komentar': komentar,
      };

      final res = await api.pengajuanGlobal
          .getValidasiRnd(payload, data!.noHide!)
          .ui
          .loading('Mengirim validasi...');

      if (res.status) {
        Toast.show('Validasi berhasil dikirim');
        Get.back(result: true);
      } else {
        Toast.error(res.message ?? 'Gagal mengirim validasi');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
