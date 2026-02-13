part of 'api.dart';

class MenuAksesApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('menu', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('menu', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('menu/$id', data);
  Future<Response> deleteData(int id) async => delete('menu/$id');
}
