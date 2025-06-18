part of 'api.dart';

class CapaianKerjaApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('capaian-kerja', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('capaian-kerja', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('capaian-kerja/$id', data);
  Future<Response> deleteData(int id) async => delete('capaian-kerja/$id');
}
