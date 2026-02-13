part of 'api.dart';

class AsetElektronikApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('it/aset-elektronik', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('it/aset-elektronik', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('it/aset-elektronik/$id', data);
  Future<Response> deleteData(int id) async => delete('it/aset-elektronik/$id');
}
