part of 'api.dart';

class DelPembNonPpnApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/delivery/pembelian-non-ppn/sudah-validasi', query);
  Future<Response> getBelumVal([Map<String, dynamic>? query]) async =>
      get('logistik/delivery/pembelian-non-ppn/belum-validasi', query);
  Future<Response> getDataNoHide(String? nohide) async =>
      get('logistik/delivery/pembelian-non-ppn/$nohide');
  Future<Response> createData() async =>
      post('logistik/delivery/pembelian-non-ppn');
  Future<Response> updateData(Map<String, dynamic> data, String nohide) async =>
      patch('logistik/delivery/pembelian-non-ppn/$nohide', data);
  Future<Response> deleteData(String noHide) async =>
      delete('logistik/delivery/pembelian-non-ppn/$noHide');

  Future<Response> getDataFilter([Map<String, dynamic>? query]) async =>
      get('logistik/delivery/pembelian-non-ppn/filter', query);
  Future<Response> cetak([Map<String, dynamic>? query]) async =>
      get('logistik/delivery/pembelian-non-ppn/cetak', query);

  Future<Response> validasiDelPembNonPpn(
          Map<String, dynamic> data, String nohide) async =>
      patch('logistik/delivery/pembelian-non-ppn/validasi/bsd/$nohide', data);

  //Jkt

  Future<Response> getDataJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/delivery/pembelian-non-ppn/sudah-validasi', query);
  Future<Response> getBelumValJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/delivery/pembelian-non-ppn/belum-validasi', query);
  Future<Response> getDataNoHideJkt(String? nohide) async =>
      get('logistik-jakarta/delivery/pembelian-non-ppn/$nohide');
  Future<Response> createDataJkt() async =>
      post('logistik-jakarta/delivery/pembelian-non-ppn');
  Future<Response> updateDataJkt(
          Map<String, dynamic> data, String nohide) async =>
      patch('logistik-jakarta/delivery/pembelian-non-ppn/$nohide', data);
  Future<Response> deleteDataJkt(String noHide) async =>
      delete('logistik-jakarta/delivery/pembelian-non-ppn/$noHide');

  Future<Response> getDataFilterJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/delivery/pembelian-non-ppn/filter', query);
  Future<Response> cetakJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/delivery/pembelian-non-ppn/cetak', query);
}
