part of 'api.dart';

class SuratEksternalApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('bsd/surat-eksternal', query);
  Future<Response> created() async => get('bsd/surat-eksternal/nomor');
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('bsd/surat-eksternal', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('bsd/surat-eksternal/$id', data);
  Future<Response> deleteData(int id) async => delete('path/$id');
}
