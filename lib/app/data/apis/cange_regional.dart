part of 'api.dart';

class CangeRegionalApi extends Fetchly {
  Future<Response> getCange([Map<String, dynamic>? query]) async =>
      patch('user/current/change-regional', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteData(int id) async => delete('path/$id');
}
