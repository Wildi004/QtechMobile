part of 'api.dart';

class SaldoPtjApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('hrd/saldo/max', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('hrd/saldo/max', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('hrd/saldo/max/$id', data);
  Future<Response> deleteData(int id) async => delete('hrd/saldo/max/$id');
}
