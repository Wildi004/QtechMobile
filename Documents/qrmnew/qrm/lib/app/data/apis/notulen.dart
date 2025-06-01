part of 'api.dart';

class NotulenApi extends Fetchly {
  Future<Response> getNotulen([Map<String, dynamic>? query]) async =>
      get('notulen', query);

  Future<Response> getDatanot(int id) async => get(
        'notulen/$id',
      );

  Future<Response> createNotulen(Map<String, dynamic> data) async =>
      post('notulen', data.toFormData());

  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      post('notulen/$id', {...data, '_method': 'patch'}.toFormData());

  Future<Response> deleteNotulen(int id) async => delete('notulen/$id');
}
