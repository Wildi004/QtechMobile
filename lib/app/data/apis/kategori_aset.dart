part of 'api.dart';

class KategoriAsetApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('logistik/settings/kategori-aset', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('logistik/settings/kategori-aset', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      patch('logistik/settings/kategori-aset/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('logistik/settings/kategori-aset/$id');
}
