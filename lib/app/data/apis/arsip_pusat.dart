part of 'api.dart';

class ArsipPusatApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('arsip/karyawan/regional/pusat', query);

  Future<Response> getDataTimur([Map<String, dynamic>? query]) async =>
      get('arsip/karyawan/regional/barat', query);
}
