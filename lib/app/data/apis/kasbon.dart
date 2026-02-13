part of 'api.dart';

class KasbonApi extends Fetchly {
  Future<Response> getDataKasbon(int userId,
          [Map<String, dynamic>? query]) async =>
      get(
        'kasbon/user/$userId',
        query,
      );

  Future<Response> getDataSudahValidasi([
    Map<String, dynamic>? query,
  ]) async =>
      get('kasbon/sudah-validasi', query);
  Future<Response> getDataKasbonBelumValidasi(
          [Map<String, dynamic>? query]) async =>
      get('kasbon/belum-validasi', query);
  Future<Response> getDataDetail(int id) async => get('kasbon/$id');

  Future<Response> createData(Map<String, dynamic> query) async =>
      post('kasbon', query);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      post('tkdn/$id', {...data, '_method': 'patch'}.toFormData());

  Future<Response> updateValidasi(Map<String, dynamic> data, int id) async =>
      put('kasbon/validasi/gm/$id', data);
}
