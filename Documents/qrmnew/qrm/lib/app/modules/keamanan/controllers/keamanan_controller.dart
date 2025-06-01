import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/user.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class KeamananController extends GetxController with Apis {
  Rxn<User> user = Rxn<User>();

  Future getProfile() async {
    try {
      final auth = await Auth.user();
      final res = await api.user.getData(auth.id!);
      user.value = User.fromJson(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isLoading = true.obs;
  User user2 = User();

  Future getProfile2() async {
    try {
      isLoading.value = true;
      final auth = await Auth.user();
      final res = await api.user.getData(auth.id!);
      user2 = User.fromJson(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    getProfile();
    getProfile2();
    super.onInit();
  }
}
