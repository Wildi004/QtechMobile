part of 'api.dart';

class MonitorByKpApi extends Fetchly {
  Future<Response> getDataByKP(String? kodeProyek) async =>
      get('logistik/monitoring-material-proyek/barat/detail/$kodeProyek');
  Future<Response> getDataByKPTimur(String? kodeProyek) async =>
      get('logistik/monitoring-material-proyek/timur/detail/$kodeProyek');
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteData(int id) async => delete('path/$id');
}
