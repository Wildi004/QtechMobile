part of 'api.dart';

class ShiftApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('shift', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('shift', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      patch('shift/$id', data);
  Future<Response> deleteData(int id) async => delete('shift/$id');
}
