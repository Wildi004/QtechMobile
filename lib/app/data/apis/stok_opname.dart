part of 'api.dart';

class StokOpnameApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/stok-opname', query);

  Future<Response> getDataDetail(int id) async =>
      get('logistik/stok-opname/$id');

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/stok-opname', data);

  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('logistik/stok-opname/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('logistik/stok-opname/$id');

  //Jkt

  Future<Response> getDataJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/stok-opname', query);

  Future<Response> getDataDetailJkt(int id) async =>
      get('logistik-jakarta/stok-opname/$id');

  Future<Response> createDataJkt(Map<String, dynamic> data) async =>
      post('logistik-jakarta/stok-opname', data);

  Future<Response> updateDataJkt(Map<String, dynamic> data, int id) async =>
      put('logistik-jakarta/stok-opname/$id', data);
  Future<Response> deleteDataJkt(int id) async =>
      delete('logistik-jakarta/stok-opname/$id');
}
