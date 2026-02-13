part of 'api.dart';

class ArsipRndApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('rnd/arsip', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('rnd/arsip', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('rnd/arsip/$id', data);
  Future<Response> deleteData(int id) async => delete('rnd/arsip/$id');
}
