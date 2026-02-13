part of 'api.dart';

class KaryawanTidakApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('karyawan/tidak-tetap', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('karyawan/tidak-tetap', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async => post(
      'karyawan/tidak-tetap/$id', {...data, '_method': 'patch'}.toFormData());
  Future<Response> deleteData(int id) async =>
      delete('karyawan/tidak-tetap/$id');
  Future<Response> getDataDetail(int id) async =>
      get('karyawan/tidak-tetap/$id');
  Future<Response> updateStatusTidak(Map<String, dynamic> data, int id) async =>
      patch('karyawan/tidak-tetap/status-user/$id', data);
}
