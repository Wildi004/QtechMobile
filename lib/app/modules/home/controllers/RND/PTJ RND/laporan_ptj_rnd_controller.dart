import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';

class LaporanPtjRndController extends GetxController with Apis {
  RxInt tab = 0.obs;

  final forms = LzForm.make([
    'filter_berdasarkan',
    'tanggal',
    'bulan-tahun',
    'type',
    'tanggal-type',
    'bulan-tahun-type'
  ]);

  final filter = [
    {'name': 'tanggal'},
    {'name': 'bulan-tahun'},
    {'name': 'type'},
    {'name': 'tanggal-type'},
    {'name': 'bulan-tahun-type'},
  ];

  final type = [
    {'name': 'Kantor'},
    {'name': 'Timur'},
    {'name': 'Barat'},
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
        final bulan = forms.get('bulan-tahun');
        if (bulan == null || bulan.isEmpty) {
          Toast.warning('Silakan pilih bulan dan tahun');
          return;
        }
        query['bulan_tahun'] = bulan;
      } else if (key == 'type') {
        final type = forms.get('type');
        if (type == null || type.isEmpty) {
          Toast.warning('Silakan pilih type terlebih dahulu');
          return;
        }
        query['type'] = type;
      } else if (key == 'tanggal-type') {
        final tanggal = forms.get('tanggal');
        final type = forms.get('type');

        if (tanggal == null ||
            tanggal.isEmpty ||
            type == null ||
            type.isEmpty) {
          Toast.warning('Silakan pilih tanggal dan type');
          return;
        }

        query['tanggal'] = tanggal;
        query['type'] = type;
      } else if (key == 'bulan-tahun-type') {
        final bulan = forms.get('bulan-tahun');
        final type = forms.get('type');

        if (bulan == null || bulan.isEmpty || type == null || type.isEmpty) {
          Toast.warning('Silakan pilih bulan dan type');
          return;
        }

        query['bulan-tahun'] = bulan;
        query['type'] = type;
      }

      if (query.isEmpty) {
        Toast.warning('Silakan isi filter terlebih dahulu');
        return;
      }

      final res = await api.ptjGlobal.getDataFilterRnd(query);
      final body = res.body ?? {};

      if (body['status'] == true && body['data'] != null) {
        deliveryData.assignAll(List<Map<String, dynamic>>.from(body['data']));
      } else {
        deliveryData.clear();
        Toast.warning('Tidak ada data PTJ yang ditemukan');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
