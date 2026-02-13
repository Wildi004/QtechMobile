part of 'api.dart';

class UserApi extends Fetchly {
  Future<Response> getData(int id) async => get('user/$id');
  Future<Response> getCurrent(int id) async => get(
        'user/$id',
      );
  Future<Response> getDataUser([Map<String, dynamic>? query]) async =>
      get('user', query);
  Future<Response> getListUser() async => get('user');

  Future<Response> getPageUser({int page = 1, String limit = 'all'}) async {
    final url = 'user?page=$page&limit=$limit';
    return get(url);
  }

  Future<Response> current(Map<String, dynamic> data) async =>
      patch('user/current', data);

  Future<Response> createUser(Map<String, dynamic> data) async =>
      post('user', data);

  Future<Response> updateProfile(Map<String, dynamic> data) async =>
      patch('user/current', data);

  Future<Response> deleteUser(int id) async => delete('user/$id');
  Future<Response> updatePassword(Map<String, dynamic> data) =>
      patch('user/current/change-password', data);

  Future<Response> updatePhoto(Map<String, dynamic> data, int id) =>
      post('user/$id?_method=PATCH', data.toFormData());

  Future<Response> getDataCetak([Map<String, dynamic>? query]) async =>
      get('karyawan/tetap/cetak', query);
}
