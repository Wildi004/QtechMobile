part of 'api.dart';

class SisaKasbonApi extends Fetchly {
  Future<Response> getData(int userId, [Map<String, dynamic>? query]) async {
    return get('kasbon/saldo/$userId', query);
  }

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteData(int id) async => delete('path/$id');
}
