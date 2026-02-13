part of 'api.dart';

class ArsipLogistikApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/arsip', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/arsip', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('logistik/arsip/$id', data);
  Future<Response> deleteData(int id) async => delete('logistik/arsip/$id');
}
