part of 'api.dart';

class SatuanLogistikApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/settings/satuan', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/settings/satuan', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      patch('logistik/settings/satuan/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('logistik/settings/satuan/$id');
}
