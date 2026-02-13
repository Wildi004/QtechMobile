part of 'api.dart';

class SuratDireksiApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('sk-direksi', query);

  Future<Response> deleteteSk(int id) async => delete('sk-direksi/$id');

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('sk-direksi', data.toFormData());

  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      post('sk-direksi/$id', {...data, '_method': 'patch'}.toFormData());
}
