part of 'api.dart';

class AsetKantorLogJktApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/aset/kantor', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik-jakarta/aset/kantor', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('logistik-jakarta/aset/kantor/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('logistik-jakarta/aset/kantor/$id');
}
