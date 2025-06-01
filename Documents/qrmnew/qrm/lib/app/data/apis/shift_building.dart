part of 'api.dart';

class ShiftBuildingApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('shift-building', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('shift-building', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      patch('shift-building/$id', data);
  Future<Response> deleteData(int id) async => delete('shift-building/$id');
}
