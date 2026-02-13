part of 'api.dart';

class DekKenLegalApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('legal/dokumentasi-kendaraan', query);
  Future<Response> getDataDetail(int id) async =>
      get('legal/dokumentasi-kendaraan/$id');

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('legal/dokumentasi-kendaraan', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async => post(
      'legal/dokumentasi-kendaraan/$id',
      {...data, '_method': 'patch'}.toFormData());
  Future<Response> deleteData(int id) async =>
      delete('legal/dokumentasi-kendaraan/$id');
}
