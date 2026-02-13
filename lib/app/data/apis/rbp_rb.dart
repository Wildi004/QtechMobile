part of 'api.dart';

class RbpRbApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/rbp/timur', query);

  Future<Response> getDataRj([Map<String, dynamic>? query]) async =>
      get('logistik/rbp/barat', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteData(int id) async => delete('path/$id');

  Future<Response> getDatabelum([Map<String, dynamic>? query]) async =>
      get('rbp/timur/belum-validasi', query);

  Future<Response> getDataSudah([Map<String, dynamic>? query]) async =>
      get('rbp/timur/sudah-validasi', query);

  Future<Response> getDataDetail(String noHide) async =>
      get('rbp/timur/detail/$noHide');

  Future<Response> validadiRbp(
    Map<String, dynamic> data,
    int id,
  ) async =>
      patch('rbp/timur/validasi/$id/bsd', data);

  //RBP RJ

  Future<Response> getDatarjbelum([Map<String, dynamic>? query]) async =>
      get('rbp/barat/belum-validasi', query);

  Future<Response> getDataRjDetail(String noHide) async =>
      get('rbp/barat/detail/$noHide');

  Future<Response> getDatarjSudah([Map<String, dynamic>? query]) async =>
      get('rbp/barat/sudah-validasi', query);
  Future<Response> validasiRbpRj(
    Map<String, dynamic> data,
    int id,
  ) async =>
      patch('rbp/barat/validasi/$id/bsd', data);
}
