part of 'api.dart';

class PengumumanApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('pengumuman', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('pengumuman', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('pengumuman/$id', data);
  Future<Response> deleteData(int id) async => delete('pengumuman/$id');
}
