part of 'api.dart';

class SaldoApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('hrd/saldo', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('hrd/saldo', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('hrd/saldo/$id', data);
  Future<Response> deleteData(int id) async => delete('hrd/saldo/$id');
}
