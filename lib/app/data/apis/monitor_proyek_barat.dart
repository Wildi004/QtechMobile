part of 'api.dart';

class MonitorProyekBaratApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/monitoring-material-proyek/barat', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/monitoring-material-proyek/barat', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('logistik/monitoring-material-proyek/barat/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('logistik/monitoring-material-proyek/barat/$id');

  // timur

  Future<Response> getDataTimur([Map<String, dynamic>? query]) async =>
      get('logistik/monitoring-material-proyek/timur', query);
}
