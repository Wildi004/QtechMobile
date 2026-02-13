part of 'api.dart';

class InvDelPoPpnApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/invoice/delivery/po-ppn/sudah-validasi', query);
  Future<Response> getBelumVal([Map<String, dynamic>? query]) async =>
      get('logistik/invoice/delivery/po-ppn/belum-validasi', query);
  Future<Response> getDataNoHide(String noHide) async =>
      get('logistik/invoice/delivery/po-ppn/$noHide');
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/invoice/delivery/po-ppn', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('logistik/invoice/delivery/po-ppn/sudah-validasi/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('logistik/invoice/delivery/po-ppn/sudah-validasi/$id');

  Future<Response> getDataFilter([Map<String, dynamic>? query]) async =>
      get('logistik/invoice/delivery/po-ppn/filter', query);
  Future<Response> cetak([Map<String, dynamic>? query]) async =>
      get('logistik/invoice/delivery/po-ppn/cetak', query);

  Future<Response> validasiInvDelPoPpn(
          Map<String, dynamic> data, String nohide) async =>
      patch('logistik/invoice/delivery/po-ppn/validasi/bsd/$nohide', data);
}
