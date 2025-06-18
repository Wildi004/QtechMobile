import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/user.dart';
import 'package:qrm/app/data/services/storage/auth.dart';
import 'package:qrm/app/data/services/storage/storage.dart';
import 'package:qrm/app/routes/app_pages.dart';

class HomeController extends GetxController with Apis {
  var tabInd = 0.obs;
  final ScrollController scrollController = ScrollController();
  RxDouble backgroundHeight = 200.0.obs;
  RxBool isLoading = true.obs;
  RxBool isProductLoading = true.obs;

  Rxn<User> user = Rxn<User>();
  User user2 = User();
  // var curent = Rxn<CurrentUser>();
  int page = 1;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  RxInt tabIndex = 0.obs;
  var items = <Map<String, dynamic>>[
    {
      'title': 'Sabtu Belajar !',
      'date': 'Sabtu, 4 Januari 2025',
      'location': 'Ruang Rapat LT.3 - Kantor',
    },
    {
      'title': 'Rapat Direksi !',
      'date': 'Sabtu, 4 Januari 2025',
      'location': "Q'offee Shop - Diponegoro",
    },
    {
      'title': 'Sabtu Ceria !',
      'date': 'Sabtu, Januari 2025',
      'location': 'Kuala Lumpur - Malaysia',
    },
  ].obs;

  Future getUserLogged() async {
    try {
      final auth = await Auth.user();
      final res = await api.user.getData(auth.id!);
      logg('ini logg untuk home data $res');
      user.value = User.fromJson(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future onPageInit() async {
    try {
      await getUserLogged();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  // Future getCurrent() async {
  //   try {
  //     isLoading.value = true;
  //     final auth = await Auth.user();
  //     final res = await api.user.getCurrent(auth.id!);
  //     print('data currnt $res');
  //   } catch (e, s) {
  //     Errors.check(e, s);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
// Future getUser() async{
//   try{
//     isLoading.value= true;
//   final res = await api.user.getCurrent(query);
//   print('user data $res');
//   users = User.fromJsonList(res.data);
//   }catch(e, s){
//     Errors.check(e, s);
//   }finally{
//     isLoading.value= false;
//   }
// }

  @override
  void onInit() {
    // getUser();
    // getCurrent();
    getUserLogged();
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();

      if (scrollController.hasClients) {
        scrollController.animateTo(
          140 * 1,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void onClose() {
    //  print('Token di HomeController: ${storage.read('token')}');
    scrollController.dispose();
    super.onClose();
  }

  get tabs => null;

  get menus => null;

  void onScroll(Scroller scroll) {
    double pixel = scroll.pixels;

    if (pixel < 0) {
      backgroundHeight.value = 200 + pixel.abs();
    } else {
      backgroundHeight.value = (200 - pixel.abs()).clamp(0, 200);
    }
  }

  Future logout() async {
    try {
      Toast.overlay('Memproses...');

      await Future.delayed(Duration(seconds: 1)); // simulasi proses logout

      await storage.remove('token');

      Toast.dismiss();
      Get.snackbar('Logout', 'Berhasil Logout');

      Get.offAllNamed(Routes.LOGIN);
    } catch (e, s) {
      Toast.dismiss(); // tetap dismiss kalau ada error
      Errors.check(e, s);
    }
  }
}
