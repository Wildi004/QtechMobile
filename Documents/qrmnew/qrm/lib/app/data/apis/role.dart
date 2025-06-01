part of 'api.dart';

class RoleApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('role', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('role', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('role/$id', data);
  Future<Response> deleteData(int id) async => delete('role/$id');
}
