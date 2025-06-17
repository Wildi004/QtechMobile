part of 'api.dart';

class ProyekItemApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('data-proyek/timur/item', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('data-proyek/timur/item', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('data-proyek/timur/item/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('data-proyek/timur/item/$id');
}
