part of 'api.dart';

class StandarTeknikApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('standarisasi-teknik', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('standarisasi-teknik', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('standarisasi-teknik/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('standarisasi-teknik/$id');
}
