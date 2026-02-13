part of 'api.dart';

class SuratJalanExstNonApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/surat-jalan/eksternal-non-ppn/sudah-validasi', query);

  Future<Response> getBelumVal([Map<String, dynamic>? query]) async =>
      get('logistik/surat-jalan/eksternal-non-ppn/belum-validasi', query);

  Future<Response> getDataNoHide(String? nohide) async =>
      get('logistik/surat-jalan/eksternal-non-ppn/$nohide');
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteData(String noHide) async =>
      delete('logistik/surat-jalan/eksternal-non-ppn/$noHide');
  Future<Response> validasiSuratJalanExstNon(
          Map<String, dynamic> data, String nohide) async =>
      patch(
          'logistik/surat-jalan/eksternal-non-ppn/validasi/bsd/$nohide', data);

  //Jkt

  Future<Response> getDataJkt([Map<String, dynamic>? query]) async => get(
      'logistik-jakarta/surat-jalan/eksternal-non-ppn/sudah-validasi', query);

  Future<Response> getBelumValJkt([Map<String, dynamic>? query]) async => get(
      'logistik-jakarta/surat-jalan/eksternal-non-ppn/belum-validasi', query);

  Future<Response> getDataNoHideJkt(String? nohide) async =>
      get('logistik-jakarta/surat-jalan/eksternal-non-ppn/$nohide');
  Future<Response> createDataJkt(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateDataJkt(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteDataJkt(int id) async => delete('path/$id');
}
