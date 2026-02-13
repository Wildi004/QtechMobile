part of 'api.dart';

class CountNotifApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('bsd/count/validasi', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('bsd/count/validasi', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('bsd/count/validasi/$id', data);
  Future<Response> deleteData(int id) async => delete('bsd/count/validasi/$id');
}
