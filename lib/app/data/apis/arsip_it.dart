part of 'api.dart';

class ArsipItApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('it/arsip', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('it/arsip', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('it/arsip/$id', data);
  Future<Response> deleteData(int id) async => delete('it/arsip/$id');
}
