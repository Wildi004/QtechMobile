import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';

class LaporanPoProyekController extends GetxController with Apis {
  RxInt tab = 0.obs;

  final forms = LzForm.make([
    'filter_berdasarkan',
    'kode_proyek',
  ]);

  final filter = [
    {'name': 'Kode Proyek'},
  ];

  RxString selectedFilter = ''.obs;
  RxList<Map<String, dynamic>> deliveryData = <Map<String, dynamic>>[].obs;

  Future<List<Map>> getFilter() async => filter;

  void onChangeFilter(String? val) {
    selectedFilter.value = val ?? '';
    deliveryData.clear();
  }

  Future<void> fetchDeliveries() async {
    try {
      final kodeProyek = forms.get('kode_proyek');
      if (kodeProyek == null || kodeProyek.isEmpty) {
        Toast.warning('Silakan pilih kode proyek terlebih dahulu');
        return;
      }

      final query = {'kode_proyek': kodeProyek};

      logg('== [DEBUG] Mengirim query filter ==');
      logg('Kode Proyek: $kodeProyek');

      final res = await api.poPpnProyek.getDataFilter(query);
      final body = res.body ?? {};

      if (body['status'] == true && body['data'] != null) {
        deliveryData.assignAll(List<Map<String, dynamic>>.from(body['data']));
      } else {
        deliveryData.clear();
        Toast.warning('Tidak ada data Delivery PO PPN yang ditemukan');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  List<Map<String, dynamic>> po = [];

  Future openPo() async {
    final query = {'limit': 'all'};
    try {
      if (po.isEmpty) {
        final res = await api.listKpPo.getData(query).ui.loading();
        po = List<Map<String, dynamic>>.from(res.data ?? []);
        logg('[OPEN_PO] jumlah data PO: ${po.length}');
      }

      forms.set('kode_proyek', '').options(
            po
                .map((e) => {
                      'label': e['kode_proyek'].toString(),
                      'value': e['kode_proyek'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  List<Map<String, dynamic>> sup = [];

  Future openSup() async {
    final query = {'limit': 'all'};
    try {
      if (sup.isEmpty) {
        final res = await api.supplier.getData(query).ui.loading();
        sup = List<Map<String, dynamic>>.from(res.data ?? []);
        logg('[OPEN_SUP] jumlah data Sup: ${sup.length}');
      }

      forms.set('suplier', '').options(
            sup
                .map((e) => {
                      'label': e['nama_perusahaan'].toString(),
                      'value': e['id'],
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
