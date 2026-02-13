part of 'api.dart';

class ArtikelTeknikApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('it/artikel/teknik', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('it/artikel/teknik', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('it/artikel/teknik/$id', data);
  Future<Response> deleteData(int id) async => delete('it/artikel/teknik/$id');
}
