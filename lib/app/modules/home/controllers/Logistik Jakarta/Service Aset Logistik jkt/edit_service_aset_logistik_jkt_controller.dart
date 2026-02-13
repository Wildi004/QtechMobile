import 'dart:io';

import 'package:get/get.dart' hide Bindings;

import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/service_aset/service_aset.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class EditServiceAsetLogistikController extends GetxController with Apis {
  final forms = LzForm.make([
    'aset_id',
    'jenis_aset',
    'tgl_service',
    'tempat_service',
    'biaya',
    'keterangan',
    'diservice_oleh',
    'nota',
  ]);

  File? file;
  RxString fileName = ''.obs;
  XFile? fileImage;
  Rxn<ServiceAset> aset = Rxn<ServiceAset>();
  ServiceAset? details;

  Future getDetailData(int id) async {
    try {
      Bindings.onRendered(() async {
        Toast.overlay('Loading...', onCancel: () {});

        if (details == null) {
          final res = await api.serviceAset.getDataDetail(id);
          details = ServiceAset.fromJson(res.data ?? {});
        }

        forms.fill(details!.toJson());

        await getKendaraan(details?.asetId);
        await getKantor(details?.asetId);
        await getUser(details?.diserviceOleh);

        Toast.dismiss();
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  List<Map<String, dynamic>> asets = [];
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> aset1 = [];
  List<Map<String, dynamic>> kantor = [];
  List<Map<String, dynamic>> users1 = [];

  Future getKendaraan(int? id) async {
    final query = {'limit': 'all'};
    final res = await api.kendaraanLogistik.getData(query);
    aset1 = List<Map<String, dynamic>>.from(res.data ?? []);

    final option = aset1.firstWhere((e) => e['id'] == id, orElse: () => {});

    if (option['id'] != null) {
      forms.set('aset_id', option['nama_aset']);
      forms.set('aset_id', Option(option['nama_aset'], value: option['id']));
    }
  }

  Future getKantor(int? id) async {
    final query = {'limit': 'all'};
    final res = await api.asetKantorHrd.getData(query);
    kantor = List<Map<String, dynamic>>.from(res.data ?? []);

    final option = kantor.firstWhere((e) => e['id'] == id, orElse: () => {});

    if (option['id'] != null) {
      forms.set('aset_id', option['nama_aset']);
      forms.set('aset_id', Option(option['nama_aset'], value: option['id']));
    }
  }

  Future getUser(int? id) async {
    final query = {'limit': 'all'};
    final res = await api.user.getDataUser(query);
    kantor = List<Map<String, dynamic>>.from(res.data ?? []);

    final option = kantor.firstWhere((e) => e['id'] == id, orElse: () => {});

    if (option['id'] != null) {
      forms.set('diservice_oleh', option['name']);
      forms.set('diservice_oleh', Option(option['name'], value: option['id']));
    }
  }

  Future openAset() async {
    final jenis = forms.get('jenis_aset');
    final query = {'limit': 'all'};

    try {
      if (asets.isEmpty) {
        final res = jenis == 'AsetKendaraan'
            ? await api.kendaraanLogistik.getData(query).ui.loading()
            : await api.asetKantorHrd.getData(query).ui.loading();

        asets = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      forms.set('aset_id', '').options(
            asets
                .where((e) => e['nama_aset'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['nama_aset'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future openUser() async {
    final query = {'limit': 'all', 'order_dir': 'asc'};
    try {
      if (users.isEmpty) {
        final res = await api.user.getDataUser(query).ui.loading();
        users = List<Map<String, dynamic>>.from(res.data ?? []);
      }
      forms.set('diservice_oleh', '').options(
            users
                .where((e) => e['name'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['name'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future onSubmit([int? id]) async {
    try {
      logg('🔹 onSubmit() called, id = $id');

      final required = ['*', 'image'];

      logg('🔹 Required fields: $required');

      final form = forms.validate(required: required);
      logg('✅ Form validation result: ok = ${form.ok}, value = ${form.value}');

      if (form.ok) {
        final auth = await Auth.user();
        logg('🔹 Auth user loaded: ${auth.toJson()}');

        final payload = form.value;
        payload['aset_id'] = forms.extra('aset_id');
        payload['user_id'] = auth.id;
        payload['diservice_oleh'] = forms.extra('diservice_oleh');
        payload['biaya'] = (forms.get('biaya') ?? '0').numeric;

        logg('🔹 Initial payload: $payload');

        if (file != null) {
          logg('📂 File selected: ${file!.path}');
          payload['nota'] = await api.toFile(file!.path);
        } else {
          logg('⚠️ No file selected, removing nota from payload');
          payload.remove('nota');
        }

        logg('✅ Final payload ready: $payload');

        if (id == null) {
          logg('➡️ Creating new data...');
          final res = await api.serviceAset
              .createData(payload)
              .ui
              .loading('Menambahkan...');

          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        } else {
          logg('➡️ Updating data with ID: $id...');
          final res = await api.serviceAset
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');

          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        }
      } else {
        logg('❌ Form validation failed. Errors: ${form.error}');
      }
    } catch (e, s) {
      logg('🔥 ERROR onSubmit: $e');
      logg('🔥 STACKTRACE: $s');
      Errors.check(e, s);
    }
  }
}
