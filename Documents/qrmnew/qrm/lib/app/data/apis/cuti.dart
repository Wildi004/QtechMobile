part of 'api.dart';

class CutiApi extends Fetchly {
  Future<Response> getDataCuti(int id) async => get(
        'cuti/user/$id',
      );

  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('cuti', query);

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('cuti', data);

  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      patch('cuti/$id', data);

  Future<Response> deleteData(int id) async => delete('cuti/$id');
}
