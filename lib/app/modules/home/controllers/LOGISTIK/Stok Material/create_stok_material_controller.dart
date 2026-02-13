import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class CreateStokMaterialController extends GetxController with Apis {
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
    'total_modal',
  ]);

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
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        } else {
          logg('[DEBUG] Mode: UPDATE (id=$id)');
          final res = await api.stokMaterial
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
      logg('[ERROR] Exception: $e\nStackTrace: $s');
      Errors.check(e, s);
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

  List<Map<String, dynamic>> supp = [];

  Future openSupp() async {
    // final query = {'limit': 'all'};

    try {
      if (supp.isEmpty) {
        final res = await api.supplier.getData().ui.loading();
        supp = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      forms.set('suplier_id', '').options(
            supp
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
}
