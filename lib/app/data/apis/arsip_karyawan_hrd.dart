part of 'api.dart';

class ArsipKaryawanHrdApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('arsip/karyawan/regional/pusat', query);
  Future<Response> getDataTimur([Map<String, dynamic>? query]) async =>
      get('arsip/karyawan/regional/timur', query);
  Future<Response> getDataBarat([Map<String, dynamic>? query]) async =>
      get('arsip/karyawan/regional/barat', query);

  Future<Response> createData(
    Map<String, dynamic> data,
  ) async =>
      post('arsip/karyawan', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, id) async =>
      put('arsip/karyawan/$id', data.toFormData());

  Future<Response> deleteData(int id) async => delete('arsip/karyawan/$id');
}
