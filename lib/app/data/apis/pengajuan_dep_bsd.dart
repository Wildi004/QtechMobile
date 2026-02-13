part of 'api.dart';

class PengajuanDepBsdApi extends Fetchly {
  Future<Response> getDataSudahVal([Map<String, dynamic>? query]) async =>
      get('bsd/pengajuan/departemen/sudah-validasi', query);
  Future<Response> getDataBelumVal([Map<String, dynamic>? query]) async =>
      get('bsd/pengajuan/departemen/belum-validasi', query);

  Future<Response> getDataNoHide(String nohide) async =>
      get('bsd/pengajuan/departemen/$nohide');
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteData(int id) async => delete('path/$id');
}
