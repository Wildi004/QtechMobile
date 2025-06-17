part of 'api.dart';

class BuildingApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('building', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('building', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      patch('building/$id', data);
  Future<Response> deleteData(int id) async => delete('building/$id');
}
