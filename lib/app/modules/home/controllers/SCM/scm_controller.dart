import 'package:fetchly/utils/log.dart';
import 'package:get/get.dart';
import 'package:qrm_dev/app/data/models/scm/scm_menu.dart';
import 'package:qrm_dev/app/modules/home/controllers/home_controller.dart';

class ScmController extends GetxController {
  final HomeController homeC = Get.find<HomeController>();

  final menus = <ScmMenu>[].obs;

  int get roleId => homeC.user.value?.roleId ?? 0;

  @override
  void onInit() {
    super.onInit();

    logg('🔥 SCM dibuka | roleId current user: $roleId');

    _initMenu();
  }

  void _initMenu() {
    final allMenus = [
      ScmMenu(
        label: 'Arsip',
        icon: 'assets/images/arsip02.png',
        allowedRoles: [],
      ),
      ScmMenu(
        label: 'Data Kontrak',
        icon: 'assets/images/notePen01.png',
        allowedRoles: [1, 117, 118, 120, 121, 123],
      ),
      ScmMenu(
        label: 'Direktur SCM',
        icon: 'assets/images/person01.png',
        allowedRoles: [],
      ),
      ScmMenu(
        label: 'Estimasi dan perencanaan',
        icon: 'assets/images/userGroup01.png',
        allowedRoles: [],
      ),
      ScmMenu(
        label: 'Operasi SCM',
        icon: 'assets/images/electron01.png',
        allowedRoles: [],
      ),
    ];

    menus.value = allMenus.where((menu) {
      if (menu.allowedRoles.isEmpty) return true;
      return menu.allowedRoles.contains(roleId);
    }).toList();
  }
}
