part of 'api.dart';

class PtjDepBsdApi extends Fetchly {
  Future<Response> getDataBelumVal([Map<String, dynamic>? query]) async =>
      get('bsd/ptj/belum-validasi', query);
  Future<Response> getDataSudahVal([Map<String, dynamic>? query]) async =>
      get('bsd/ptj/sudah-validasi', query);

  Future<Response> getDataNoHide(String nohide) async => get('bsd/ptj/$nohide');
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteData(int id) async => delete('path/$id');
}
