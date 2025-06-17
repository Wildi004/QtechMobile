part of 'api.dart';

class StatusKawinApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('status-kawin', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('status-kawin', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      patch('status-kawin/$id', data);
  Future<Response> deleteData(int id) async => delete('status-kawin/$id');
}
