part of 'api.dart';

class AsetKantorHrdApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('hrd/aset/kantor', query);
  Future<Response> getDataDetail(int id) async => get('hrd/aset/kantor/$id');
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('hrd/aset/kantor', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      post('hrd/aset/kantor/$id', {...data, '_method': 'patch'}.toFormData());
  Future<Response> deleteData(int id) async => delete('hrd/aset/kantor/$id');
}
