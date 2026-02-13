// import 'dart:io';

// import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:lazyui/lazyui.dart';
// import 'package:qrm_dev/app/core/utils/extensions.dart';
//  import 'package:qrm_dev/app/data/models/models%20hrd/pengajuan_detail.dart';
// import 'package:qrm_dev/app/data/models/models%20hrd/ptj_hrd/detail_ptj.dart';
// import 'package:qrm_dev/app/data/models/models%20hrd/ptj_hrd/ptj_hrd.dart';
// import 'package:qrm_dev/app/data/models/pengajuan%20global/pengajuan%20sudah%20validasi/pengajuan_sudah_validasi/pengajuan_sudah_validasi.dart';

// import '../../../../../data/apis/api.dart';
// import 'package:get/get.dart';

// import '../../../../../data/models/saldo_ptj.dart';

// class EditPtjHrdController extends GetxController with Apis {
//   PtjHrd? data;
//   final isFilled = false.obs;
//   RxBool isLoading = true.obs;

//   final forms = LzForm.make([
//     'id',
//     'no_ptj',
//     'tgl_ptj',
//     'total',
//     'status_dir_keuangan',
//     'status_gm_bsd',
//     'created_at',
//     'no_hide',
//     'type',
//     'created_name',
//     'approved_name',
//     'saldo',
//     'approval_name',
//     'dep_name',
//     'id',
//     'no_ptj',
//     'tgl_beli',
//     'nama_barang',
//     'qty',
//     'harga_satuan',
//     'total_harga',
//     'image',
//     'status_acc',
//     'status_acc_dir',
//     'status_acc_dirut',
//     'komentar_dirut',
//     'komentar',
//     'komentar_dir',
//     'created_at',
//     'no_hide',
//     'adendum',
//     'proyek_item_name',
//     'detail_pengajuan_name',
//     'akun_name',
//     'perkiraan_name',
//   ]);

//   RxList<FormManager> formPtj = RxList([]);

//   final id = Get.parameters['id'];

//   PtjHrd details = PtjHrd();
//   RxList<DetailPtj> cards = RxList([]);

//   RxList<FormManager> formDetails = RxList<FormManager>();

//   Future getDetails(PtjHrd data) async {
//     try {
//       String nohide = data.noHide ?? '';
//       final res = await api.ptjGlobal.getDataByNoHidePtjHrd(nohide);
//       details = PtjHrd.fromJson(res.data ?? {});
//       cards.value = details.detailPtj ?? [];

//       final formatRp =
//           NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

//       formDetails.value = cards.map((e) {
//         final form = LzForm.make([
//           'item_id',
//           'nama_barang',
//           'tgl_beli',
//           'image',
//           'qty',
//           'harga_satuan',
//           'total_harga',
//         ]);

//         final hargaSatuanVal = int.tryParse(e.hargaSatuan ?? '') ?? 0;
//         final totalHargaVal = int.tryParse(e.totalHarga ?? '') ?? 0;

//         form.fill({
//           'item_id': e.id,
//           'nama_barang': e.namaBarang ?? '-',
//           'tgl_beli': e.tglBeli ?? '-',
//           'image': e.image ?? '-',
//           'qty': e.qty ?? '',
//           'harga_satuan': formatRp.format(hargaSatuanVal),
//           'total_harga': formatRp.format(totalHargaVal),
//         });

