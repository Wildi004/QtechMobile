import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20it/ptj_it/detail_ptj.dart';
import 'package:qrm_dev/app/data/models/models%20it/ptj_it/ptj_it.dart';

class FormValidasiPtjItController extends GetxController with Apis {
  PtjIt? data;
  final isFilled = false.obs;
  RxBool isLoading = true.obs;
  RxInt originalTotal = 0.obs; //   total awal

  final forms = LzForm.make([
    //field head
    'tgl_ptj',
    'total',
    'status_dir_keuangan',
    'status_gm_bsd',
    'type',
    'created_name',
    'saldo',
    'dep_name',
    'no_ptj',
    'tgl_beli',
    'harga_satuan',
    'total_harga',
    'image',
    'status_acc_dir',
    'status_acc_dirut',
    'komentar_dirut',
    'komentar_dir',
    'created_at',
    'no_hide',
    'adendum',
    'proyek_item_name',
    'detail_pengajuan_name',
    'akun_name',

    // List
    'kesimpulan_status_validasi',
    'nama_barang',
    "harga",
    "qty",
    "status_acc",
    "komentar",
    'sub_total'
  ]);

  final id = Get.parameters['id'];

  PtjIt details = PtjIt();
  RxList<DetailPtjIt> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();

  // Future getItems() async {
  //   final res = await api.rabGlobal.getDataHrd();
  //   dataRabDetails = RabDetailIt.fromJsonList(res.data);
  // }

  Future getDetails(PtjIt data) async {
    try {
      isLoading.value = true;
      String nohide = data.noHide ?? '';

      final res = await api.ptjGlobal.getDataByNoHidePtjIt(nohide);

      details = PtjIt.fromJson(res.data ?? {});
      cards.value = details.detailPtjIt ?? [];

      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'nama_barang',
          'tgl_beli',
          'harga',
          'qty',
          'komentar',
          'status_acc',
        ]);

        form.fill({
          'nama_barang': e.namaBarang ?? '',
          'tgl_beli': e.tglBeli ?? '',
          'harga': e.hargaSatuan?.toString() ?? '',
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

  void setData(PtjIt newData) {
    data = newData;

    originalTotal.value = int.tryParse(newData.total.toString()) ?? 0;

    forms.fill({
      'no_ptj': newData.noPtj ?? '',
      'dep_name': newData.depName ?? '',
      'tgl_ptj': newData.tglPtj ?? '',
      'created_name': newData.createdName ?? '',
      'total': newData.total ?? '',
    });

    getDetails(newData);
  }

  void onStatusAccChanged(String value) {
    if (value == 'Tolak') {
      forms.set('total', '0');
    } else if (value == 'Acc') {
      forms.set('total', originalTotal.value.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();

    if (data != null) {
      forms.fill(data!.toJson());
      getDetails(data!);
      setData(data!);
    }
  }

  RxList<FormManager> formRabs = RxList([]);
  RxList<String> types = RxList([]);
  DetailPtjIt? created;
  List<DetailPtjIt> dataPengajuan = [];
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

      // KESIMPULAN
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

      // ITEM
      final item = cards.first;
      final form = formDetails.first;

      // STATUS ACC
      final statusAccValue = form.get('status_acc')?.toString() ?? '';

      int statusAcc;
      switch (statusAccValue) {
        case 'Terima':
          statusAcc = 1;
          break;
        case 'Tolak':
          statusAcc = 2;
          break;
        default:
          return Toast.warning('Pilih status ACC item');
      }

      final payload = {
        'kesimpulan_status_validasi': kesimpulan,
        'item_id': item.id,
        'status_acc': statusAcc,
        'komentar': (form.get('komentar') ?? '').toString(),
      };

      logg(payload);

      final res = await api.ptjGlobal
          .validasiIt(payload, data!.noHide!)
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
