part of 'api.dart';

class ArsipLegalApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('legal/arsip', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('legal/arsip', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('legal/arsip/$id', data.toFormData());
  Future<Response> deleteData(int id) async => delete('legal/arsip/$id');
}
