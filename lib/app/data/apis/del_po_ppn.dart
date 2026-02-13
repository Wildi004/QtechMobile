part of 'api.dart';

class DelPoPpnApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/delivery/po-ppn/sudah-validasi', query);
  Future<Response> getBelumVal([Map<String, dynamic>? query]) async =>
      get('logistik/delivery/po-ppn/belum-validasi', query);
  Future<Response> getDataNoHide(String? nohide) async =>
      get('logistik/delivery/po-ppn/$nohide');
  Future<Response> createData() async => post('logistik/delivery/po-ppn');
  Future<Response> updateData(Map<String, dynamic> data, String nohide) async =>
      patch('logistik/delivery/po-ppn/$nohide', data);

  Future<Response> deleteData(String noHide) async =>
      delete('logistik/delivery/po-ppn/$noHide');

  Future<Response> getDataFilter([Map<String, dynamic>? query]) async =>
      get('logistik/delivery/po-ppn/filter', query);
  Future<Response> cetak([Map<String, dynamic>? query]) async =>
      get('logistik/delivery/po-ppn/cetak', query);

  Future<Response> validasiDelPoPpn(
          Map<String, dynamic> data, String nohide) async =>
      patch('logistik/delivery/po-ppn/validasi/bsd/$nohide', data);
}
