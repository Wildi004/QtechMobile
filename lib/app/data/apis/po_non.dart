part of 'api.dart';

class PoNonApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/po-non-ppn/sudah-validasi', query);

  Future<Response> getDataBelumValidasi([Map<String, dynamic>? query]) async =>
      get('logistik/po-non-ppn/belum-validasi', query);

  Future<Response> getDataNoHide(String nohide) async =>
      get('logistik/po-non-ppn/$nohide');

  Future<Response> createData() async => post('logistik/po-non-ppn');
  Future<Response> updateData(Map<String, dynamic> data, String nohide) async =>
      patch('logistik/po-non-ppn/$nohide', data);
  Future<Response> deleteData(String noHide) async =>
      delete('logistik/po-non-ppn/$noHide');

  Future<Response> getDataFilter([Map<String, dynamic>? query]) async =>
      get('logistik/po-non-ppn/filter', query);
  Future<Response> cetak([Map<String, dynamic>? query]) async =>
      get('logistik/po-non-ppn/cetak', query);

  Future<Response> validasiPoNonPpn(
          Map<String, dynamic> data, String nohide) async =>
      patch('logistik/po-non-ppn/validasi/bsd/$nohide', data);
}
