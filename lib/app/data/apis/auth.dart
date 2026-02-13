part of 'api.dart';

class AuthApi extends Fetchly {
  Future<Response> login(Map<String, dynamic> data) async =>
      post('auth/login', data);

  Future<Response> requestOTP(String email) async =>
      post('auth/forgot-password', {'email': email});

  Future<Response> resetPassword(Map<String, dynamic> data) async =>
      post('auth/reset-password', data);

  Future<Response> refreshToken(String token) async =>
      post('auth/refresh', {'refresh_token': token});
}
