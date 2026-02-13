part of 'api.dart';

class EkpedisiApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/ekspedisi', query);
  Future<Response> getDataDetail(int id) async => get('logistik/ekspedisi/$id');

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/ekspedisi', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      patch('logistik/ekspedisi/$id', data);
  Future<Response> deleteData(int id) async => delete('logistik/ekspedisi/$id');
}
