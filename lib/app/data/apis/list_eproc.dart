part of 'api.dart';

class ListEprocApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('legal/list-eproc', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('legal/list-eproc', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('legal/list-eproc/$id', data);
  Future<Response> deleteData(int id) async => delete('legal/list-eproc/$id');
}
