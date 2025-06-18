part of 'api.dart';

class DepartemenApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('departemen', query);

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('departemen', data);

  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      patch('departemen/$id', data);

  Future<Response> deleteData(int id) async => delete('departemen/$id');
}
