part of 'api.dart';

class AksesMenuApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('user/menu', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('user/menu', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('user/menu/$id', data);
  Future<Response> deleteData(int id) async => delete('user/menu/$id');
}
