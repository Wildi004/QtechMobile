part of 'api.dart';

class SaldoDepBsdApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('bsd/saldo', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('bsd/saldo', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteData(int id) async => delete('path/$id');
}
