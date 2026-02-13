part of 'api.dart';

class InvDelPembNonPpnApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/invoice/delivery/pembelian-non-ppn/sudah-validasi', query);

  Future<Response> getBelumValidasi([Map<String, dynamic>? query]) async =>
      get('logistik/invoice/delivery/pembelian-non-ppn/belum-validasi', query);

  Future<Response> getDataNoHide(String noHide) async =>
      get('logistik/invoice/delivery/pembelian-non-ppn/$noHide');
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/invoice/delivery/pembelian-non-ppn', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteData(int id) async => delete('path/$id');

  Future<Response> validasiInvDelPembNonPpn(
          Map<String, dynamic> data, String nohide) async =>
      patch('logistik/invoice/delivery/pembelian-non-ppn/validasi/bsd/$nohide',
          data);

  //Jkt
  Future<Response> getDataJkt([Map<String, dynamic>? query]) async => get(
      'logistik-jakarta/invoice/delivery/pembelian-non-ppn/sudah-validasi',
      query);

  Future<Response> getBelumValidasiJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/invoice/delivery/pembelian-non-ppn/belum-validasi',
          query);

  Future<Response> getDataNoHideJkt(String noHide) async =>
      get('logistik-jakarta/invoice/delivery/pembelian-non-ppn/$noHide');
  Future<Response> createDataJkt(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateDataJkt(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteDataJkt(int id) async => delete('path/$id');
}
