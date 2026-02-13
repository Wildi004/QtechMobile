part of 'api.dart';

class JenisPekerjaanApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('proyek/timur/sem/settings/jenis-pekerjaan', query);

  Future<Response> getTypeMaterial(int? jobID,
          [Map<String, dynamic>? query]) async =>
      get('proyek/timur/sem/settings/jenis-material/pekerjaan/$jobID', query);

  Future<Response> getNameMaterial(int? mtID) async =>
      get('proyek/timur/sem/settings/nama-material/material/$mtID');
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('path', data);
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      put('path/$id', data);
  Future<Response> deleteData(int id) async => delete('path/$id');
}
