part of 'api.dart';

class PengajuanHrdApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('hrd/pengajuan/departemen/sudah-validasi', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('hrd/pengajuan/departemen', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      patch('hrd/pengajuan/departemen/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('hrd/pengajuan/departemen/sudah-validasi/$id');

  Future<Response> getDataBelum([Map<String, dynamic>? query]) async =>
      get('hrd/pengajuan/departemen/belum-validasi', query);
}
