import 'dart:io';
import 'package:get/get.dart' hide Bindings;
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/aset_kantor_hrd.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class EditAsetKantorHrdController extends GetxController with Apis {
  final forms = LzForm.make([
    'kode_aset',
    'nama_aset',
    'jumlah',
    'harga_perolehan',
    'tgl_beli',
    'penanggung_jawab',
    'image',
    'status',
    'status_label'
  ]);
  File? file;
  RxString fileName = ''.obs;
  XFile? fileImage;
  Rxn<AsetKantorHrd> aset = Rxn<AsetKantorHrd>();

  final status = [
    {'id': 0, 'name': 'Tersedia'},
    {'id': 1, 'name': 'Terpakai'},
    {'id': 2, 'name': 'Rusak'},
    {'id': 3, 'name': 'Service'},
    {'id': 4, 'name': 'Hilang'},
  ];

  Future<List<Map>> getStatus() async {
    return status;
  }

  Future getStatusAktif(int? id) async {
    final option = status.firstWhere(
      (e) => e['id'] == id,
      orElse: () => {},
    );

    if (option.isNotEmpty) {
      forms.set('status', option['name']);
      forms.set(
        'status',
        Option(option['name'] as String, value: option['id'] as int),
      );

      return option;
    } else {
      return null;
    }
  }

  AsetKantorHrd? details;
  RxList<FormManager> statusKawinID = RxList<FormManager>();
  List<Map<String, dynamic>> asetKantorHrd = [];
  Future getDetailAset(int id) async {
    try {
      Bindings.onRendered(() async {
        Toast.overlay('Loading...', onCancel: () {});

        if (details == null) {
          final res = await api.asetKantorHrd.getDataDetail(id);
          details = AsetKantorHrd.fromJson(res.data ?? {});
        }

        forms.fill(details!.toJson());

        await getStatusAktif(details?.status);

        Toast.dismiss();
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future onSubmit([int? id]) async {
    try {
      final required = ['*', 'image'];

      if (id != null) {
        required.add('image');
      }

      final form = forms.validate(required: required);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;
        payload['status'] = forms.extra('status');

        payload['user_id'] = auth.id;
        if (file != null) {
          payload['image'] = await api.toFile(file!.path);
        } else {
          payload.remove('image');
        }

        if (id == null) {
          final res = await api.asetKantorHrd
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        } else {
          final res = await api.asetKantorHrd
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
