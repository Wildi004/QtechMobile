import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/kasbon.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/kasbon_dep_bsd/kasbon_dep_bsd.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/saldo_all_dep.dart';

class CreateKasbonBsdController extends GetxController with Apis {
  KasbonDepBsd? created;
  RxBool isLoading = true.obs;
  Map<String, dynamic>? selectedPengajuan;
  RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[].obs;

  final forms = LzForm.make([
    'no_pengajuan_reg',
    'tgl_pengajuan',
    'dep_name',
    'saldo_akhir_bsd',
    'regional_name',
    'no_pengajuan_dep'
  ]);

  RxList<FormManager> formItems = RxList([]);
  RxList<bool> itemExpanded = <bool>[].obs;

  void addItem() {
    final form = LzForm.make([
      'nama_pengajuan',
      'total_harga',
      'no_pengajuan_dep',
      'no_pengajuan_dep_label',
    ]);

    // 👇 isi otomatis
    form.fill({
      'nama_pengajuan': 'Kasbon_Karyawan',
      'total_harga': formatRupiah(0),
    });

    formItems.insert(0, form);
    itemExpanded.insert(0, true);
    peng.insert(0, null);
  }

  String formatRupiah(num value) {
    return "Rp ${value.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => '.',
        )}";
  }

  void removeItem(int index) {
    formItems.removeAt(index);
    itemExpanded.removeAt(index);
    peng.removeAt(index);
  }

  RxList<FormManager> formRabs = RxList([]);

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await createPengajuan();
      ();
      await getPengajuanDetails();

      getSaldo();
    });
  }

  Future<void> getSaldo() async {
    try {
      final res = await api.saldoAllDep.getData();

      final saldo = SaldoAllDep.fromJson(res.data);
      forms.set(
        'saldo_akhir_bsd',
        formatRupiah(saldo.saldoAkhirBsd ?? 0),
      );
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  List<KasbonDepBsd> dataPengajuanDetails = [];
  List<Kasbon> dataKasbon = [];

  List<Map<String, dynamic>> po = [];

  Future<void> getPengajuanDetails() async {
    final query = {'limit': 'all'};

    if (dataKasbon.isEmpty) {
      final res = await api.kasbon.getDataSudahValidasi(query).ui.loading();
      dataKasbon = Kasbon.fromJsonList(res.data);
    }
  }

  void setUnitDelayed(int index) {
    Future.microtask(() {
      final label = formItems[index].get('no_pengajuan_dep');

      final item = dataKasbon.firstWhere(
        (e) => '${e.noPengajuan ?? '-'} - ${e.user ?? '-'}' == label,
        orElse: () => Kasbon(),
      );

      // 🔥 simpan no_hide, BUKAN label
      formItems[index].set('no_pengajuan_dep', item.noHide);

      // set total
      final jml = item.jml ?? 0;
      formItems[index].set(
        'total_harga',
        formatRupiah(jml),
      );

      logg('SEND no_hide: ${item.noHide}');
    });
  }

  void onKasbonChanged(int index, String? label) {
    final item = dataKasbon.firstWhere(
      (e) => '${e.noPengajuan ?? '-'} - ${e.user ?? '-'}' == label,
      orElse: () => Kasbon(),
    );

    // ✅ simpan LABEL (buat UI)
    formItems[index].set(
      'no_pengajuan_dep_label',
      label,
    );

    // ✅ simpan VALUE (buat backend)
    formItems[index].set(
      'no_pengajuan_dep',
      item.noHide,
    );

    final jml = item.jml ?? 0;

    formItems[index].set(
      'total_harga',
      formatRupiah(jml),
    );

    logg('LABEL: $label');
    logg('NO_HIDE: ${item.noHide}');
    logg('JML: $jml');
  }

  Future<void> createPengajuan() async {
    try {
      isLoading.value = true;
      final res = await api.kasbonDepBsd.createData();
      forms.fill(res.data ?? {});
      created = KasbonDepBsd.fromJson(res.data ?? {});
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  List<String?> peng = [];

  Future<void> onSubmit() async {
    try {
      final tglPengajuan = forms.get('tgl_pengajuan')?.toString() ?? '';

      final itemIds = formRabs
          .map((form) {
            final id = form.get('item_id');
            return id is int ? id : null;
          })
          .whereType<int>()
          .toList();

      final namaPengajuans =
          formItems.map((f) => f.get('nama_pengajuan') ?? '').toList();
      final totalHargas = formItems
          .map((f) => parseRupiah(f.get('total_harga')?.toString() ?? '0'))
          .toList();
      final namaPengajuanDep =
          formItems.map((f) => f.get('no_pengajuan_dep')).toList();

      final payload = {
        'tgl_pengajuan': tglPengajuan,
        'item_id': itemIds,
        'no_pengajuan_dep': namaPengajuanDep,
        'nama_pengajuan': namaPengajuans,
        'total_harga': totalHargas,
      };

      final res = await api.kasbonDepBsd
          .updateData(payload, created!.noHide!)
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

num parseRupiah(String value) {
  return num.tryParse(
          value.replaceAll('Rp', '').replaceAll(' ', '').replaceAll('.', '')) ??
      0;
}
//   Future openPengajuanKasbon() async {
//     final query = {'limit': 'all'};
//     try {
//       if (po.isEmpty) {
//         final res = await api.kasbon.getDataSudahValidasi(query).ui.loading();
//         po = List<Map<String, dynamic>>.from(res.data ?? []);
//         logg('[openPengajuanKasbon] jumlah data PO: ${po.length}');
//       }

//      final options = po
//     .where((e) => e['no_pengajuan'] != null)
//     .map((e) => {
//           'label': '${e['no_pengajuan']} — ${e['user'] ?? '-'}',
//           'value': e['no_pengajuan'], // STRING (AMAN)
//         })
//     .toList();

// for (final formItem in formItems) {
//   formItem
//       .key('no_pengajuan_dep') // 👈 FIELD-NYA
//       .options(options);       // 👈 BARU BENAR
// }

//       // 🔥 SET OPTIONS KE SEMUA ITEM FORM
//       for (final formItem in formItems) {
//         formItem.set('no_pengajuan_dep', '').options(options);
//       }
//     } catch (e, s) {
//       Errors.check(e, s);
//     }
//   }
