part of 'api.dart';

class DelPembPpnApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/delivery/pembelian-ppn/sudah-validasi', query);
  Future<Response> getDataNoHide(String? nohide) async =>
      get('logistik/delivery/pembelian-ppn/$nohide');
  Future<Response> getBelumVal([Map<String, dynamic>? query]) async =>
      get('logistik/delivery/pembelian-ppn/belum-validasi', query);
  Future<Response> createData() async =>
      post('logistik/delivery/pembelian-ppn');

  Future<Response> updateData(Map<String, dynamic> data, String nohide) async =>
      patch('logistik/delivery/pembelian-ppn/$nohide', data);
  Future<Response> deleteData(String noHide) async =>
      delete('logistik/delivery/pembelian-ppn/$noHide');

  Future<Response> getDataFilter([Map<String, dynamic>? query]) async =>
      get('logistik/delivery/pembelian-ppn/filter', query);
  Future<Response> cetak([Map<String, dynamic>? query]) async =>
      get('logistik/delivery/pembelian-ppn/cetak', query);

  Future<Response> validasiDelPembPpn(
          Map<String, dynamic> data, String nohide) async =>
      patch('logistik/delivery/pembelian-ppn/validasi/bsd/$nohide', data);

  //Jkt
  Future<Response> getDataJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/delivery/pembelian-ppn/sudah-validasi', query);
  Future<Response> getDataNoHideJkt(String? nohide) async =>
      get('logistik-jakarta/delivery/pembelian-ppn/$nohide');
  Future<Response> getBelumValJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/delivery/pembelian-ppn/belum-validasi', query);
  Future<Response> createDataJkt() async =>
      post('logistik-jakarta/delivery/pembelian-ppn');

  Future<Response> updateDataJkt(
          Map<String, dynamic> data, String nohide) async =>
      patch('logistik-jakarta/delivery/pembelian-ppn/$nohide', data);
  Future<Response> deleteDataJkt(String noHide) async =>
      delete('logistik-jakarta/delivery/pembelian-ppn/$noHide');

  Future<Response> getDataFilterjkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/delivery/pembelian-ppn/filter', query);
  Future<Response> cetakJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/delivery/pembelian-ppn/cetak', query);
}
