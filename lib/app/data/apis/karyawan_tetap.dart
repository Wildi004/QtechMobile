part of 'api.dart';

class KaryawanTetapApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('karyawan/tetap', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('karyawan/tetap', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      post('karyawan/tetap/$id', {...data, '_method': 'patch'}.toFormData());

  Future<Response> deleteData(int id) async => delete('karyawan/tetap/$id');

  Future<Response> updateTtd(Map<String, dynamic> data, int id) async => post(
      'karyawan/tetap/ttd/$id', {...data, '_method': 'patch'}.toFormData());

  Future<Response> getDataDetail(int id) async => get('karyawan/tetap/$id');

  Future<Response> updateStatus(Map<String, dynamic> data, int id) async =>
      patch('karyawan/tetap/status-user/$id', data);
}
