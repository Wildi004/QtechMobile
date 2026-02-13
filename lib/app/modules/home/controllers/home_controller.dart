import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/role_akses/role_akses.dart';
import 'package:qrm_dev/app/data/models/sisa_kasbon.dart';
import 'package:qrm_dev/app/data/models/user.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/routes/app_pages.dart';

class HomeController extends GetxController with Apis {
  var tabInd = 0.obs;
  final ScrollController scrollController = ScrollController();
  RxDouble backgroundHeight = 200.0.obs;
  RxBool isLoading = true.obs;
  RxBool isProductLoading = true.obs;
  Rxn<SisaKasbon> sisaKasbon = Rxn<SisaKasbon>();

  Rxn<User> user = Rxn<User>();
  User user2 = User();
  // var curent = Rxn<CurrentUser>();
  int page = 1;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  RxInt tabIndex = 0.obs;

  Future getUserLogged() async {
    try {
      final auth = await Auth.user();
      final res = await api.user.getData(auth.id!);
      user.value = User.fromJson(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future getDaaSisa() async {
    final auth = await Auth.user();

    try {
      final res = await api.sisaKasbon.getData(auth.id!);
      logg('🔹 Response SisaKasbon: ${res.data}');
      sisaKasbon.value = SisaKasbon.fromJson(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxList<Map<String, dynamic>> menuAkses = <Map<String, dynamic>>[].obs;

  Future<void> getMenuAkses() async {
    final aksesMenu = await storage.read('menu_akses');
    if (aksesMenu != null) {
      final aktifMenu = (aksesMenu as List)
          .where((m) {
            final subMenu = m['menu']?[0]?['sub_menu'] ?? [];
            return subMenu.any((s) => s['is_active'] == 1);
          })
          .toList()
          .cast<Map<String, dynamic>>();

      menuAkses.assignAll(aktifMenu);
      logg('Menu aktif untuk role: ${aktifMenu.length}');
    }
  }

  Future onPageInit() async {
    try {
      isLoading.value = true;

      await Future.wait([
        getMenus(),
        getUserLogged(),
        getDaaSisa(),
        getMenuAkses(),
      ]);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future getCurrent() async {
    try {
      isLoading.value = true;
      final auth = await Auth.user();
      final res = await api.user.getCurrent(auth.id!);
      user.value = User.fromJson(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
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
      await Future.delayed(Duration(seconds: 1));

      await storage.remove('token');
      await storage.remove('user');

      Fetchly.setToken('');
      Toast.dismiss();

      Get.snackbar('Logout', 'Berhasil Logout');
      Get.offAllNamed(Routes.LOGIN);
    } catch (e, s) {
      Toast.dismiss();
      Errors.check(e, s);
    }
  }

  // menus with access roles
  List<RoleAkses> regionalMenus = [];

  Future getMenus() async {
    try {
      final res = await api.roleAkses.getData();
      regionalMenus = RoleAkses.fromJsonList(res.data);
      tabIndex.refresh();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Map<String, dynamic> menuIcons = {
    'Dashboard Umum': 'assets/images/dashboard.png',
    'Anggaran Departemen': 'assets/images/handMoney.png',
    'Monitoring Proyek': 'assets/images/monitorSeo.png',
    'Dashboard': 'assets/images/dashboard.png',
    'Role Access': 'assets/images/keyring.png',
    'User Log': 'assets/images/fileLog.png',
    'Company Profile': 'assets/images/building.png',
    'More': 'assets/images/moreSquare.png',
  };
}
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
// 'menu-1' : Hi.home01 // contoh penggunaan menu icon dengan kode
// Future logout() async {
//   try {
//     Toast.overlay('Memproses...');

//     await Future.delayed(Duration(seconds: 1)); // simulasi proses logout

//     await storage.remove('token');

//     Toast.dismiss();
//     Get.snackbar('Logout', 'Berhasil Logout');

//     Get.offAllNamed(Routes.LOGIN);
//   } catch (e, s) {
//     Toast.dismiss(); // tetap dismiss kalau ada error
//     Errors.check(e, s);
//   }
// }
