import 'package:qrm/app/data/models/user_login.dart';
import 'package:qrm/app/data/services/storage/storage.dart';

class Auth {
  static Future<UserLogin> user() async {
    return UserLogin.fromJson(storage.read('user') ?? {});
  }
}
