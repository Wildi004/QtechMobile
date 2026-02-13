import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20it/ptj_it/detail_ptj.dart';
import 'package:qrm_dev/app/data/models/models%20it/ptj_it/ptj_it.dart';

class FormValidasiPtjRndController extends GetxController with Apis {
  PtjIt? data;
  RxBool isLoading = true.obs;

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

  Future getDetails(PtjIt data) async {
    try {
      isLoading.value = true;
      String nohide = data.noHide ?? '';

      final res = await api.ptjGlobal.getDataByNoHidePtjRnd(nohide);

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

    forms.fill({
      'no_ptj': newData.noPtj ?? '',
      'dep_name': newData.depName ?? '',
      'tgl_ptj': newData.tglPtj ?? '',
      'created_name': newData.createdName ?? '',
      'total': newData.total ?? '',
    });

    getDetails(newData);
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

      final item = cards[0];
      final form = formDetails[0];

      final itemId = item.id ?? 0;
      final statusAcc = (form.get('status_acc') == 'Acc') ? 1 : 0;
      final komentar = (form.get('komentar') ?? '').toString();

      final payload = {
        'kesimpulan_status_validasi': kesimpulan,
        'item_id': itemId, // int
        'status_acc': statusAcc, // int
        'komentar': komentar, // string
      };

      logg(payload);

      final res = await api.ptjGlobal
          .validasiRnd(payload, data!.noHide!)
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
