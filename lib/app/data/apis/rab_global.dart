part of 'api.dart';

class RabGlobalApi extends Fetchly {
  // HRD
  Future<Response> getDataRabSudahValidasiHrd(
          [Map<String, dynamic>? query]) async =>
      get('hrd/rab/sudah-validasi', query);
  Future<Response> getDataHrd([Map<String, dynamic>? query]) async =>
      get('hrd/rab', query);
  Future<Response> getDataDetailRab({String limit = 'all'}) {
    return get('hrd/rab/detail?limit=$limit');
  }

  Future<Response> getDataBelumValidasiHrd(
          [Map<String, dynamic>? query]) async =>
      get('hrd/rab/belum-validasi', query);

  Future<Response> getDataRabHrdbyId(int id) async => get('hrd/rab/$id');

  Future<Response> createDataRabHrd(Map<String, dynamic> data) async =>
      post('hrd/rab', data);

  Future<Response> updateDataRabHrd(Map<String, dynamic> data, int id) async =>
      patch('hrd/rab/$id', data);

  Future<Response> deleteData(int id) async =>
      delete('hrd/rab/sudah-validasi/$id');

  // IT

  Future<Response> getDataIt([Map<String, dynamic>? query]) async =>
      get('it/rab', query);

  Future<Response> getDataValidasiIt([Map<String, dynamic>? query]) async =>
      get('it/rab/sudah-validasi', query);

  Future<Response> getDataBelumValidasiIt(
          [Map<String, dynamic>? query]) async =>
      get('it/rab/belum-validasi', query);

  Future<Response> getDataRabItById(int id) async => get('it/rab/$id');

  Future<Response> createDataRabIt(Map<String, dynamic> data) async =>
      post('it/rab', data);

  Future<Response> getDataRabItDetail({String limit = 'all'}) {
    return get('it/rab/detail?limit=$limit');
  }

  Future<Response> updateDataRabIt(Map<String, dynamic> data, int id) async =>
      patch('hrd/rab/$id', data);

  Future<Response> getDataRabRetail([Map<String, dynamic>? query]) async =>
      get('it/rab/detail', query);

  // Legal

  Future<Response> getDataLegal([Map<String, dynamic>? query]) async =>
      get('legal/rab', query);

  Future<Response> getDataValidasiLegal([Map<String, dynamic>? query]) async =>
      get('legal/rab/sudah-validasi', query);

  Future<Response> getDataBelumValidasiLegal(
          [Map<String, dynamic>? query]) async =>
      get('legal/rab/belum-validasi', query);

  Future<Response> getDataRabLegalDetail({String limit = 'all'}) {
    return get('legal/rab/detail?limit=$limit');
  }

  Future<Response> getLegalId(int id) async => get('legal/rab/$id');

  Future<Response> creatLegal(Map<String, dynamic> data) async =>
      post('legal/rab', data);

  Future<Response> updateLegal(Map<String, dynamic> data, int id) async =>
      patch('legal/rab/$id', data);

  // Logistik

  Future<Response> getDatalogistik([Map<String, dynamic>? query]) async =>
      get('logistik/rab', query);

  Future<Response> getRabDetailLogistik({String limit = 'all'}) {
    return get('logistik/rab/detail?limit=$limit');
  }

  Future<Response> getValidasiLogistik([Map<String, dynamic>? query]) async =>
      get('logistik/rab/sudah-validasi', query);

  Future<Response> getBelumValidasiLogistik(
          [Map<String, dynamic>? query]) async =>
      get('logistik/rab/belum-validasi', query);

  Future<Response> getLogistkById(int id) async => get('logistik/rab/$id');

  Future<Response> createLogistik(Map<String, dynamic> data) async =>
      post('logistik/rab', data);

  Future<Response> updatelogistik(Map<String, dynamic> data, int id) async =>
      patch('logistik/rab/$id', data);

  //all

  Future<Response> getAllId(int id) async => get('bsd/rab/$id');

  Future<Response> validasiRabAll(Map<String, dynamic> data, int id) async =>
      patch('bsd/rab/validasi/$id', data);

  Future<Response> getAllRabSudahVal([Map<String, dynamic>? query]) async =>
      get('bsd/rab/sudah-validasi', query);

  Future<Response> getAllRabBelumVal([Map<String, dynamic>? query]) async =>
      get('bsd/rab/belum-validasi', query);

  // RND
  Future<Response> getDataRabRndDetail({String limit = 'all'}) {
    return get('rnd/rab/detail?limit=$limit');
  }

  Future<Response> getDataRnd([Map<String, dynamic>? query]) async =>
      get('rnd/rab', query);
  Future<Response> getDataRabRndById(int id) async => get('rnd/rab/$id');

  Future<Response> createDataRabRnd(Map<String, dynamic> data) async =>
      post('rnd/rab', data);

  Future<Response> updateDataRabRnd(Map<String, dynamic> data, int id) async =>
      patch('rnd/rab/$id', data);

  Future<Response> getDataBelumValidasiRnd(
          [Map<String, dynamic>? query]) async =>
      get('rnd/rab/belum-validasi', query);

  Future<Response> getDataValidasiRnd([Map<String, dynamic>? query]) async =>
      get('rnd/rab/sudah-validasi', query);
}
