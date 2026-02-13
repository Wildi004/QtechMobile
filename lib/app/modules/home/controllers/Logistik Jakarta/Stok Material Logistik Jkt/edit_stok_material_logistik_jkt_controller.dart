import 'package:get/get.dart' hide Bindings;

import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/stok_material.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class EditStokMaterialLogistikJktController extends GetxController with Apis {
  final forms = LzForm.make([
    'kode_material',
    'jenispekerjaan_id',
    'jenismaterial_id',
    'namamaterial_id',
    'suplier_id',
    'brand',
    'qty',
    'harga_beli',
    'ongkir',
    'harga_modal',
    'total_modal'
  ]);

  StokMaterial? details;

  Future getDetailData(int id) async {
    try {
      Bindings.onRendered(() async {
        Toast.overlay('Loading...', onCancel: () {});

        if (details == null) {
          final res = await api.stokMaterial.getDataDetailJkt(id);
          details = StokMaterial.fromJson(res.data ?? {});
        }

        forms.fill(details!.toJson());

        await getSuppView(details?.suplierId);
        await getJobView(details?.jenispekerjaanId);
        await getMaterialView(details?.jenismaterialId);
        await getNameMaterialView(details?.namamaterialId);

        Toast.dismiss();
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  List<Map<String, dynamic>> supp = [];
  List<Map<String, dynamic>> sups = [];

  Future openSupp() async {
    try {
      if (sups.isEmpty) {
        final res = await api.supplier.getData().ui.loading();
        sups = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      forms.set('suplier_id', '').options(
            sups
                .where((e) => e['nama_perusahaan'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['nama_perusahaan'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future getSuppView(int? id) async {
    final res = await api.supplier.getData();
    supp = List<Map<String, dynamic>>.from(res.data ?? []);

    final option = supp.firstWhere((e) => e['id'] == id, orElse: () => {});

    if (option['id'] != null) {
      forms.set('suplier_id', option['nama_perusahaan']);
      forms.set(
          'suplier_id', Option(option['nama_perusahaan'], value: option['id']));
    }
  }

  Future getJobView(int? id) async {
    final query = {'limit': 'all'};

    final res = await api.jenisPekerjaan.getData(query).ui.loading();
    supp = List<Map<String, dynamic>>.from(res.data ?? []);

    final option = supp.firstWhere((e) => e['id'] == id, orElse: () => {});

    if (option['id'] != null) {
      forms.set('jenispekerjaan_id', option['jenis_pekerjaan']);
      forms.set('jenispekerjaan_id',
          Option(option['jenis_pekerjaan'], value: option['id']));
    }
  }

  Future getMaterialView(int? id) async {
    int? jobID = forms.extra('jenispekerjaan_id');

    final res = await api.jenisPekerjaan.getTypeMaterial(jobID).ui.loading();
    supp = List<Map<String, dynamic>>.from(res.data ?? []);

    final option = supp.firstWhere((e) => e['id'] == id, orElse: () => {});

    if (option['id'] != null) {
      forms.set('jenismaterial_id', option['jenis_material']);
      forms.set('jenismaterial_id',
          Option(option['jenis_material'], value: option['id']));
    }
  }

  Future getNameMaterialView(int? id) async {
    int? mtID = forms.extra('jenismaterial_id'); // ✅ ambil id jenis material

    if (mtID == null) {
      return Toast.show('Jenis material belum dipilih');
    }

    final res = await api.jenisPekerjaan.getNameMaterial(mtID).ui.loading();
    supp = List<Map<String, dynamic>>.from(res.data ?? []);

    final option = supp.firstWhere((e) => e['id'] == id, orElse: () => {});
    if (option['id'] != null) {
      forms.set(
        'namamaterial_id',
        Option(option['nama_material'],
            value: option['id']), // ✅ langsung pakai Option
      );
    }
  }

  // get data jenis pekerjaan
  List<Map> jobs = [];

  Future getJobs() async {
    final query = {'limit': 'all'};

    if (jobs.isEmpty) {
      final res = await api.jenisPekerjaan.getData(query).ui.loading();
      jobs = List<Map>.from(res.data ?? []);
    }

    final options = jobs.labelValue('jenis_pekerjaan', 'id');
    forms.set('jenispekerjaan_id').options(options);
  }

  // get data jenis material
  Map<int, List<Map>> materialTypes = {};

  Future getMaterialTypes() async {
    try {
      int? jobID = forms.extra('jenispekerjaan_id');

      if (jobID == null) {
        return Toast.show('Pilih jenis pekerjaan terlebih dahulu');
      }

      if ((materialTypes[jobID] ?? []).isEmpty) {
        final query = {'limit': 'all'};

        final res =
            await api.jenisPekerjaan.getTypeMaterial(jobID, query).ui.loading();
        materialTypes[jobID] = List<Map>.from(res.data ?? []);
      }

      final options =
          (materialTypes[jobID] ?? []).labelValue('jenis_material', 'id');
      forms.set('jenismaterial_id').options(options);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  // get data material
  Map<int, List<Map>> materials = {};

  Future getMaterials() async {
    try {
      int? mtID = forms.extra('jenismaterial_id');

      if (mtID == null) {
        return Toast.show('Pilih jenis material terlebih dahulu');
      }

      if ((materials[mtID] ?? []).isEmpty) {
        final res = await api.jenisPekerjaan.getNameMaterial(mtID).ui.loading();
        materials[mtID] = List<Map>.from(res.data ?? []);
      }

      final options = (materials[mtID] ?? []).labelValue('nama_material', 'id');
      forms.set('namamaterial_id').options(options);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  int parseNumber(dynamic value) {
    if (value == null) return 0;
    final cleaned = value.toString().replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleaned) ?? 0;
  }

  Future onSubmit([int? id]) async {
    try {
      final required = [
        'kode_material',
        'jenispekerjaan_id',
        'jenismaterial_id',
        'namamaterial_id',
        'suplier_id',
        'qty',
      ];

      logg('[DEBUG] Required fields: $required');

      final form = forms.validate(required: required);
      logg('[DEBUG] Form validate result: ok=${form.ok}, value=${form.value}');

      if (form.ok) {
        final auth = await Auth.user();
        logg('[DEBUG] Auth user: ${auth.toJson()}');

        final payload = form.value;
        logg('[DEBUG] Initial payload: $payload');

        payload['qty'] = parseNumber(payload['qty']);
        payload['harga_beli'] = parseNumber(payload['harga_beli']);
        payload['ongkir'] = parseNumber(payload['ongkir']);
        payload['harga_modal'] = parseNumber(payload['harga_modal']);
        payload['total_modal'] = parseNumber(payload['total_modal']);

        payload['user_id'] = auth.id;
        payload['jenispekerjaan_id'] = forms.extra('jenispekerjaan_id');
        payload['jenismaterial_id'] = forms.extra('jenismaterial_id');
        payload['namamaterial_id'] = forms.extra('namamaterial_id');
        payload['suplier_id'] = forms.extra('suplier_id');

        logg('[DEBUG] Final payload before request: $payload');

        if (id == null) {
          logg('[DEBUG] Mode: CREATE');
          final res = await api.stokMaterial
              .createDataJkt(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        } else {
          logg('[DEBUG] Mode: UPDATE (id=$id)');
          final res = await api.stokMaterial
              .updateDataJkt(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        }
      }
    } catch (e, s) {
      logg('[ERROR] Exception: $e\nStackTrace: $s');
      Errors.check(e, s);
    }
  }
}
