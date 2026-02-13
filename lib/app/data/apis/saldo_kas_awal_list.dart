part of 'api.dart';

class SaldoKasAwalListApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('direktur-keuangan/akunting/saldo-kas-awal/list/kode-akun', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteData(int id) async => delete('path/$id');
}
