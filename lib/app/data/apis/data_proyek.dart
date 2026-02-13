part of 'api.dart';

class DataProyekApi extends Fetchly {
  Future<Response> getDataProyek([Map<String, dynamic>? query]) async =>
      get('data-proyek/timur', query);

  Future<Response> getDataBarat([Map<String, dynamic>? query]) async =>
      get('data-proyek/timur/item', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('data-proyek/timur', data.toFormData());

  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      post('data-proyek/timur/$id', data.toFormData());

  Future<Response> deletetdkn(int id) async => delete('data-proyek/timur/$id');

  Future<Response> getProyekTimurAll({String limit = 'all'}) {
    return get('data-proyek/timur?limit=$limit');
  }

  //Barat
  Future<Response> getProyekBaratAll({String limit = 'all'}) {
    return get('data-proyek/barat?limit=$limit');
  }
}
