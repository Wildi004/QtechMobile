part of 'api.dart';

class SuratMasukApi extends Fetchly {
  Future<Response> getData(String depId, [Map<String, dynamic>? query]) async =>
      get('surat/masuk/departemen/$depId', query);

  Future<Response> getSuratKeluar([Map<String, dynamic>? query]) async =>
      get('surat/keluar', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('surat/keluar/departemen', data.toFormData());
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      post('surat/keluar/departemen/$id', data);
  Future<Response> deleteData(int id) async =>
      delete('surat/masuk/departemen/$id');

  Future<Response> sendData(Map<String, dynamic> data) async =>
      post('surat/keluar', data.toFormData());
}
