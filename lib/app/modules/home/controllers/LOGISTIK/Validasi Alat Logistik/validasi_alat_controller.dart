import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/validasi_alat/validasi_alat.dart';

class ValidasiAlatController extends GetxController with Apis {
  ValidasiAlat? data;
  final isFilled = false.obs;
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;
  final forms = LzForm.make([
    'trans_kode',
    'alat_id',
    'from_date',
    'to_date',
    'lama_hari',
    'status_pm',
    'validasi_pm',
    'pm',
    'status_logistik',
    'validasi_logistik',
    'status_gm_regional',
    'validasi_gm',
    'no_pengajuan',
    'tgl_pengajuan',
    'kode_proyek',
    'uraian_pekerjaan',
    'spv',
    'detail_proyek_item',
    'alat',
    'kode_alat',

    //alat
    'type',
    'nama_alat',
    'jumlah',
    'harga_satuan',
    'harga_perolehan',
    'status',
    'keterangan',
    'tgl_beli',
    'reg_id',
    'dep_id',
    'proyek_item_id',
    'kantor',
    'image',
    'pm',
    'created_at',
    'qr_code',
    'tgl_service',
    'regional_name',
    'departemen_name',
    'proyek_name',
    'created_by_name',
    'pm_name',
  ]);
  RxBool isLoading = true.obs;
  var isExpanded = false.obs;
  RxList<FormManager> formRabs = RxList([]);

  List<ValidasiAlat> listData = [];
  RxList<ValidasiAlat> datas = <ValidasiAlat>[].obs;
  RxList<ValidasiAlat> datapo = <ValidasiAlat>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final id = Get.parameters['id'];

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.validasiAlat.getData(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listData = ValidasiAlat.fromJsonList(res.data);

      datas.value = listData;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onSubmit() async {
    try {} catch (e, s) {
      Toast.dismiss();
      Errors.check(e, s);
    }
  }

  RxBool isSearching = false.obs;
  RxBool isPaginateSearch = false.obs;
  String keyword = '';
  TextEditingController searchC = TextEditingController();

  Future updateSearchQuery(String value) async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.validasiAlat.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = ValidasiAlat.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void insertData(ValidasiAlat data) {
    try {
      final controller = Get.find<ValidasiAlatController>();
      controller.datas.insert(0, data);
      controller.isLoading.refresh();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listData.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res =
          await api.validasiAlat.getData({...query, 'search': searchC.text});
      final data = ValidasiAlat.fromJsonList(res.data);
      listData.addAll(data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      Utils.timer(() {
        isPaginate.value = false;
        isLoading.refresh();
      }, 1.s);
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
    if (data != null) {
      forms.fill(data!.toJson());
    }
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }
}
