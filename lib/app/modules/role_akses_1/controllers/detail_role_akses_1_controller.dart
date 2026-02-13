import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/menu_akses.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class DetailRoleAkses1Controller extends GetxController with Apis {
  final forms = LzForm.make([
    'role',
  ]);
  var selectedIndex = (-1).obs;
  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;
  final formDetails = <FormManager>[].obs;
  RxMap<int, bool> checkState = <int, bool>{}.obs;
  int roleId = 0;
  Set<int> activeMenuIds = {};

  List<MenuAkses> listData = [];
  RxList<MenuAkses> data = <MenuAkses>[].obs;
  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getRoleAccess() async {
    try {
      final res = await api.roleAkses1.getDataId(roleId);

      final role = res.data;

      if (role == null) {
        activeMenuIds.clear();
        return;
      }

      final List accessMenus = role['access_menus'] ?? [];

      activeMenuIds = accessMenus.map<int>((e) => e['menu_id'] as int).toSet();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future getData() async {
    try {
      final query = {'limit': 'all'};
      ListItemAnimasi.animatedItems.clear();

      page = 1;
      isLoading.value = true;

      final res = await api.menuAkses.getData(query);
      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = MenuAkses.fromJsonList(res.data);

      /// 🔥 AUTO CHECK BERDASARKAN ACCESS MENU
      for (var menu in listData) {
        checkState[menu.id!] = activeMenuIds.contains(menu.id);
      }
      data.value = listData;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future onSubmit([int? id]) async {
    try {
      final required = ['*',];
     

      final form = forms.validate(required: required);

      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;
        payload['user_id'] = auth.id;
        if (id == null) {
          final res = await api.daftarTkdn
              .createData(payload)
              .ui
              .loading('Menambahkan...');

          if (res.status) {
            Get.back(result: res.data);
            Toast.success('Berhasil menambahkan data  ');
          }
        } else {
          final res = await api.daftarTkdn
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
            Toast.success('Berhasil memperbarui data');
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future deleteData(int id) async {
    try {
      final res = await api.menuAkses.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listData.removeWhere((e) => e.id == id);
      isLoading.refresh();
      Get.snackbar('Berhasil', res.message ?? '');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void insertData(MenuAkses data) {
    listData.insert(0, data);
    isLoading.refresh();
  }

  RxBool isSearching = false.obs;
  RxBool isPaginateSearch = false.obs;
  String keyword = '';
  TextEditingController searchC = TextEditingController();

  Future updateSearchQuery(String value) async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.menuAkses.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = MenuAkses.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future onPageInit() async {
    try {
      await getData();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();
    roleId = Get.arguments ?? 0;
    initPage();
  }

  Future initPage() async {
    await getRoleAccess(); // ambil akses role dulu
    await getData(); // lalu ambil semua menu
  }

  void updateData(MenuAkses data, int id) {
    int index = listData.indexWhere((e) => e.id == id);
    if (index >= 0) {
      listData[index] = data;
      isLoading.refresh();
    }
  }

   
}
