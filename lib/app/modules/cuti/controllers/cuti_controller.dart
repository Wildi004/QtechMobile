import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/cuti.dart';
import 'package:qrm/app/data/models/user.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class CutiController extends GetxController with Apis {
  final forms = LzForm.make([
    'name',
  ]);
  var sisaCuti = 5.obs;
  Rxn<Cuti> cuti = Rxn<Cuti>();

  var cutiList = [
    {
      "title": "Cuti Healing",
      "isExpanded": false.obs,
      "detail":
          "Cuti 3 Hari\n04 Februari 2025 s/d 06 Februari 2025\nBelum Validasi"
    },
    {"title": "Cuti Keagamaan", "isExpanded": false.obs, "detail": ""},
    {"title": "Cuti Party", "isExpanded": false.obs, "detail": ""}
  ];
  var isFormVisible = false.obs;

  void toggleForm() {
    isFormVisible.value = !isFormVisible.value;
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

  @override
  void onInit() {
    super.onInit();
    getUserLogged();
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
}
