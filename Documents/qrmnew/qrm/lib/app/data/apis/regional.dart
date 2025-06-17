part of 'api.dart';

class RegionalApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('regional', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('regional', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      patch('regional/$id', data);
  Future<Response> deleteData(int id) async => delete('regional/$id');

  Future<Response> getUserByRegional(String name) async => get(
        'user/regional/$name',
      );

  Future<Response> getAllRegional(
      {String? regional, String limit = 'all'}) async {
    String url = 'user/regional';

    if (regional != null && regional.isNotEmpty) {
      url += '/$regional';
    }

    url += '?limit=$limit';

    return get(url);
  }
}
