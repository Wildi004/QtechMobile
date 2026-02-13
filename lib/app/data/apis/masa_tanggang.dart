part of 'api.dart';

class MasaTanggangApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('it/data-masa-tenggang', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('it/data-masa-tenggang', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      patch('it/data-masa-tenggang/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('it/data-masa-tenggang/$id');
}
