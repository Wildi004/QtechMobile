part of 'api.dart';

class PembNonPpnApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/pembelian/non-ppn/sudah-validasi', query);
  Future<Response> getBelumValidasi([Map<String, dynamic>? query]) async =>
      get('logistik/pembelian/non-ppn/belum-validasi', query);
  Future<Response> getDataNoHide(String? nohide) async =>
      get('logistik/pembelian/non-ppn/$nohide');
  Future<Response> createData() async => post('logistik/pembelian/non-ppn');
  Future<Response> updateData(Map<String, dynamic> data, String nohide) async =>
      patch('logistik/pembelian/non-ppn/$nohide', data);
  Future<Response> deleteData(String noHide) async =>
      delete('logistik/pembelian/non-ppn/$noHide');

  Future<Response> getDataFilter([Map<String, dynamic>? query]) async =>
      get('logistik/pembelian/non-ppn/filter', query);
  Future<Response> cetak([Map<String, dynamic>? query]) async =>
      get('logistik/pembelian/non-ppn/cetak', query);

  //Jkt

  Future<Response> getDatajkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/pembelian/non-ppn/sudah-validasi', query);
  Future<Response> getBelumValidasijkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/pembelian/non-ppn/belum-validasi', query);
  Future<Response> getDataNoHidejkt(String? nohide) async =>
      get('logistik-jakarta/pembelian/non-ppn/$nohide');
  Future<Response> createDatajkt() async =>
      post('logistik-jakarta/pembelian/non-ppn');
  Future<Response> updateDatajkt(
          Map<String, dynamic> data, String nohide) async =>
      patch('logistik-jakarta/pembelian/non-ppn/$nohide', data);
  Future<Response> deleteDatajkt(String noHide) async =>
      delete('logistik-jakarta/pembelian/non-ppn/$noHide');

  Future<Response> getDataFilterjkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/pembelian/non-ppn/filter', query);
  Future<Response> cetakjkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/pembelian/non-ppn/cetak', query);
}
