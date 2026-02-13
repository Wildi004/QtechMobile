part of 'api.dart';

class RoleAkses1Api extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('role-access', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('role-access', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('role-access/$id', data);
  Future<Response> deleteData(int id) async => delete('role-access/$id');

  Future<Response> getDataId(int id) async =>
      get('role-access/$id');  
}
