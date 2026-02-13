part of 'api.dart';

class PtjGlobalApi extends Fetchly {
  //HRD
  Future<Response> getDataPtjHrd([Map<String, dynamic>? query]) async =>
      get('hrd/ptj/sudah-validasi', query);

  Future<Response> createPengajuanHrd({required String type}) async =>
      post('hrd/ptj', {'type': type});

  Future<Response> updateDataPtjHrd(
          Map<String, dynamic> data, String nohide) async =>
      post('hrd/ptj/$nohide', {...data, '_method': 'patch'}.toFormData());

  Future<Response> deleteDataPtjHrd(String noHide) async =>
      delete('hrd/ptj/$noHide');

  Future<Response> getDataBelumPtjHrd([Map<String, dynamic>? query]) async =>
      get('hrd/ptj/belum-validasi', query);

  Future<Response> getDataByNoHidePtjHrd(String nohide) async =>
      get('hrd/ptj/$nohide');

  //IT
  Future<Response> getDataPtjIt([Map<String, dynamic>? query]) async =>
      get('it/ptj/sudah-validasi', query);

  Future<Response> getDataBelumPtjIt([Map<String, dynamic>? query]) async =>
      get('it/ptj/belum-validasi', query);

  Future<Response> getDataByNoHidePtjIt(String nohide) async =>
      get('it/ptj/$nohide');

  Future<Response> createPengajuanPtjIt({required String type}) async =>
      post('it/ptj', {'type': type});

  Future<Response> updateDataIt(
          Map<String, dynamic> data, String nohide) async =>
      post('it/ptj/$nohide', {...data, '_method': 'patch'}.toFormData());

  Future<Response> updateDataPtjIt(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);

  Future<Response> deletePtjIt(String noHide) async => delete('it/ptj/$noHide');
  Future<Response> validasiIt(Map<String, dynamic> data, String nohide) async =>
      patch('it/ptj/validasi/bsd/$nohide', data);

  Future<Response> getDataFilter([Map<String, dynamic>? query]) async =>
      get('it/ptj/filter', query);

  // Legal

  Future<Response> getDataPtjLegal([Map<String, dynamic>? query]) async =>
      get('legal/ptj/sudah-validasi', query);

  Future<Response> getDataBelumPtjLegal([Map<String, dynamic>? query]) async =>
      get('legal/ptj/belum-validasi', query);

  Future<Response> getDataByNoHidePtjLegal(String nohide) async =>
      get('legal/ptj/$nohide');

  Future<Response> createPengajuanPtjLegal({required String type}) async =>
      post('legal/ptj', {'type': type});

  Future<Response> updateDataLegal(
          Map<String, dynamic> data, String nohide) async =>
      post('legal/ptj/$nohide', {...data, '_method': 'patch'}.toFormData());
  Future<Response> deletePtjLegal(String noHide) async =>
      delete('legal/ptj/$noHide');

  Future<Response> validasiLegal(
          Map<String, dynamic> data, String nohide) async =>
      patch('legal/ptj/validasi/bsd/$nohide', data);

  // Logistik

  Future<Response> getDataPtjLogistik([Map<String, dynamic>? query]) async =>
      get('logistik/ptj/sudah-validasi', query);

  Future<Response> getDataBelumPtjLogistik(
          [Map<String, dynamic>? query]) async =>
      get('logistik/ptj/belum-validasi', query);

  Future<Response> getNoHideLogistik(String nohide) async =>
      get('logistik/ptj/$nohide');
  Future<Response> createPtjLogistik({required String type}) async =>
      post('logistik/ptj', {'type': type});

  Future<Response> updatePtjLogistik(
          Map<String, dynamic> data, String nohide) async =>
      post('logistik/ptj/$nohide', {...data, '_method': 'patch'}.toFormData());

  Future<Response> validasiLogistik(
          Map<String, dynamic> data, String nohide) async =>
      patch('logistik/ptj/validasi/bsd/$nohide', data);

  Future<Response> deletePtjLogistik(String noHide) async =>
      delete('logistik/ptj/$noHide');

  //BSD

  Future<Response> createPtjBsd() async => post('bsd/ptj');

  Future<Response> deletePtjBsd(String noHide) async =>
      delete('bsd/ptj/$noHide');

  Future<Response> updatePtjBsd(
          Map<String, dynamic> data, String nohide) async =>
      patch('bsd/ptj/$nohide', data);

  // RND
  Future<Response> getDataPtjRnd([Map<String, dynamic>? query]) async =>
      get('rnd/ptj/sudah-validasi', query);
  Future<Response> getDataBelumPtjRnd([Map<String, dynamic>? query]) async =>
      get('rnd/ptj/belum-validasi', query);
  Future<Response> getDataByNoHidePtjRnd(String nohide) async =>
      get('rnd/ptj/$nohide');
  Future<Response> updateDataRnd(
          Map<String, dynamic> data, String nohide) async =>
      post('rnd/ptj/$nohide', {...data, '_method': 'patch'}.toFormData());

  Future<Response> createPengajuanPtjRnd({required String type}) async =>
      post('rnd/ptj', {'type': type});

  Future<Response> validasiRnd(
          Map<String, dynamic> data, String nohide) async =>
      patch('rnd/ptj/validasi/bsd/$nohide', data);

  Future<Response> getDataFilterRnd([Map<String, dynamic>? query]) async =>
      get('rnd/ptj/filter', query);
}
