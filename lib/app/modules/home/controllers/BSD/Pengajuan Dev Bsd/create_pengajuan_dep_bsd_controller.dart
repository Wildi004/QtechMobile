import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/pengajuan_dep_bsd/pengajuan_dep_bsd.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/pengajuan%20dep%20bsd/info_no_pengajuan_view.dart';

class CreatePengajuanDepBsdController extends GetxController with Apis {
  PengajuanDepBsd? created;
  RxBool isLoading = true.obs;
  RxBool isSubmitted = false.obs;
  RxString selectedDep = ''.obs;
  Map<String, dynamic>? selectedPengajuan;

  final forms = LzForm.make([
    'no_pengajuan_reg',
    'tgl_pengajuan',
    'dep_name',
    'regional_name',
    'dep',
    'dep_field',

    //
    'no_pengajuan_dep',
    'total_harga',
    'qty',
    'harga',
    'total',
  ]);
  RxList<FormManager> formItems = RxList([]);
  RxList<bool> itemExpanded = <bool>[].obs;

  void addItem() {
    final form = LzForm.make([
      'dep',
      'dep_field',
      'no_pengajuan_dep',
      'total_harga',
      'no_hide',
    ]);

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
  RxList<String> types = RxList([]);
  RxInt grandTotal = 0.obs;
  List<PengajuanDepBsd> dataPengajuan = [];
  @override
  void onInit() {
    createPengajuan();
    super.onInit();
  }

  Future<void> createPengajuan() async {
    try {
      isLoading.value = true;
      final res = await api.pengajuanGlobal.createPengajuanBsd();
      forms.fill(res.data ?? {});
      created = PengajuanDepBsd.fromJson(res.data ?? {});
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void openDetailPengajuan() {
    final selected = selectedPengajuan;
    if (selected == null || selected.isEmpty) {
      Toast.warning("Detail pengajuan belum dipilih");
      return;
    }

    final detailForm = LzForm.make(['no_pengajuan', 'tgl_pengajuan']);
    detailForm.set('no_pengajuan', selected['no_pengajuan'] ?? '-');
    detailForm.set('tgl_pengajuan', selected['tgl_pengajuan'] ?? '-');

    Get.to(() => InfoNoPengajuanView(
          forms: detailForm,
          detail: selected['detail'] ?? [],
        ));
  }

  Future<void> deletePengajuan(String noHide) async {
    try {
      await api.pengajuanGlobal.deleteDataBsd(noHide);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  final pDep = [
    {'name': 'Logistik'},
    {'name': 'IT'},
    {'name': 'HRD'},
    {'name': 'Legal'},
  ];

  Future<List<Map>> statusV() async {
    return pDep;
  }

  List<Map<String, dynamic>> dataP = [];
  RxList<FormManager> formDetail = <FormManager>[].obs;
  Future<void> openPengajuan(FormManager forms) async {
    final dep = forms.get('dep')?.toString() ?? '';
    if (dep.isEmpty) {
      Toast.warning('Pilih departemen dulu');
      return;
    }

    final data = await getDataByDepartemen(dep);

    if (data.isEmpty) {
      Toast.warning('Data pengajuan $dep masih kosong');
      return;
    }
    dataP = data;
    forms.set('no_pengajuan_dep').options(
          data
              .map((e) => {
                    'label': e['no_pengajuan'].toString(),
                    'value': e['no_pengajuan'].toString(),
                  })
              .toList(),
        );
  }

  Future<List<Map<String, dynamic>>> getDataByDepartemen(String dep) async {
    dynamic res;

    final query = {'limit': 'all'};

    if (dep == 'IT') {
      res =
          await api.pengajuanGlobal.getDataItSudahValidasi(query).ui.loading();
    } else if (dep == 'HRD') {
      res =
          await api.pengajuanGlobal.getDataHrdSudahValidasi(query).ui.loading();
    } else if (dep == 'Legal') {
      res = await api.pengajuanGlobal
          .getDataLegalSudahValidasi(query)
          .ui
          .loading();
    } else if (dep == 'Logistik') {
      res = await api.pengajuanGlobal
          .getDataLogistikSudahValidasi(query)
          .ui
          .loading();
    } else {
      return [];
    }
    return List<Map<String, dynamic>>.from(res.data ?? []);
  }

  void setSelectedPengajuan(
    FormManager forms,
    String id,
    int index,
  ) {
    final selected = dataP.firstWhere(
      (e) => e['no_pengajuan'].toString() == id,
      orElse: () => {},
    );

    if (selected.isEmpty) return;

    peng[index] = selected['no_hide'];

    logg("SET PENG[$index]: ${peng[index]}");

    final rawValue = num.tryParse(selected['sub_total'].toString()) ?? 0;

    forms.fill({
      'total_harga': formatRupiah(rawValue),
      'no_hide': selected['no_hide'] ?? '',
    });
  }

  List<String?> peng = [];

  void openSelecPeng(int index) {
    try {
      peng[index] = formItems[index].get('no_pengajuan_dep');
      logg("PENG[$index]: ${peng[index]}");
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

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
          formItems.map((f) => f.get('dep_field') ?? '').toList();
      final totalHargas = formItems
          .map((f) => parseRupiah(f.get('total_harga')?.toString() ?? '0'))
          .toList();

      final payload = {
        'tgl_pengajuan': tglPengajuan,
        'item_id': itemIds,
        'no_pengajuan_dep': peng,
        'nama_pengajuan': namaPengajuans,
        'total_harga': totalHargas,
      };

      final res = await api.pengajuanGlobal
          .updatePengajuanBsd(payload, created!.noHide!)
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

num parseRupiah(String value) {
  return num.tryParse(
          value.replaceAll('Rp', '').replaceAll(' ', '').replaceAll('.', '')) ??
      0;
}
