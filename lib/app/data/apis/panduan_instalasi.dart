part of 'api.dart';

class PanduanInstalasiApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('panduan-instalasi', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('panduan-instalasi', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('panduan-instalasi/$id', data);
  Future<Response> deleteData(int id) async => delete('panduan-instalasi/$id');
}
