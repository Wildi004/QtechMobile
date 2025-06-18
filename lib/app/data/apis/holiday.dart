part of 'api.dart';

class HolidayApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('holiday', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('holiday', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      patch('holiday/$id', data);
  Future<Response> deleteData(int id) async => delete('holiday/$id');
}
