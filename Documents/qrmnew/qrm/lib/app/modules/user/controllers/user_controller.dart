import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/user.dart';

class UserController extends GetxController with Apis {
  RxBool isLoading = true.obs;
  List<User> users = [];

  Future getListUser() async {
    try {
      isLoading.value = true;
      final res = await api.user.getListUser();
      users = User.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteUser(int id) async {
    try {
      final res = await api.user.deleteUser(id).ui.loading('Menghapus data...');

      if (!res.status) {
        return Toast.error(res.message);
      }

      users.removeWhere((e) => e.id == id);
      isLoading.refresh();

      Toast.success('Data berhasil dihapus');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    getListUser();
    super.onInit();
  }
}
