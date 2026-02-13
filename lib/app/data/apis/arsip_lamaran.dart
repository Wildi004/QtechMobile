part of 'api.dart';

class ArsipLamaranApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('hrd/arsip/lamaran', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('hrd/arsip/lamaran', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      post('hrd/arsip/lamaran/$id', {...data, '_method': 'patch'}.toFormData());
  Future<Response> getDataDetail(int id) async => get('hrd/arsip/lamaran/$id');
  Future<Response> deleteData(int id) async => delete('hrd/arsip/lamaran/$id');
}
