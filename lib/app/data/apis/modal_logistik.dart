part of 'api.dart';

class ModalLogistikApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('harga-modal/logistik', query);

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('harga-modal/logistik', data.toFormData());
  Future<Response> getDataDetail(int id) async =>
      get('harga-modal/logistik/$id');
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      patch('harga-modal/logistik/$id', data);

  Future<Response> deleteData(int id) async =>
      delete('harga-modal/logistik/$id');
}
