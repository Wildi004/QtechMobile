// lib/data/menu_repository.dart

import 'package:qrm_dev/app/data/menu%20data/menu_data.dart';

class MenuRepository {
  List<Map<String, dynamic>> getDefaultFavorites() {
    return MenuData.defaultFavorites;
  }

  List<Map<String, dynamic>> getOtherMenus() {
    return MenuData.otherMenus;
  }
}
