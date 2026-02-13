import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/routes/app_pages.dart';

class LoginController extends GetxController with Apis {
  final forms = LzForm.make(['email', 'password']);

  Future onSubmit() async {
    try {
      final form = forms.validate(required: [
        '*'
      ], message: {
        'email': 'Email tidak boleh kosong',
        'password': 'Password tidak boleh kosong',
      });

      if (form.ok) {
        Toast.overlay('Memproses...');
        final res = await api.auth.login(form.value);
        Toast.dismiss();

        if (!res.status) {
          return Toast.error(res.message);
        }

        final data = res.data as Map<String, dynamic>;
        final token = data['token'];
        final refreshToken = data['refresh_token'];
        data.remove('token');

        // ✅ Simpan data login dasar
        await storage.write('refresh_token', refreshToken);
        await storage.write('token', token);
        await storage.write('user', data);
        await storage.write('fingerprint_token', token);
        await storage.write('fingerprint_user', data);
        Fetchly.setToken(token);

        /// ✅ Ambil role akses berdasarkan role_id
        final roleId = data['role_id'];
        if (roleId != null) {
          final aksesRes = await api.aksesMenu.getData({'role_id': roleId});

          if (aksesRes.status && aksesRes.data != null) {
            final aksesMenu = aksesRes.data;

            // Simpan semua menu akses mentahan
            await storage.write('menu_akses', aksesMenu);
            logg('Menu akses disimpan: $aksesMenu');

            // ✅ Filter menu yang aktif berdasarkan struktur data yang benar
            final aktifMenu = aksesMenu.where((m) {
              final sub = m['sub_menu'];
              if (sub is List) {
                return sub.any((s) => s['is_active'] == 1);
              }
              return false;
            }).toList();

            // Simpan menu aktif agar mudah digunakan di dashboard
            await storage.write('menu_aktif', aktifMenu);
            logg('aksesMenu runtimeType: ${aksesMenu.runtimeType}');
            logg('aksesMenu content: $aksesMenu');
            logg('Menu aktif: $aktifMenu');
          } else {
            logg('Gagal ambil menu akses untuk role_id $roleId');
          }
        }

        // ✅ Beri notifikasi dan arahkan ke halaman utama
        Get.snackbar('Login', 'Login Berhasil');
        Get.offAllNamed(Routes.APP);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  // lupa password
  final email = TextEditingController();

  Future<bool> requestOtp() async {
    final res =
        await api.auth.requestOTP(email.text).ui.loading('Memproses...');
    return res.status;
  }

  Future<bool> validateOtp() async {
    final res =
        await api.auth.requestOTP(email.text).ui.loading('Memproses...');
    return res.status;
  }
}

// class LoginController extends GetxController with Apis {
//   final forms = LzForm.make(['email', 'password']);

//   // void login() {
//   //   if (email.value.isNotEmpty && password.value.isNotEmpty) {
//   //     Get.offNamed(Routes.APP);
//   //   } else {
//   //     Get.snackbar('Error', 'Email dan password harus diisi');
//   //   }
//   // }

//   Future onSubmit() async {
//     try {
//       final form = forms.validate(required: [
//         '*'
//       ], message: {
//         'email': 'Email tidak boleh kosong',
//         'password': 'password tidak boleh kosong'
//       });

//       if (form.ok) {
//         Toast.overlay('Memproses...');
//         final res = await api.auth.login(form.value);
//         Toast.dismiss();
//         if (!res.status) {
//           return Toast.error(res.message);
//         }

//         // simpan data token ke lokal storage
//         String token = res.data['token'];
//         storage.write('token', token);
//         storage.write('user', res.data);
//         logg('Login response: ${res.data}');

//         // set token ke fetchly supaya bisa mengakses api lainnya
//         Fetchly.setToken(token);

//         // set message
//         Get.snackbar('Login', 'Login Berhasil');

//         // pergi ke halaman dashboard
//         Get.offAllNamed(Routes.APP);
//       }
//     } catch (e, s) {
//       Errors.check(e, s);
//     }
//   }

//   // lupa password
//   final email = TextEditingController();

//   Future<bool> requestOtp() async {
//     final res =
//         await api.auth.requestOTP(email.text).ui.loading('Memproses...');
//     return res.status;
//   }

//   // validasi kode otp
//   Future<bool> validateOtp() async {
//     final res =
//         await api.auth.requestOTP(email.text).ui.loading('Memproses...');
//     return res.status;
//   }
// }

// import 'package:fetchly/fetchly.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lazyui/lazyui.dart';
// import 'package:qrm_dev/app/core/utils/extensions.dart';
// import 'package:qrm_dev/app/data/apis/api.dart';
// import 'package:qrm_dev/app/data/services/storage/storage.dart';
// import 'package:qrm_dev/app/routes/app_pages.dart';

// class LoginController extends GetxController with Apis {
//   final forms = LzForm.make(['email', 'password']);

//   // void login() {
//   //   if (email.value.isNotEmpty && password.value.isNotEmpty) {
//   //     Get.offNamed(Routes.APP);
//   //   } else {
//   //     Get.snackbar('Error', 'Email dan password harus diisi');
//   //   }
//   // }

//   Future onSubmit() async {
//     try {
//       final form = forms.validate(required: [
//         '*'
//       ], message: {
//         'email': 'Email tidak boleh kosong',
//         'password': 'Password tidak boleh kosong',
//       });

//       if (form.ok) {
//         Toast.overlay('Memproses...');
//         final res = await api.auth.login(form.value);
//         Toast.dismiss();

//         if (!res.status) {
//           return Toast.error(res.message);
//         }

//         // ✅ Pisahkan token dari data
//         final data = res.data as Map<String, dynamic>;
//         String token = data['token'];
//         data.remove('token');
//         await storage.write('token', token);
//         await storage.write('user', data);

//         logg('Login response: $data');
//         Fetchly.setToken(token);

//         Get.snackbar('Login', 'Login Berhasil');
//         Get.offAllNamed(Routes.APP);
//       }
//     } catch (e, s) {
//       Errors.check(e, s);
//     }
//   }

//   // lupa password
//   final email = TextEditingController();

//   Future<bool> requestOtp() async {
//     final res =
//         await api.auth.requestOTP(email.text).ui.loading('Memproses...');
//     return res.status;
//   }

//   Future<bool> validateOtp() async {
//     final res =
//         await api.auth.requestOTP(email.text).ui.loading('Memproses...');
//     return res.status;
//   }
// }

// // class LoginController extends GetxController with Apis {
// //   final forms = LzForm.make(['email', 'password']);

// //   // void login() {
// //   //   if (email.value.isNotEmpty && password.value.isNotEmpty) {
// //   //     Get.offNamed(Routes.APP);
// //   //   } else {
// //   //     Get.snackbar('Error', 'Email dan password harus diisi');
// //   //   }
// //   // }

// //   Future onSubmit() async {
// //     try {
// //       final form = forms.validate(required: [
// //         '*'
// //       ], message: {
// //         'email': 'Email tidak boleh kosong',
// //         'password': 'password tidak boleh kosong'
// //       });

// //       if (form.ok) {
// //         Toast.overlay('Memproses...');
// //         final res = await api.auth.login(form.value);
// //         Toast.dismiss();
// //         if (!res.status) {
// //           return Toast.error(res.message);
// //         }

// //         // simpan data token ke lokal storage
// //         String token = res.data['token'];
// //         storage.write('token', token);
// //         storage.write('user', res.data);
// //         logg('Login response: ${res.data}');

// //         // set token ke fetchly supaya bisa mengakses api lainnya
// //         Fetchly.setToken(token);

// //         // set message
// //         Get.snackbar('Login', 'Login Berhasil');

// //         // pergi ke halaman dashboard
// //         Get.offAllNamed(Routes.APP);
// //       }
// //     } catch (e, s) {
// //       Errors.check(e, s);
// //     }
// //   }

// //   // lupa password
// //   final email = TextEditingController();

// //   Future<bool> requestOtp() async {
// //     final res =
// //         await api.auth.requestOTP(email.text).ui.loading('Memproses...');
// //     return res.status;
// //   }

// //   // validasi kode otp
// //   Future<bool> validateOtp() async {
// //     final res =
// //         await api.auth.requestOTP(email.text).ui.loading('Memproses...');
// //     return res.status;
// //   }
// // }
// void login() {
//   if (email.value.isNotEmpty && password.value.isNotEmpty) {
//     Get.offNamed(Routes.APP);
//   } else {
//     Get.snackbar('Error', 'Email dan password harus diisi');
//   }
// }
