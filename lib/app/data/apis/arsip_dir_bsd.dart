part of 'api.dart';

class ArsipDirBsdApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('bsd/arsip', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('bsd/arsip', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('bsd/arsip/$id', data);
  Future<Response> deleteData(int id) async => delete('bsd/arsip/$id');
}
