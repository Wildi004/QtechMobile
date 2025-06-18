part of 'api.dart';

class KasbonApi extends Fetchly {
  Future<Response> getDataKasbon(int userId) async => get(
        'kasbon/user/$userId',
      );
}
