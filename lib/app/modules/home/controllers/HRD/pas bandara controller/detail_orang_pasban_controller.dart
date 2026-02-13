import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/pas_bandara_hrd/detail_orang.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';

class DetailOrangPasbanController extends GetxController {
  final forms = LzForm.make([
    'nama',
    'ktp',
    'status',
    'ttl',
    'agama',
    'alamat',
    'no_telp',
    'nama_bpk',
    'nama_ibu',
    'alamat_bpk',
    'nama_pasangan',
    'alamat_pasangan',
    'no_telp_pasangan',
    'nama_sd',
    'tahun_sd',
    'nama_smp',
    'tahun_smp',
    'nama_sma',
    'tahun_sma',
    'nama_univ1',
    'tahun_s1',
    'nama_univ2',
    'tahun_s2',
    'komentar',
    'foto_diri',
    'foto_ktp',
    'foto_kk',
    'foto_skck',
  ]);
  String? token;

  void setToken() {
    token = storage.read('token');
  }

  void fillForm(DetailOrang orang) {
    forms.fill({
      'nama': orang.nama ?? '',
      'ktp': orang.ktp ?? '',
      'status': orang.status ?? '',
      'ttl': orang.ttl ?? '',
      'agama': orang.agama ?? '',
      'alamat': orang.alamat ?? '',
      'no_telp': orang.noTelp ?? '',
      'nama_bpk': orang.namaBpk ?? '',
      'nama_ibu': orang.namaIbu ?? '',
      'alamat_bpk': orang.alamatBpk ?? '',
      'nama_pasangan': orang.namaPasangan ?? '',
      'alamat_pasangan': orang.alamatPasangan ?? '',
      'no_telp_pasangan': orang.noTelpPasangan ?? '',
      'nama_sd': orang.namaSd ?? '',
      'tahun_sd': orang.tahunSd ?? '',
      'nama_smp': orang.namaSmp ?? '',
      'tahun_smp': orang.tahunSmp ?? '',
      'nama_sma': orang.namaSma ?? '',
      'tahun_sma': orang.tahunSma ?? '',
      'nama_univ1': orang.namaUniv1 ?? '',
      'tahun_s1': orang.tahunS1 ?? '',
      'nama_univ2': orang.namaUniv2 ?? '',
      'tahun_s2': orang.tahunS2 ?? '',
      'komentar': orang.komentar ?? '',
    });
  }
}
