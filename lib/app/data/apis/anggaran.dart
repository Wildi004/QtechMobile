part of 'api.dart';

class AnggaranApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('anggaran-departemen', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('anggaran-departemen', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('anggaran-departemen/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('anggaran-departemen/$id');
}
