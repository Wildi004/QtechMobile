part of 'api.dart';

class BonusApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('profile/bonus', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('profile/bonus', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('profile/bonus/$id', data);
  Future<Response> deleteData(int id) async => delete('profile/bonus/$id');
}
