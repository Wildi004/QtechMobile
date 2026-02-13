part of 'api.dart';

class SaldoAllDepApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('bsd/saldo/max-departemen', query);

  Future<Response> getDataSaldoIt([Map<String, dynamic>? query]) async =>
      get('it/saldo/max', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteData(int id) async => delete('path/$id');
}
