part of 'api.dart';

class SaldoRndApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('rnd/saldo', query);
  Future<Response> getDataMax([Map<String, dynamic>? query]) async =>
      get('rnd/saldo/max', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteData(int id) async => delete('path/$id');
}
