import 'package:get/get.dart' hide Bindings;
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/user.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class FormProfileController extends GetxController with Apis {
  var imagePath = ''.obs;
  RxBool isLoading = true.obs;

  Rxn<User> user = Rxn<User>();
  final forms = LzForm.make([
    'id',
    'no_ktp',
    'email',
    'name',
    'no_telp',
    'alamat_ktp',
    'tempat_lahir',
    'tgl_lahir',
    'agama',
    'gender',
  ]);

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        imagePath.value = pickedFile.path;
        await uploadProfileImage(pickedFile);
      }
    } catch (e) {
      logg("Error saat memilih gambar: $e");
    }
  }

  Future<void> uploadProfileImage(XFile imageFile) async {
    try {
      final auth = await Auth.user();

      final image = await api.toFile(imageFile.path);
      final payload = {'image': image};

      final res = await api.user
          .updatePhoto(payload, auth.id!)
          .ui
          .loading('Update foto...');

      if (res.status) {
        Toast.success('Foto profil berhasil diperbarui.');
      }
    } catch (e, s) {
      Toast.dismiss();
      logg("Error saat mengunggah foto: $e");
      Errors.check(e, s);
    }
  }

  Future onSubmit() async {
    try {
      final form = forms.validate(required: ['email']);

      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;
        payload['id'] = auth.id;

        Toast.overlay('Memperbarui...', onCancel: () => {});
        logg("Mengirim data ke API: $payload");

        final res = await api.user.updateProfile(payload);

        logg("Respons API: ${res.status}, ${res.message}");

        Toast.dismiss();

        if (!res.status) {
          Toast.error(res.message);
          return;
        }

        Toast.success('Data profile berhasil diperbarui.');
      }
    } catch (e, s) {
      Toast.dismiss();
      logg("Error saat mengupdate profile: $e");
      Errors.check(e, s);
    }
  }

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
        'id': data.noInduk,
        'no_ktp': data.noKtp,
        'email': data.email,
        'name': data.name,
        'no_telp': data.noTelp,
        'alamat_ktp': data.alamatKtp,
        'tempat_lahir': data.tempatLahir,
        'tgl_lahir': data.tglLahir,
        'agama': data.agama,
        'gender': data.gender
      });
    } catch (e, s) {
      Toast.dismiss();
      logg("Error saat mengambil data user: $e");
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future onPageInit() async {
    try {
      await getUserData();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    Bindings.onRendered(() {
      getUserData();
    });
    super.onInit();
  }
}
