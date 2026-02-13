import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';

class CetakPembelianPpnController extends GetxController with Apis {
  RxInt tab = 0.obs;

  final forms = LzForm.make([
    'filter_berdasarkan',
    'tanggal',
    'bulan_tahun',
  ]);

  final filter = [
    {'name': 'tanggal'},
    {'name': 'bulan tahun'},
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
      } else if (key == 'bulan tahun' || key == 'bulan-tahun') {
        query['bulan_tahun'] = forms.get('bulan_tahun');
      }

      if (query.isEmpty) {
        Toast.warning('Silakan isi filter terlebih dahulu');
        return;
      }

      final res = await api.pembPpn.getDataFilter(query);
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
}
