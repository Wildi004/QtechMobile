part of 'api.dart';

class ArsipKaryawanHrdApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('hrd/arsip/karyawan/regional/pusat', query);
  Future<Response> getDataTimur([Map<String, dynamic>? query]) async =>
      get('hrd/arsip/karyawan/regional/timur', query);
  Future<Response> getDataBarat([Map<String, dynamic>? query]) async =>
      get('hrd/arsip/karyawan/regional/barat', query);

  Future<Response> getDataDetail(int id) async => get('karyawan/tetap/$id');
  Future<Response> createData(
    Map<String, dynamic> data,
  ) async =>
      post('hrd/arsip/karyawan', data.toFormData());

  Future<Response> updateData(Map<String, dynamic> data, id) async {
    data['_method'] = 'patch';
    return post('hrd/arsip/karyawan/$id', data.toFormData());
  }

  Future<Response> deleteData(int id) async => delete('hrd/arsip/karyawan/$id');
}
