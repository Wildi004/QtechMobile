import 'package:get/get.dart' hide Bindings;
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/hrd_cuti.dart';
import 'package:qrm_dev/app/data/models/user.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class FormCutiController extends GetxController with Apis {
  final forms = LzForm.make([
    'name',
    'perihal',
    'tgl_cuti',
    'cuti_from',
    'cuti_to',
    'keterangan',
    'dept',
    'no_ktp',
    'role'
  ]);

  Rxn<HrdCuti> aset = Rxn<HrdCuti>();
  RxBool isLoading = true.obs;
  Rxn<User> user = Rxn<User>();

  Future getUserData() async {
    try {
      isLoading.value = true;

      Toast.overlay('Loading...');
      final auth = await Auth.user();
      logg("Mengambil data user dengan ID: ${auth.id}");

      final res = await api.user.getCurrent(auth.id!);
      user.value = User.fromJson(res.data);
      Toast.dismiss();

      if (res.data == null) {
        logg("Data user tidak ditemukan!");
        return;
      }

      final data = User.fromJson(res.data);
      logg("Data user ditemukan: ${data.name}");

      forms.fill({
        'no_ktp': data.noKtp,
        'name': data.name,
        'dept': data.dept,
        'role': data.role,
      });
    } catch (e, s) {
      Toast.dismiss();
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future onSubmit([int? id]) async {
    try {
      final required = [
        '*',
      ];

      final form = forms.validate(required: required);

      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;

        if (id == null) {
          final res = await api.hrdCuti
              .createPengajuanCuti(payload)
              .ui
              .loading('Menambahkan...');

          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          } else {
            String errorMessage = '';

            if (res.message is Map) {
              final map = res.message as Map;
              errorMessage = map.values.expand((e) => e).join('\n');
            } else {
              errorMessage = res.message.toString();
            }

            Get.snackbar('Error', errorMessage);
          }
        } else {}
      } else {}
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    Bindings.onRendered(() {
      forms.set(
        'tgl_cuti',
        DateTime.now().format('yyyy-MM-dd'),
      );

      getUserData();
    });
    super.onInit();
  }
}
