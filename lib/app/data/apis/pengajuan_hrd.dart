part of 'api.dart';

class PengajuanHrdApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('hrd/pengajuan/departemen/sudah-validasi', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('hrd/pengajuan/departemen', data);

  Future<Response> updateData(Map<String, dynamic> data, String nohide) async =>
      patch('hrd/pengajuan/departemen/$nohide', data);

  Future<Response> deleteData(int id) async =>
      delete('hrd/pengajuan/departemen/sudah-validasi/$id');

  Future<Response> getDataBelum([Map<String, dynamic>? query]) async =>
      get('hrd/pengajuan/departemen/belum-validasi', query);

  Future<Response> getPengajuanDepartemen(
          [Map<String, dynamic>? query]) async =>
      get('hrd/pengajuan/departemen', query);

  Future<Response> createPengajuan() async => post('hrd/pengajuan/departemen');

  Future<Response> getDataByNoHide(String nohide) async =>
      get('hrd/pengajuan/departemen/$nohide');
}

/*
daftar users

/users = api get list users
[{id: 1, name: hen}, {id:2, name: wil}]

/users/1 = api get detail
{id: 1, name: hen, email: hen@gmail}

*/
