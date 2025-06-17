part of 'api.dart';

class RabdetailApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('hrd/rab/detail', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('hrd/rab/detail', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('hrd/rab/detail/$id', data);
  Future<Response> deleteData(int id) async => delete('hrd/rab/detail/$id');
}
