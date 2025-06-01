// import 'package:get/get_connect/connect.dart';
// import 'package:qrm/app/data/models/user.dart';

// class UserProvider extends GetConnect {
//   Future<User?> getData(int id) async {
//     final response = await get('user/$id');

//     if (response.status.hasError) {
//       return Future.error(response.statusText!);
//     } else {
//       return User.fromJson(response.body); // ✅ Ubah response ke User
//     }
//   }
// }
