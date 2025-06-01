part of 'api.dart';

class KaryawanTidakApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('karyawan/tidak-tetap', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('karyawan/tidak-tetap', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('karyawan/tidak-tetap/$id', data.toFormData());
  Future<Response> deleteData(int id) async =>
      delete('karyawan/tidak-tetap/$id');
}
