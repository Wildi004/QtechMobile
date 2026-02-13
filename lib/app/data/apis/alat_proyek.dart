part of 'api.dart';

class AlatProyekApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/alat-proyek', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/alat-proyek', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async => post(
      'logistik/alat-proyek/$id', {...data, '_method': 'patch'}.toFormData());
  Future<Response> deleteData(int id) async =>
      delete('logistik/alat-proyek/$id');

  Future<Response> getDataDetail(int id) async =>
      get('logistik/alat-proyek/$id');
}