//         return form;
//       }).toList();
//     } catch (e, s) {
//       Errors.check(e, s);
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> getSaldo() async {
//     try {
//       final res = await api.saldoPtj.getData();
//       logg(res.data);

//       if (res.data is Map<String, dynamic>) {
//         final saldo = SaldoPtj.fromJson(res.data);
//         final saldoValue =
//             saldo.saldoAkhirFormat ?? saldo.saldoAkhir?.toString() ?? '0';
//         forms.set('saldo', saldoValue);
//       } else {
//         forms.set('saldo', '0');
//         logg(res.data);
//       }
//     } catch (e, s) {
//       Errors.check(e, s);
//     }
//   }

//   List<PengajuanSudahValidasi> dataPengajuan = [];
//   List<PengajuanDetail> dataPengajuanDetails = [];
//   List<DetailPtj> dataPtj = [];

//   RxList<FormManager> formPengajuan = RxList([]);
//   RxList<String> types = RxList([]);

//   RxInt grandTotal = 0.obs;

//   RxString fileName = ''.obs;
//   XFile? fileImage;
//   File? file;
//   DetailPtj? created;

//   void addPengajuan() {
//     // if (formDetails.length >= 1) {
//     //   Toast.show('Hanya boleh 1 data');
//     //   return;
//     // }

//     final form = LzForm.make([
//       'tgl_ptj',
//       'item_id',
//       'proyek_item_id',
//       'tgl_beli',
//       'detail_pengajuan_id',
//       'nama_barang',
//       'qty',
//       'harga_satuan',
//       'image',
//       'total_harga'
//     ]);

//     formDetails.insert(0, form);
//   }

//   void setUnit(String value, int index) {
//     if (index >= formDetails.length) return;

//     final item = dataPengajuanDetails.firstWhere(
//       (e) => e.namaBarang == value,
//       orElse: () => PengajuanDetail(),
//     );

//     formDetails[index].set(
//       'harga_satuan',
//       (item.totalHarga ?? 0).currency(separator: ',', prefix: ''),
//     );

//     countTotal(index);
//   }

//   void countTotal(int index) {
//     if (index >= formDetails.length) return;

//     int unit = (formDetails[index].get('harga_satuan') ?? '').numeric;
//     int qty = (formDetails[index].get('qty') ?? '').numeric;

//     int total = unit * qty;
//     formDetails[index].set(
//       'total_harga',
//       total.currency(separator: ',', prefix: ''),
//     );

//     grandTotal.value = formDetails
//         .map((e) => (e.get('total_harga') ?? '0').numeric)
//         .fold(0, (a, b) => a + b);
//   }

//   Future<void> getPengajuanDetails() async {
//     if (dataPengajuanDetails.isEmpty) {
//       final res = await api.pengajuanGlobal.getDataHrdDetail().ui.loading();
//       dataPengajuanDetails = PengajuanDetail.fromJsonList(res.data);
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();

//     if (data != null) {
//       forms.fill(data!.toJson());
//     }

//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await getPengajuanDetails();
//       await getSaldo();
//       if (data != null) {
//         await getDetails(data!);
//       }
//     });
//   }

//   void removePtj(int index) {
//     if (index < 0 || index >= formDetails.length) return;

//     formDetails.removeAt(index);

//     if (formDetails.isEmpty) {
//       grandTotal.value = 0;
//     } else {
//       grandTotal.value = formDetails
//           .map((e) => (e.get('total') ?? '0').numeric)
//           .fold(0, (a, b) => a + b);
//     }
//   }

//   Future<void> onSubmit() async {
//     try {
//       if (fileImage == null) {
//         return Toast.show('File image dan ttd harus diisi');
//       }

//       final namaBarangs =
//           formDetails.map((e) => e.get('nama_barang') ?? '').toList();

//       final itemIds = formPengajuan
//           .map((form) {
//             final id = form.get('item_id');
//             return id is int ? id : int.tryParse('$id');
//           })
//           .whereType<int>()
//           .toList();

//       final tgls = formDetails.map((e) => e.get('tgl_beli') ?? '').toList();
//       final qtys =
//           formDetails.map((e) => (e.get('qty') ?? '0').numeric).toList();
//       final hargas = formDetails
//           .map((e) => (e.get('harga_satuan') ?? '0').numeric)
//           .toList();

//       final pengajuanDetailIds = formDetails.map((form) {
//         final namaItem = form.get('nama_barang');
//         final matched = dataPengajuanDetails.firstWhere(
//           (d) => d.namaBarang == namaItem,
//           orElse: () => PengajuanDetail(),
//         );
//         return matched.id ?? 0;
//       }).toList();

//       final payload = {
//         '_method': 'patch',
//         'item_id[]': itemIds,
//         'nama_barang[]': namaBarangs,
//         'tgl_beli[]': tgls,
//         'qty[]': qtys,
//         'harga_satuan[]': hargas,
//         'pengajuan_detail_id[]': pengajuanDetailIds,
//         'image[]': await Future.wait(
//           List.generate(namaBarangs.length, (_) async {
//             return await api.toFile(fileImage!.path);
//           }),
//         ),
//       };

//       final res = await api.ptjGlobal
//           .updateDataPtjHrd(payload, details.noHide!)
//           .ui
//           .loading('Memproses...');

//       if (res.status) {
//         Get.back(result: res.data);
//         Get.snackbar('Berhail', res.message ?? '');
//         await getDetails(details);
//       }
//     } catch (e, s) {
//       Errors.check(e, s);
//     }
//   }
// }
