part of 'api.dart';

class DokumenHrdApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('arsip/hrd', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('arsip/hrd', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      post('arsip/hrd/$id', {...data, '_method': 'patch'}.toFormData());

  Future<Response> deleteData(int id) async => delete('arsip/hrd/$id');
}
