part of 'api.dart';

class RabValidasiApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('hrd/rab/sudah-validasi', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('hrd/rab/sudah-validasi', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('hrd/rab/sudah-validasi/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('hrd/rab/sudah-validasi/$id');
}
