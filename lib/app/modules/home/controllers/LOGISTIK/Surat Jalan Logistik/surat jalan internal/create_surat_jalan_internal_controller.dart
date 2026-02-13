import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';

class CreateSuratJalanInternalController extends GetxController with Apis {
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'no_bukti',
    'tgl',
    'no_pengajuan',
    'tujuan',
    'kode_proyek',
    'nama_proyek',
    'keterangan',
    'ditujukan',
  ]);

  @override
  void onInit() {
    super.onInit();

    isLoading.value = false;
  }

  RxList<FormManager> formDetail = <FormManager>[].obs;

  List<Map<String, dynamic>> pemb = [];
  List<Map<String, dynamic>> sat = [];

  Future openMaterial() async {
    final query = {'limit': 'all'};
    try {
      if (pemb.isEmpty) {
        final res = await api.pengajuanMaterial.getData(query).ui.loading();
        pemb = List<Map<String, dynamic>>.from(res.data ?? []);
        logg('[pembelian] jumlah data pembelian: ${pemb.length}');
      }

      forms.set('no_pengajuan', '').options(
            pemb
                .where((e) => e['no_pengajuan'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['no_pengajuan'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void onSelectPemb(String id) {
    logg('[onSelectPemb] id terpilih: $id');
    final selected = pemb.firstWhere(
      (e) => e['id'].toString() == id,
      orElse: () => <String, dynamic>{},
    );

    if (selected.isEmpty) {
      logg('[onSelectPemb] PO tidak ditemukan');
      return;
    }

    final details = List<Map<String, dynamic>>.from(selected['detail'] ?? []);
    logg('[onSelectPemb] Jumlah detail PO: ${details.length}');
    logg('[onSelectPemb] Data detail: $details');

    formDetail.clear();
    for (var d in details) {
      final form = LzForm.make([
        'item_id',
        'nama_barang',
        'jumlah_keluar',
        'berat_satuan',
        'qty',
        'total',
        'kode_material'
      ]);

      form.set('item_id', d['id']?.toString() ?? '');
      form.set('nama_barang', d['nama_barang'] ?? '');
      form.set('qty', d['qty']?.toString() ?? '0');
      form.set('jumlah_keluar', d['jumlah_keluar']?.toString() ?? '0');
      form.set('berat_satuan', d['berat_satuan']?.toString() ?? '0');
      form.set('kode_material', d['kode_material'] ?? '');
      formDetail.add(form);
    }

    logg('[ON_SELECT_PO] formDetail count: ${formDetail.length}');
  }
}
