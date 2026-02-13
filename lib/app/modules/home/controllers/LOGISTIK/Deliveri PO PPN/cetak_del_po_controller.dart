import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';

class CetakDelPoController extends GetxController with Apis {
  RxInt tab = 0.obs;

  final forms = LzForm.make([
    'filter_berdasarkan',
    'tanggal',
    'bulan-tahun',
    'kode_proyek',
  ]);

  final filter = [
    {'name': 'tanggal'},
    {'name': 'bulan-tahun'},
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
      final key = selectedFilter.value;
      final query = <String, dynamic>{};

      if (key == 'tanggal') {
        query['tanggal'] = forms.get('tanggal');
      } else if (key == 'bulan-tahun') {
        query['bulan-tahun'] = forms.get('bulan-tahun');
      } else if (key == 'Kode Proyek') {
        query['kode_proyek'] = forms.get('kode_proyek');
      }

      if (query.isEmpty) {
        Toast.warning('Silakan isi filter terlebih dahulu');
        return;
      }

      final res = await api.delPoPpn.getDataFilter(query);
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
        final res = await api.listDelpoPpn.getData(query).ui.loading();
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
}
