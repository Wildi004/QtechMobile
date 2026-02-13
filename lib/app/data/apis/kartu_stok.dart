part of 'api.dart';

class KartuStokApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/kartu-stok', query);
  Future<Response> getDataDetail(String kodeStr) async =>
      get('logistik/kartu-stok/$kodeStr');
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/kartu-stok', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('logistik/kartu-stok/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('logistik/kartu-stok/$id');

  //Jkt
  Future<Response> getDataJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/kartu-stok', query);
  Future<Response> getDataDetailJkt(String kodeStr) async =>
      get('logistik-jakarta/kartu-stok/$kodeStr');
  Future<Response> createDataJkt(Map<String, dynamic> data) async =>
      post('logistik-jakarta/kartu-stok', data);
  Future<Response> updateDataJkt(Map<String, dynamic> data, int id) async =>
      put('logistik-jakarta/kartu-stok/$id', data);
  Future<Response> deleteDataJkt(int id) async =>
      delete('logistik-jakarta/kartu-stok/$id');
}
