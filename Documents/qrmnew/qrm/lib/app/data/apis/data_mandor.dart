part of 'api.dart';

class DataMandorApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('data-mandor', query);
  Future<Response> deletes(int id) async => delete('data-mandor/$id');
}
