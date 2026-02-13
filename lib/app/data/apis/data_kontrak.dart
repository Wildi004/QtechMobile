part of 'api.dart';

class DataKontrakApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('bsd/data-kontrak', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('bsd/data-kontrak', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('bsd/data-kontrak/$id', data);
  Future<Response> deleteData(int id) async => delete('bsd/data-kontrak/$id');
}
