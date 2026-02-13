part of 'api.dart';

class AlatProyekLogJktApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/alat-proyek', query);
  Future<Response> getDataDetail(int id) async =>
      get('logistik-jakarta/alat-proyek/$id');
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik-jakarta/alat-proyek', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async => post(
      'logistik-jakarta/alat-proyek/$id',
      {...data, '_method': 'patch'}.toFormData());
  Future<Response> deleteData(int id) async =>
      delete('logistik-jakarta/alat-proyek/$id');
}
