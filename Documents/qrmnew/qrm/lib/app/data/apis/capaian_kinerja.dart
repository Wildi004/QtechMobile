part of 'api.dart';

class CapaianKinerjaApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('capaian-kerja/it', query);
}
