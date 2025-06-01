part of 'api.dart';

class SuratInternalApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('surat-internal', query);

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('surat-internal', data.toFormData());

  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      post('surat-internal/$id', {...data, '_method': 'patch'}.toFormData());

  Future<Response> deleteSI(int id) async => delete('surat-internal/$id');
}
