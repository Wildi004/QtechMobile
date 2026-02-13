part of 'api.dart';

class ListDelpoPpnApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/delivery/po-ppn/list', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/delivery/po-ppn/list', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('logistik/delivery/po-ppn/list/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('logistik/delivery/po-ppn/list/$id');
}
