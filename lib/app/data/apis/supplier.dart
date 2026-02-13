part of 'api.dart';

class SupplierApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/supplier', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/supplier', data);

  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      patch('logistik/supplier/$id', data);
  Future<Response> deleteData(int id) async => delete('logistik/supplier/$id');
}
