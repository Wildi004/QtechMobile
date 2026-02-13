part of 'api.dart';

class BukuBankApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('profile/buku-bank', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('profile/buku-bank', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('profile/buku-bank/$id', data);
  Future<Response> deleteData(int id) async => delete('profile/buku-bank/$id');
}
