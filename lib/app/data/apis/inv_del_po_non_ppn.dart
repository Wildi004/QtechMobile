part of 'api.dart';

class InvDelPoNonPpnApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/invoice/delivery/po-non-ppn/sudah-validasi', query);
  Future<Response> getBelumVal([Map<String, dynamic>? query]) async =>
      get('logistik/invoice/delivery/po-non-ppn/belum-validasi', query);
  Future<Response> getDataNoHide(String noHide) async =>
      get('logistik/invoice/delivery/po-non-ppn/$noHide');
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/invoice/delivery/po-non-ppn/sudah-validasi', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('logistik/invoice/delivery/po-non-ppn/sudah-validasi/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('logistik/invoice/delivery/po-non-ppn/sudah-validasi/$id');

  Future<Response> getDataFilter([Map<String, dynamic>? query]) async =>
      get('logistik/invoice/delivery/po-non-ppn/filter', query);
  Future<Response> cetak([Map<String, dynamic>? query]) async =>
      get('logistik/invoice/delivery/po-non-ppn/cetak', query);

  Future<Response> validasiInvDelPoNonPpn(
          Map<String, dynamic> data, String nohide) async =>
      patch('logistik/invoice/delivery/po-non-ppn/validasi/bsd/$nohide', data);
}
