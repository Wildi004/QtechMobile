part of 'api.dart';

class PengajuanAllApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('hrd/pengajuan/departemen', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('hrd/pengajuan/departemen', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('hrd/pengajuan/departemen/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('hrd/pengajuan/departemen/$id');
}
