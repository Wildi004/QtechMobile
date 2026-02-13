part of 'api.dart';

class KasbonDepBsdApi extends Fetchly {
  Future<Response> getDataBelumVal([Map<String, dynamic>? query]) async =>
      get('bsd/pengajuan/kasbon/belum-validasi', query);

  Future<Response> getDataSudahVal([Map<String, dynamic>? query]) async =>
      get('bsd/pengajuan/kasbon/sudah-validasi', query);

  Future<Response> getDataNoHide(String nohide) async =>
      get('bsd/pengajuan/kasbon/$nohide');
  Future<Response> createData() async => post('bsd/pengajuan/kasbon');
  Future<Response> updateData(Map<String, dynamic> data, String nohide) async =>
      patch('bsd/pengajuan/kasbon/$nohide', data);
  Future<Response> deleteData(int id) async =>
      delete('bsd/pengajuan/kasbon/$id');
}
