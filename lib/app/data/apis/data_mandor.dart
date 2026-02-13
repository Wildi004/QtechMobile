part of 'api.dart';

class DataMandorApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('data-mandor', query);
  Future<Response> deletes(int id) async => delete('data-mandor/$id');

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('data-mandor', data);

  Future<Response> updateData(
          Map<String, dynamic> data, String resourceId) async =>
      post('data-mandor/$resourceId',
          {...data, '_method': 'patch'}.toFormData());
}
