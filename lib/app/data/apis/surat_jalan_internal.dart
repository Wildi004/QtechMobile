part of 'api.dart';

class SuratJalanInternalApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/surat-jalan/internal/sudah-validasi', query);

  Future<Response> getBelumVal([Map<String, dynamic>? query]) async =>
      get('logistik/surat-jalan/internal/belum-validasi', query);

  Future<Response> getDataNoHide(String? nohide) async =>
      get('logistik/surat-jalan/internal/$nohide');
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteData(String noHide) async =>
      delete('logistik/surat-jalan/internal/$noHide');

  Future<Response> validasiSuratJalanInternal(
          Map<String, dynamic> data, String nohide) async =>
      patch('logistik/surat-jalan/internal/validasi/bsd/$nohide', data);

  //Jkt

  Future<Response> getDataJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/surat-jalan/internal/sudah-validasi', query);

  Future<Response> getBelumValJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/surat-jalan/internal/belum-validasi', query);

  Future<Response> getDataNoHideJkt(String? nohide) async =>
      get('logistik-jakarta/surat-jalan/internal/$nohide');
  Future<Response> createDataJkt(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateDataJkt(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteDataJkt(String noHide) async =>
      delete('logistik-jakarta/surat-jalan/internal/$noHide');

  Future<Response> validasiSuratJalanInternalJkt(
          Map<String, dynamic> data, String nohide) async =>
      patch('logistik-jakarta/surat-jalan/internal/validasi/bsd/$nohide', data);
}
