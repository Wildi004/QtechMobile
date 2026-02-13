part of 'api.dart';

class SaldoApi extends Fetchly {
  // HRD
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('hrd/saldo', query);

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('hrd/saldo', data);

  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('hrd/saldo/$id', data);

  Future<Response> deleteData(int id) async => delete('hrd/saldo/$id');

  Future<Response> getPageSaldo({int page = 1, String limit = 'all'}) async {
    final url = 'hrd/saldo?page=$page&limit=$limit';
    return get(url);
  }

  // IT
  Future<Response> getSaldoIt([Map<String, dynamic>? query]) async =>
      get('it/saldo/max', query);

  Future<Response> getDataSaldoIt([Map<String, dynamic>? query]) async =>
      get('it/saldo', query);

  Future<Response> createDataSaldoIt(Map<String, dynamic> data) async =>
      post('it/saldo', data);

  Future<Response> updateDataSaldoIt(Map<String, dynamic> data, int id) async =>
      put('it/saldo/$id', data);

  Future<Response> deleteDataSaldoIt(int id) async => delete('it/saldo/$id');

  // Saldo PTJ

  Future<Response> getDataSaldoPtj([Map<String, dynamic>? query]) async =>
      get('hrd/saldo/max', query);

  Future<Response> createDataSaldoPtj(Map<String, dynamic> data) async =>
      post('hrd/saldo/max', data);

  Future<Response> updateDataSaldoPtj(
          Map<String, dynamic> data, int id) async =>
      put('hrd/saldo/max/$id', data);

  Future<Response> deleteDataSaldoPtj(int id) async =>
      delete('hrd/saldo/max/$id');

  //saldo ptj legal

  Future<Response> getDataSaldoPtjlegal([Map<String, dynamic>? query]) async =>
      get('legal/saldo/max', query);

  Future<Response> getDataSaldoLegal([Map<String, dynamic>? query]) async =>
      get('legal/saldo', query);

  Future<Response> createDataSaldoLegal(Map<String, dynamic> data) async =>
      post('legal/saldo', data);

  // saldo logistik
  Future<Response> getSaldoPtjLogistik([Map<String, dynamic>? query]) async =>
      get('logistik/saldo/max', query);
  Future<Response> getDataLogistik([Map<String, dynamic>? query]) async =>
      get('logistik/saldo', query);

  Future<Response> createDataLogistik(Map<String, dynamic> data) async =>
      post('logistik/saldo', data);

  Future<Response> updateDataLogistik(
          Map<String, dynamic> data, int id) async =>
      put('logistik/saldo/$id', data);

  //BSD
  Future<Response> getDataSaldoPtjBsd([Map<String, dynamic>? query]) async =>
      get('bsd/saldo/max', query);
}
