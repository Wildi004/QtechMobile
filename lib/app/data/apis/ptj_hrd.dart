part of 'api.dart';

class PtjHrdApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('hrd/ptj/sudah-validasi', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('hrd/ptj/sudah-validasi', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('hrd/ptj/sudah-validasi/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('hrd/ptj/sudah-validasi/$id');

  Future<Response> getDataBelum([Map<String, dynamic>? query]) async =>
      get('hrd/ptj/belum-validasi', query);

  Future<Response> getDataByNoHide(String nohide) async =>
      get('hrd/ptj/$nohide');
}
