import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';

class LaporanPoPpnController extends GetxController with Apis {
  RxInt tab = 0.obs;

  final forms = LzForm.make([
    'filter_berdasarkan',
    'tanggal',
    'bulan_tahun',
    'kode_proyek',
    'suplier',
    'tahun',
  ]);

  final filter = [
    {'name': 'tanggal'},
    {'name': 'bulan tahun'},
    {'name': 'Kode Proyek'},
    {'name': 'Suplier'},
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
      final key = selectedFilter.value;
      final query = <String, dynamic>{};

      if (key == 'tanggal') {
        query['tanggal'] = forms.get('tanggal');
      } else if (key == 'bulan tahun') {
        query['bulan_tahun'] = forms.get('bulan_tahun');
      } else if (key == 'Kode Proyek') {
        query['kode_proyek'] = forms.get('kode_proyek');
      } else if (key == 'Suplier') {
        query['suplier'] = forms.extra('suplier');
        query['tahun'] = forms.get('tahun');
      }

      if (query.isEmpty) {
        Toast.warning('Silakan isi filter terlebih dahulu');
        return;
      }
      logg('== [DEBUG] Mengirim query filter ==');
      logg('Filter berdasarkan: $key');
      logg('Isi form suplier: ${forms.get('suplier')}');
      logg('Isi form tahun: ${forms.get('tahun')}');
      logg('Query akhir: $query');

      final res = await api.poPpn.getDataFilter(query);
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
        final res = await api.listPoPpn.getData(query).ui.loading();
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
