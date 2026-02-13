// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:lazyui/lazyui.dart';
// import 'package:qrm_dev/app/data/apis/api.dart';
// import 'package:qrm_dev/app/data/models/model%20logistik/po_ppn/detail.dart';
// import 'package:qrm_dev/app/data/models/model%20logistik/po_ppn/po_ppn.dart';
// import 'package:qrm_dev/app/data/models/model%20logistik/validasi_alat/validasi_alat.dart';

// class ValidasiAlatDetailController extends GetxController with Apis {
//   ValidasiAlat? data;

//   final isFilled = false.obs;
//   RxBool isLoading = true.obs;

//   final forms = LzForm.make([
//    'trans_kode',
//     'alat_id',
//     'from_date',
//     'to_date',
//     'lama_hari',
//     'status_pm',
//     'validasi_pm',
//     'pm',
//     'status_logistik',
//     'validasi_logistik',
//     'status_gm_regional',
//     'validasi_gm',
//     'no_pengajuan',
//     'tgl_pengajuan',
//     'kode_proyek',
//     'uraian_pekerjaan',
//     'spv',
//     'detail_proyek_item',
//     'alat',
//     'kode_alat',

//     //alat
//     'type',
//     'nama_alat',
//     'jumlah',
//     'harga_satuan',
//     'harga_perolehan',
//     'status',
//     'keterangan',
//     'tgl_beli',
//     'reg_id',
//     'dep_id',
//     'proyek_item_id',
//     'kantor',
//     'image',
//     'pm',
//     'created_at',
//     'qr_code',
//     'tgl_service',
//     'regional_name',
//     'departemen_name',
//     'proyek_name',
//     'created_by_name',
//     'pm_name',
//   ]);

//   final id = Get.parameters['id'];
//   final formatRp =
//       NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
//   ValidasiAlat details = ValidasiAlat();
//   RxList<DetailPpn> cards = RxList([]);
//   RxList<FormManager> formDetails = RxList<FormManager>();
//   Future getDetails(ValidasiAlat data) async {
//     try {
//       String nohide = data.noHide ?? '';
//       logg('[DEBUG] Fetch detail dengan noHide: $nohide');

//       final res = await api.poPpn.getDataNoHide(nohide);
//       details = PoPpn.fromJson(res.data ?? {});
//       cards.value = details.detail ?? [];

//       formDetails.value = cards.map((e) {
//         final form = LzForm.make([
//           'nama_barang',
//           'qty',
//           'satuan_name',
//           'unit_price',
//           'diskon',
//           'amount',
//         ]);

//         final hargaVal = num.tryParse(e.unitPrice.toString()) ?? 0;
//         final totalHargaVal = num.tryParse(e.amount.toString()) ?? 0;

//         form.fill({
//           'nama_barang': e.namaBarang ?? '-',
//           'qty': e.qty?.toString() ?? '-',
//           'satuan_name': e.satuanName ?? '',
//           'unit_price': formatRp.format(hargaVal),
//           'diskon': e.diskon?.toString() ?? '',
//           'amount': formatRp.format(totalHargaVal),
//         });

//         return form;
//       }).toList();
//     } catch (e, s) {
//       Errors.check(e, s);
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   @override
//   void onReady() {
//     super.onReady();
//     if (data != null) {
//       forms.fill(data!.toJson());
//       getDetails(data!); // 🚀 otomatis fetch detail
//     }
//   }
// }
