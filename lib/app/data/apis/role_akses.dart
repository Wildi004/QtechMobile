part of 'api.dart';

class RoleAksesApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('user/menu', query);

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('role', data.toFormData());

  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      post('role/$id', data.toFormData());

  Future<Response> deleteBrosur(int id) async => delete('role/$id');
}
