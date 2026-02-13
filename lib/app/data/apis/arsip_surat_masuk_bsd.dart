part of 'api.dart';

class ArsipSuratMasukBsdApi extends Fetchly {
  //Dir BSD

  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('bsd/arsip/surat-masuk', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('bsd/arsip/surat-masuk', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('bsd/arsip/surat-masuk/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('bsd/arsip/surat-masuk/$id');

  //IT

  Future<Response> getDataIt([Map<String, dynamic>? query]) async =>
      get('it/arsip/surat-masuk', query);
  Future<Response> createDataIt(Map<String, dynamic> data) async =>
      post('it/arsip/surat-masuk', data);
  Future<Response> updateDataIt(Map<String, dynamic> data, int id) async =>
      put('it/arsip/surat-masuk/$id', data);
  Future<Response> deleteDataIt(int id) async =>
      delete('it/arsip/surat-masuk/$id');

  //RND

  Future<Response> getDataRnd([Map<String, dynamic>? query]) async =>
      get('rnd/arsip/surat-masuk', query);
  Future<Response> createDataRnd(Map<String, dynamic> data) async =>
      post('rnd/arsip/surat-masuk', data);
  Future<Response> updateDataRnd(Map<String, dynamic> data, int id) async =>
      put('rnd/arsip/surat-masuk/$id', data);
  Future<Response> deleteDataRnd(int id) async =>
      delete('rnd/arsip/surat-masuk/$id');
}
