part of 'api.dart';

class InvDelPembPpnApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/invoice/delivery/pembelian-ppn/sudah-validasi', query);

  Future<Response> getBelumVal([Map<String, dynamic>? query]) async =>
      get('logistik/invoice/delivery/pembelian-ppn/belum-validasi', query);

  Future<Response> getDataNoHide(String noHide) async =>
      get('logistik/invoice/delivery/pembelian-ppn/$noHide');
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/invoice/delivery/pembelian-ppn', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteData(int id) async => delete('path/$id');

  Future<Response> validasiInvDelPembPpn(
          Map<String, dynamic> data, String nohide) async =>
      patch(
          'logistik/invoice/delivery/pembelian-ppn/validasi/bsd/$nohide', data);

  //Jkt

  Future<Response> getDataJkt([Map<String, dynamic>? query]) async => get(
      'logistik-jakarta/invoice/delivery/pembelian-ppn/sudah-validasi', query);

  Future<Response> getBelumValJkt([Map<String, dynamic>? query]) async => get(
      'logistik-jakarta/invoice/delivery/pembelian-ppn/belum-validasi', query);

  Future<Response> getDataNoHideJkt(String noHide) async =>
      get('logistik-jakarta/invoice/delivery/pembelian-ppn/$noHide');
  Future<Response> createDataJkt(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateDataJkt(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteDataJkt(int id) async => delete('path/$id');
}
