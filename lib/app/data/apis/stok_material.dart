part of 'api.dart';

class StokMaterialApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/stok-material', query);

  Future<Response> getDataDetail(int id) async =>
      get('logistik/stok-material/$id');

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/stok-material', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      patch('logistik/stok-material/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('logistik/stok-material/$id');

  //jkt

  Future<Response> getDataJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/stok-material', query);

  Future<Response> getDataDetailJkt(int id) async =>
      get('logistik-jakarta/stok-material/$id');

  Future<Response> createDataJkt(Map<String, dynamic> data) async =>
      post('logistik-jakarta/stok-material', data);
  Future<Response> updateDataJkt(Map<String, dynamic> data, int id) async =>
      patch('logistik-jakarta/stok-material/$id', data);
  Future<Response> deleteDataJkt(int id) async =>
      delete('logistik-jakarta/stok-material/$id');
}
