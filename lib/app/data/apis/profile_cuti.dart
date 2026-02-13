part of 'api.dart';

class ProfileCutiApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('pengajuan/hrd/cuti/sudah-validasi', query);
  Future<Response> getDataBelum([Map<String, dynamic>? query]) async =>
      get('pengajuan/hrd/cuti/belum-validasi', query);

  Future<Response> getDataDetailBelum(int id) async =>
      get('pengajuan/hrd/cuti/belum-validasi/$id');
  Future<Response> getDataDetailSudah(int id) async =>
      get('pengajuan/hrd/cuti/sudah-validasi/$id');

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteData(int id) async => delete('path/$id');
}
