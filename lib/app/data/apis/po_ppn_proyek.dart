part of 'api.dart';

class PoPpnProyekApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('path', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteData(int id) async => delete('path/$id');

  Future<Response> getDataFilter([Map<String, dynamic>? query]) async =>
      get('logistik/po-ppn/filter/proyek', query);
  Future<Response> cetak([Map<String, dynamic>? query]) async =>
      get('logistik/po-ppn/cetak', query);
}
