part of 'api.dart';

class ArsipSuratKeluarBsdApi extends Fetchly {
  //Dir BSD

  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('bsd/arsip/surat-keluar', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('bsd/arsip/surat-keluar', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('bsd/arsip/surat-keluar/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('bsd/arsip/surat-keluar/$id');

  //IT

  Future<Response> getDataIt([Map<String, dynamic>? query]) async =>
      get('it/arsip/surat-keluar', query);
  Future<Response> createDataIt(Map<String, dynamic> data) async =>
      post('it/arsip/surat-keluar', data);
  Future<Response> updateDataIt(Map<String, dynamic> data, int id) async =>
      put('it/arsip/surat-keluar/$id', data);
  Future<Response> deleteDataIt(int id) async =>
      delete('it/arsip/surat-keluar/$id');

  //Rnd

  Future<Response> getDataRnd([Map<String, dynamic>? query]) async =>
      get('rnd/arsip/surat-keluar', query);
  Future<Response> createDataRnd(Map<String, dynamic> data) async =>
      post('rnd/arsip/surat-keluar', data);
  Future<Response> updateDataRnd(Map<String, dynamic> data, int id) async =>
      put('rnd/arsip/surat-keluar/$id', data);
  Future<Response> deleteDataRnd(int id) async =>
      delete('rnd/arsip/surat-keluar/$id');
}
