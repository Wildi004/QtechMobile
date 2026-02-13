part of 'api.dart';

class ValidasiAlatApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/validasi/alat/sudah-validasi', query);
  Future<Response> getBelumVal([Map<String, dynamic>? query]) async =>
      get('logistik/validasi/alat/belum-validasi', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteData(int id) async => delete('path/$id');
}
