import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pengajuan_logistik/detail.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pengajuan_logistik/pengajuan_logistik.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/rab_logistik/rab_detail.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/rab_logistik/rab_logistik.dart';

class FormValidasiLogistikController extends GetxController with Apis {
  PengajuanLogistik? data;
  final isFilled = false.obs;
  RxBool isLoading = true.obs;

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

  PengajuanLogistik details = PengajuanLogistik();
  RxList<DetailPengajuanLogistik> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();

  Future getItems() async {
    final res = await api.rabGlobal.getDatalogistik();
    dataRabDetails = RabDetaillogistik.fromJsonList(res.data);
  }

  Future getDetails(PengajuanLogistik data) async {
    try {
      isLoading.value = true;
      String nohide = data.noHide ?? '';

      final res = await api.pengajuanGlobal.getLogistikNoHide(nohide);

      details = PengajuanLogistik.fromJson(res.data ?? {});
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

  void setData(PengajuanLogistik newData) {
    data = newData;

    forms.fill({
      'sub_total': newData.subTotal?.toString() ?? '',
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

  RxList<FormManager> formRabs = RxList([]);
  RxList<String> types = RxList([]);
  DetailPengajuanLogistik? created;
  List<RabLogistik> dataRab = [];
  List<RabDetaillogistik> dataRabDetails = [];
  List<DetailPengajuanLogistik> dataPengajuan = [];
  RxInt grandTotal = 0.obs;

  Future<List<Map>> getFinal() async {
    return gfinal;
  }

  final gfinal = [
    {'id': 0, 'name': 'Tolak'},
    {'id': 1, 'name': 'Terima'},
  ];

  Future<void> onSubmit(int? id) async {
    try {
      if (data == null) {
        return Toast.show('Data pengajuan tidak ditemukan.');
      }

      final kesimpulan =
          (forms.get('kesimpulan_status_validasi') == 'Terima') ? 1 : 0;

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
        statusAcc.add((form.get('status_acc') == 'Acc') ? 1 : 0);
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
          .getValidasiLogistik(payload, data!.noHide!)
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
