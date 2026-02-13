part of 'api.dart';

class PoPpnApi extends Fetchly {
  Future<Response> getDataAll([Map<String, dynamic>? query]) async =>
      get('logistik/po-ppn', query);
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/po-ppn/sudah-validasi', query);
  Future<Response> getDataBelumValidasi([Map<String, dynamic>? query]) async =>
      get('logistik/po-ppn/belum-validasi', query);
  Future<Response> getDataNoHide(String? nohide) async =>
      get('logistik/po-ppn/$nohide');
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/po-ppn', data);
  Future<Response> updateData(Map<String, dynamic> data, String nohide) async =>
      patch('logistik/po-ppn/$nohide', data);
  Future<Response> deleteData(String noHide) async =>
      delete('logistik/po-ppn/$noHide');

  Future<Response> getDataFilter([Map<String, dynamic>? query]) async =>
      get('logistik/po-ppn/filter', query);
  Future<Response> cetak([Map<String, dynamic>? query]) async =>
      get('logistik/po-ppn/cetak', query);

  Future<Response> validasiPoPpn(
          Map<String, dynamic> data, String nohide) async =>
      patch('logistik/po-ppn/validasi/bsd/$nohide', data);
}
