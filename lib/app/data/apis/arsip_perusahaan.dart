part of 'api.dart';

class ArsipPerusahaanApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('bsd/arsip-perusahaan', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('bsd/arsip-perusahaan', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('bsd/arsip-perusahaan/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('bsd/arsip-perusahaan/$id');
}
