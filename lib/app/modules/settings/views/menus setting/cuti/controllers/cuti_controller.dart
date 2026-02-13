import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/cuti.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/hrd_cuti.dart';
import 'package:qrm_dev/app/data/models/user.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class CutiController extends GetxController with Apis {
  final forms = LzForm.make([
    'id',
    'user_id',
    'dep_id',
    'tgl_cuti',
    'perihal',
    'keterangan',
    'cuti_from',
    'cuti_to',
    'lama_cuti',
    'status_hrd',
    'approval',
    'status_dir_keuangan',
    'aprroved_by',
    'created_at',
    'user_name',
    'approval_name',
    'aprroved_by_name',
    'departemen',
  ]);

  var sisaCuti = 5.obs;
  Rxn<Cuti> cuti = Rxn<Cuti>();
  List<HrdCuti> listCuti = [];
  RxBool isLoading = true.obs;
  int page = 1, total = 0;
  RxList<HrdCuti> listCutiObs = <HrdCuti>[].obs;

  Future getData() async {
    try {
      ListItemAnimasi.animatedItems.clear();
      final auth = await Auth.user();

      page = 1;
      isLoading.value = true;

      final res = await api.hrdCuti.getSudahId(auth.id!);

      final rawData = res.data;

      if (rawData == null) {
        listCutiObs.clear();
        return;
      }

      if (rawData is List) {
        listCuti = HrdCuti.fromJsonList(rawData);
      } else if (rawData is Map<String, dynamic>) {
        // API balikin 1 data → bungkus jadi list
        listCuti = [HrdCuti.fromJson(rawData)];
      } else {
        listCuti = [];
      }

      listCutiObs.value = listCuti;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future getUserLogged() async {
    try {
      final auth = await Auth.user();
      final res = await api.user.getData(auth.id!);
      final data = User.fromJson(res.data);
      forms.fill({
        'name': data.name,
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future getDataCuti() async {
    try {
      final auth = await Auth.user();
      final res = await api.cuti.getDataCuti(auth.id!);
      cuti.value = Cuti.fromJson(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  var selectedDateDari = "".obs;
  var selectedDateSampai = "".obs;

  TextEditingController dariController = TextEditingController();
  TextEditingController sampaiController = TextEditingController();

  Future<void> selectDate(BuildContext context, bool isDari) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      String formattedDate = "${picked.day}-${picked.month}-${picked.year}";

      if (isDari) {
        selectedDateDari.value = formattedDate;
        dariController.text = formattedDate;
      } else {
        selectedDateSampai.value = formattedDate;
        sampaiController.text = formattedDate;
      }
    }
  }

  void insertData(HrdCuti data) {
    listCuti.insert(0, data);
    isLoading.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    getUserLogged();
    getData();
    getDataCuti();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  Future onPageInit() async {
    try {
      await getUserLogged();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listCutiObs.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final auth = await Auth.user();
      final res = await api.hrdCuti.getSudahId(auth.id!);
      final data = HrdCuti.fromJsonList(res.data);
      listCutiObs.addAll(data);
      final rawData = res.data;

      if (rawData is List) {
        listCutiObs.addAll(HrdCuti.fromJsonList(rawData));
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      Utils.timer(() {
        isPaginate.value = false;
        isLoading.refresh();
      }, 1.s);
    }
  }
}
