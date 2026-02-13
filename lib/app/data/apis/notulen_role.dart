part of 'api.dart';

class NotulenRoleApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('notulen/role', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('notulen/role', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('notulen/role/$id', data);
  Future<Response> deleteData(int id) async => delete('notulen/role/$id');
}
