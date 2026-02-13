import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/po_ppn/detail.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/po_ppn/po_ppn.dart';

class FormValidasiPoPpnController extends GetxController with Apis {
  PoPpn? data;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    //head
    'total',

    'no_po',
    'tgl_po',
    'delivery_date',
    'cara_pembayaran',
    'term_from',
    'term_to',
    'lama_hari',
    'jenis_pembayaran',
    'shipment',
    'suplier_id',
    'lokasi_pengiriman',
    'sub_total',

    //detail
    'kesimpulan_status_validasi',
    'item_id',
    'nama_barang',
    'satuan_id',
    'unit_price',
    'qty',
    'diskon',
    'status_acc',
    'komentar',
  ]);

  final id = Get.parameters['id'];

  PoPpn details = PoPpn();
  RxList<FormManager> formDetails = RxList<FormManager>();
  RxList<DetailPpn> cards = RxList([]);

  Future getDetails(PoPpn data) async {
    try {
      isLoading.value = true;
      String nohide = data.noHide ?? '';

      final res = await api.poPpn.getDataNoHide(nohide);

      details = PoPpn.fromJson(res.data ?? {});
      cards.value = details.detail ?? [];

      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'nama_barang',
          'qty',
          'satuan_id',
          'unit_price',
          'diskon',
          'amount'
        ]);

        form.fill({
          'nama_barang': e.namaBarang ?? '',
          'qty': e.qty?.toString() ?? '0',
          'satuan_id': e.satuanName?.toString() ?? '',
          'unit_price': e.unitPrice?.toString() ?? '0',
          'diskon': e.diskon?.toString() ?? '0',
        });

        return form;
      }).toList();
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void setData(PoPpn newData) {
    data = newData;

    forms.fill({
      'no_po': newData.noPo ?? '',
      'tgl_po': newData.tglPo ?? '',
      'delivery_date': newData.deliveryDate ?? '',
      'cara_pembayaran': newData.caraPembayaran ?? '',
      'term_from': newData.termFrom ?? '',
      'term_to': newData.termTo ?? '',
      'lama_hari': newData.lamaHari ?? '',
      'jenis_pembayaran': newData.jenisPembayaran ?? '',
      'shipment': newData.shipment ?? '',
      'suplier_id': newData.suplierId ?? '',
      'lokasi_pengiriman': newData.lokasiPengiriman ?? '',
      'sub_total': newData.subTotal ?? '',
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

  Future<List<Map>> getFinal() async {
    return gfinal;
  }

  final gfinal = [
    {'id': 0, 'name': 'Tolak'},
    {'id': 1, 'name': 'Terima'},
  ];

  Future<void> onSubmit(String? noHide) async {
    try {
      if (data == null) {
        return Toast.show('Data pengajuan tidak ditemukan.');
      }

      final kesimpulan = forms.extra('kesimpulan_status_validasi');
      final item = cards[0];
      final form = formDetails[0];

      final payload = {
        'kesimpulan_status_validasi': kesimpulan,
        'item_id': [item.id ?? 0], // <-- HARUS ARRAY
        'nama_barang': [item.namaBarang ?? ''],
        'satuan_id': [item.satuanId ?? 0],
        'unit_price': [item.unitPrice ?? 0],
        'qty': [item.qty ?? 0],
        'diskon': [item.diskon ?? 0],
        'status_acc': [(form.get('status_acc') == 'Acc') ? 1 : 0],
        'komentar': [(form.get('komentar') ?? '').toString()],
      };

      logg('SUBMIT NOHIDE: $noHide');
      logg('PAYLOAD: $payload');

      final res = await api.poPpn
          .validasiPoPpn(payload, noHide!)
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
