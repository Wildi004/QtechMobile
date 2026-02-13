part of 'api.dart';

class ServiceAsetApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/service-aset', query);

  Future<Response> getDataDetail(int id) async =>
      get('logistik/service-aset/$id');

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/service-aset', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async => post(
      'logistik/service-aset/$id', {...data, '_method': 'patch'}.toFormData());
  Future<Response> deleteData(int id) async =>
      delete('logistik/service-aset/$id');

  //jkt

  Future<Response> getDataJkt([Map<String, dynamic>? query]) async =>
      get('logistik-jakarta/service-aset', query);

  Future<Response> getDataDetailJkt(int id) async =>
      get('logistik-jakarta/service-aset/$id');

  Future<Response> createDataJkt(Map<String, dynamic> data) async =>
      post('logistik-jakarta/service-aset', data.toFormData());
  Future<Response> updateDataJkt(Map<String, dynamic> data, int id) async =>
      post('logistik-jakarta/service-aset/$id',
          {...data, '_method': 'patch'}.toFormData());
  Future<Response> deleteDataJkt(int id) async =>
      delete('logistik-jakarta/service-aset/$id');
}
