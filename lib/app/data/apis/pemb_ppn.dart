part of 'api.dart';

class PembPpnApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/pembelian/ppn/sudah-validasi', query);
  Future<Response> getBelumValidasi([Map<String, dynamic>? query]) async =>
      get('logistik/pembelian/ppn/belum-validasi', query);
  Future<Response> getDataNoHide(String? nohide) async =>
      get('logistik/pembelian/ppn/$nohide');
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/pembelian/ppn', data);
  Future<Response> updateData(Map<String, dynamic> data, String nohide) async =>
      patch('logistik/pembelian/ppn/$nohide', data);
  Future<Response> deleteData(String noHide) async =>
      delete('logistik/pembelian/ppn/$noHide');

  Future<Response> getDataFilter([Map<String, dynamic>? query]) async =>
      get('logistik/pembelian/ppn/filter', query);
  Future<Response> cetak([Map<String, dynamic>? query]) async =>
      get('logistik/pembelian/ppn/cetak', query);

  Future<Response> validasiPembPpn(
          Map<String, dynamic> data, String nohide) async =>
      patch('logistik/pembelian/ppn/validasi/bsd/$nohide', data);

  //Jkt

  Future<Response> getDataJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/pembelian/ppn/sudah-validasi', query);
  Future<Response> getBelumValidasiJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/pembelian/ppn/belum-validasi', query);
  Future<Response> getDataNoHideJkt(String? nohide) async =>
      get('logistik-jakarta/pembelian/ppn/$nohide');
  Future<Response> createDataJkt(Map<String, dynamic> data) async =>
      post('logistik-jakarta/pembelian/ppn', data);
  Future<Response> updateDataJkt(
          Map<String, dynamic> data, String nohide) async =>
      patch('logistik-jakarta/pembelian/ppn/$nohide', data);
  Future<Response> deleteDataJkt(String noHide) async =>
      delete('logistik-jakarta/pembelian/ppn/$noHide');

  Future<Response> getDataFilterJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/pembelian/ppn/filter', query);
  Future<Response> cetakJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/pembelian/ppn/cetak', query);
}
