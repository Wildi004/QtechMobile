part of 'api.dart';

class KendaraanLogistikApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/aset/kendaraan', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/aset/kendaraan', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('logistik/aset/kendaraan/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('logistik/aset/kendaraan/$id');

  //jkt

  Future<Response> getDataJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/aset/kendaraan', query);
  Future<Response> createDataJkt(Map<String, dynamic> data) async =>
      post('logistik-jakarta/aset/kendaraan', data.toFormData());
  Future<Response> updateDataJkt(Map<String, dynamic> data, int id) async =>
      put('logistik-jakarta/aset/kendaraan/$id', data);
  Future<Response> deleteDataJkt(int id) async =>
      delete('logistik-jakarta/aset/kendaraan/$id');
}
