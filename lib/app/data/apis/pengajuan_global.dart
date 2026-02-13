part of 'api.dart';

class PengajuanGlobalApi extends Fetchly {
  //HRD

  Future<Response> getDataHrdSudahValidasi(
          [Map<String, dynamic>? query]) async =>
      get('hrd/pengajuan/departemen/sudah-validasi', query);

  Future<Response> getDataHrdByNoHide(String nohide) async =>
      get('hrd/pengajuan/departemen/$nohide');

  Future<Response> getValidasiHrd(
          Map<String, dynamic> data, String nohide) async =>
      patch('hrd/pengajuan/departemen/validasi/bsd/$nohide', data);

  Future<Response> getDataHrdBelumValidasi(
          [Map<String, dynamic>? query]) async =>
      get('hrd/pengajuan/departemen/belum-validasi', query);

  Future<Response> getDataHrdDetail({String limit = 'all'}) {
    return get('hrd/pengajuan/departemen/detail?limit=$limit');
  }

  Future<Response> deleteHrd(String noHide) async =>
      delete('hrd/pengajuan/departemen/$noHide');
  Future<Response> createPengajuanHrd() async =>
      post('hrd/pengajuan/departemen');

  Future<Response> updateDataHrd(
          Map<String, dynamic> data, String nohide) async =>
      patch('hrd/pengajuan/departemen/$nohide', data);

  //IT
  Future<Response> getDataItSudahValidasi(
          [Map<String, dynamic>? query]) async =>
      get('it/pengajuan/departemen/sudah-validasi', query);

  Future<Response> getDataItBelumValidasi(
          [Map<String, dynamic>? query]) async =>
      get('it/pengajuan/departemen/belum-validasi', query);
  Future<Response> getValidasiIt(
          Map<String, dynamic> data, String nohide) async =>
      patch('it/pengajuan/departemen/validasi/bsd/$nohide', data);
  Future<Response> getDataItByNoHide(String nohide) async =>
      get('it/pengajuan/departemen/$nohide');
  Future<Response> deleteDataIt(String noHide) async =>
      delete('it/pengajuan/departemen/$noHide');
  Future<Response> getDataItDetail({String limit = 'all'}) {
    return get('it/pengajuan/departemen/detail?limit=$limit');
  }

  Future<Response> getDataFilter([Map<String, dynamic>? query]) async =>
      get('it/pengajuan/departemen/filter', query);
  Future<Response> createPengajuanIt() async => post('it/pengajuan/departemen');

  Future<Response> updateDataPengajuanIt(
          Map<String, dynamic> data, String nohide) async =>
      patch('it/pengajuan/departemen/$nohide', data);

  // Legal

  Future<Response> getDataLegalSudahValidasi(
          [Map<String, dynamic>? query]) async =>
      get('legal/pengajuan/departemen/sudah-validasi', query);

  Future<Response> getDataLEgalByNoHide(String nohide) async =>
      get('legal/pengajuan/departemen/$nohide');

  Future<Response> getDataLegalBelumValidasi(
          [Map<String, dynamic>? query]) async =>
      get('legal/pengajuan/departemen/belum-validasi', query);

  Future<Response> createPengajuanLegal() async =>
      post('legal/pengajuan/departemen');

  Future<Response> updateDataPengajuanLegal(
          Map<String, dynamic> data, String nohide) async =>
      patch('legal/pengajuan/departemen/$nohide', data);
  Future<Response> deleteDataLegal(String noHide) async =>
      delete('legal/pengajuan/departemen/$noHide');

  Future<Response> getDataDetailLegal({String limit = 'all'}) {
    return get('legal/pengajuan/departemen/detail?limit=$limit');
  }

  Future<Response> getValidasiLegal(
          Map<String, dynamic> data, String nohide) async =>
      patch('legal/pengajuan/departemen/validasi/bsd/$nohide', data);

  // logistik

  Future<Response> getDataLogistikSudahValidasi(
          [Map<String, dynamic>? query]) async =>
      get('logistik/pengajuan/departemen/sudah-validasi', query);

  Future<Response> getDatalogistikByNoHide(String nohide) async =>
      get('logistik/pengajuan/departemen/$nohide');

  Future<Response> getDataLogistikBelumValidasi(
          [Map<String, dynamic>? query]) async =>
      get('logistik/pengajuan/departemen/belum-validasi', query);

  Future<Response> getLogistikNoHide(String nohide) async =>
      get('logistik/pengajuan/departemen/$nohide');

  Future<Response> getValidasiLogistik(
          Map<String, dynamic> data, String nohide) async =>
      patch('logistik/pengajuan/departemen/validasi/bsd/$nohide', data);

  Future<Response> getLogistikDetail({String limit = 'all'}) {
    return get('logistik/pengajuan/departemen/detail?limit=$limit');
  }

  Future<Response> deleteDataLogistik(String noHide) async =>
      delete('logistik/pengajuan/departemen/$noHide');
  Future<Response> createPengajuanLogistik() async =>
      post('logistik/pengajuan/departemen');

  Future<Response> updatePengajuanlogistik(
          Map<String, dynamic> data, String nohide) async =>
      patch('logistik/pengajuan/departemen/$nohide', data);

  // BSD

  Future<Response> createPengajuanBsd() async =>
      post('bsd/pengajuan/departemen');

  Future<Response> deleteDataBsd(String noHide) async =>
      delete('bsd/pengajuan/departemen/$noHide');

  Future<Response> updatePengajuanBsd(
          Map<String, dynamic> data, String nohide) async =>
      patch('bsd/pengajuan/departemen/$nohide', data);

  //RND
  Future<Response> getDataRndSudahValidasi(
          [Map<String, dynamic>? query]) async =>
      get('rnd/pengajuan/departemen/sudah-validasi', query);
  Future<Response> getDataRndByNoHide(String nohide) async =>
      get('rnd/pengajuan/departemen/$nohide');

  Future<Response> getDataRndBelumValidasi(
          [Map<String, dynamic>? query]) async =>
      get('rnd/pengajuan/departemen/belum-validasi', query);
  Future<Response> getDataRndDetail({String limit = 'all'}) {
    return get('rnd/pengajuan/departemen/detail?limit=$limit');
  }

  Future<Response> getDataFilterRnd([Map<String, dynamic>? query]) async =>
      get('rnd/pengajuan/departemen/filter', query);

  Future<Response> getValidasiRnd(
          Map<String, dynamic> data, String nohide) async =>
      patch('rnd/pengajuan/departemen/validasi/bsd/$nohide', data);
  Future<Response> createPengajuanRnd() async =>
      post('rnd/pengajuan/departemen');

  Future<Response> updateDataPengajuanRnd(
          Map<String, dynamic> data, String nohide) async =>
      patch('rnd/pengajuan/departemen/$nohide', data);

  Future<Response> deleteDataRnd(String noHide) async =>
      delete('rnd/pengajuan/departemen/$noHide');
}
