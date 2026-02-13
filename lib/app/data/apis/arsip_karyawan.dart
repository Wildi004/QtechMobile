part of 'api.dart';

class ArsipKaryawanApi extends Fetchly {
  Future<Response> getData({String? regional}) async {
    return get('arsip/karyawan', {'regional': regional});
  }
}
