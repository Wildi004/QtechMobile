part of 'api.dart';

class DaftarTkdnApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('tkdn', query);

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('tkdn', data.toFormData());

  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      post('tkdn/$id', {...data, '_method': 'patch'}.toFormData());

  Future<Response> deletetdkn(int id) async => delete('tkdn/$id');
}
