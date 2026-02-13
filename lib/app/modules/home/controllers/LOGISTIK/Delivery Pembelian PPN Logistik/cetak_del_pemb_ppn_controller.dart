import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';

class CetakDelPembPpnController extends GetxController with Apis {
  RxInt tab = 0.obs;

  final forms = LzForm.make([
    'filter_berdasarkan',
    'tanggal',
    'bulan-tahun',
  ]);

  final filter = [
    {'name': 'tanggal'},
    {'name': 'bulan-tahun'},
  ];

  RxString selectedFilter = ''.obs;
  RxList<Map<String, dynamic>> deliveryData = <Map<String, dynamic>>[].obs;

  Future<List<Map>> getFilter() async => filter;

  void onChangeFilter(String? val) {
    selectedFilter.value = val ?? '';
    deliveryData.clear();
  }

  /// 🔹 Ambil data sesuai filter yang dipilih
  Future<void> fetchDeliveries() async {
    try {
      final key = selectedFilter.value;
      final query = <String, dynamic>{};

      // Tentukan parameter query berdasarkan filter yang dipilih
      if (key == 'tanggal') {
        query['tanggal'] = forms.get('tanggal');
      } else if (key == 'bulan-tahun') {
        query['bulan-tahun'] = forms.get('bulan-tahun');
      }

      if (query.isEmpty) {
        Toast.warning('Silakan isi filter terlebih dahulu');
        return;
      }

      final res = await api.delPembPpn.getDataFilter(query);
      final body = res.body ?? {};

      if (body['status'] == true && body['data'] != null) {
        deliveryData.assignAll(List<Map<String, dynamic>>.from(body['data']));
      } else {
        deliveryData.clear();
        Toast.warning('Tidak ada data Delivery Pembelian PPN yang ditemukan');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
