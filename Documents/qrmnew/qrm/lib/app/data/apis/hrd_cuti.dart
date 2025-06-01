part of 'api.dart';

class HrdCutiApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('pengajuan/hrd/cuti/sudah-validasi', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('pengajuan/hrd/cuti/sudah-validasi', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('pengajuan/hrd/cuti/sudah-validasi/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('pengajuan/hrd/cuti/sudah-validasi/$id');

  Future<Response> dataBelum([Map<String, dynamic>? query]) async =>
      get('pengajuan/hrd/cuti/belum-validasi', query);
}
