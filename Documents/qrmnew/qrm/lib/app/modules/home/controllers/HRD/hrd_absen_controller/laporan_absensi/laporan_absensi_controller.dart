import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';

class LaporanAbsensiController extends GetxController {
  RxInt tab = 0.obs;

  late final forms = LzForm.make([
    'name',
    'phone',
    'birthdate',
    'password',
    'gender',
    'hobby',
    'ticket',
    'province',
    'city',
    'height',
    'terms',
  ]);

  final cities = [
    {'id': 1, 'province_id': 1, 'name': 'Per tanggal absensi'},
    {'id': 2, 'province_id': 1, 'name': 'Per bulan absensi'},
    {'id': 3, 'province_id': 1, 'name': 'Per karyawan dan bulan / tanggal'},
  ];
  final reg = [
    {'id': 1, 'province_id': 1, 'name': 'Regional Barat'},
    {'id': 2, 'province_id': 1, 'name': 'Regional Timur'},
    {'id': 3, 'province_id': 1, 'name': 'Regional Tengah'},
    {'id': 4, 'province_id': 1, 'name': 'Regional Pusat'},
  ];

  final karyawan = [
    {
      'id': 1,
      'province_id': 1,
      'name': "Hendi Hardiansyah",
    },
    {
      'id': 2,
      'province_id': 1,
      'name': "Yusuf Ali",
    },
    {
      'id': 3,
      'province_id': 1,
      'name': "Eltaf Husein, S.T",
    },
    {
      'id': 4,
      'province_id': 1,
      'name': "Ismed Andrian, S.T",
    },
    {
      'id': 5,
      'province_id': 1,
      'name': "Erna Zuni Fatmawati",
    },
    {
      'id': 6,
      'province_id': 1,
      'name': "Rima Silvia, S. Ak",
    },
    {
      'id': 7,
      'province_id': 1,
      'name': "Ir. Gusti Ayu Sukma Dwi Naindia Sari, S.T, M.T",
    },
    {
      'id': 8,
      'province_id': 1,
      'name': "I Nyoman Alit Suarsa, S.Ars.",
    },
    {
      'id': 9,
      'province_id': 1,
      'name': "Putu Meliana Dewi",
    },
  ];

  Future<List<Map>> getCities() async {
    await Future.delayed(const Duration(seconds: 1));
    return cities;
  }

  Future<List<Map>> getreg() async {
    await Future.delayed(const Duration(seconds: 1));
    return reg;
  }

  Future<List<Map>> getkar() async {
    await Future.delayed(const Duration(seconds: 1));
    return karyawan;
  }

  RxString selectedFilter = ''.obs;

  List<String> filters = [
    'Per Tanggal Absensi',
    'Per Bulan Absensi',
    'Per Karyawan & Bulan / Tanggal',
  ];
}
