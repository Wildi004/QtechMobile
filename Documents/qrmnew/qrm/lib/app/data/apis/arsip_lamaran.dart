part of 'api.dart';

class ArsipLamaranApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('arsip/lamaran', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('arsip/lamaran', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      post('arsip/lamaran/$id', {...data, '_method': 'patch'}.toFormData());

  Future<Response> deleteData(int id) async => delete('arsip/lamaran/$id');
}
