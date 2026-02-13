part of 'api.dart';

class PasBandaraHrdApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('hrd/pas-bandara', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('hrd/pas-bandara', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('hrd/pas-bandara/$id', data);
  Future<Response> deleteData(int id) async => delete('hrd/pas-bandara/$id');
}
