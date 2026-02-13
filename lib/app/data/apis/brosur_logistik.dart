part of 'api.dart';

class BrosurLogistikApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('brosur-logistik', query);

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('brosur-logistik', data.toFormData());

  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      post('brosur-logistik/$id', {...data, '_method': 'patch'}.toFormData());

  Future<Response> deleteBrosur(int id) async => delete('brosur-logistik/$id');
}
