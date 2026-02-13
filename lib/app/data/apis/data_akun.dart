part of 'api.dart';

class DataAkunApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('it/data-akun', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('it/data-akun', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      patch('it/data-akun/$id', data);
  Future<Response> deleteData(int id) async => delete('it/data-akun/$id');
}
