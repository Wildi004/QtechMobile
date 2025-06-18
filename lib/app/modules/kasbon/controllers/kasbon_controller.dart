import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/kasbon.dart';
import 'package:qrm/app/data/models/user.dart';
import 'package:qrm/app/data/services/storage/auth.dart';
import 'package:qrm/app/modules/kasbon/views/models/models.dart';

class KasbonController extends GetxController with Apis {
  Rx<TextEditingController> nominalController = TextEditingController().obs;
  Rx<TextEditingController> keteranganController = TextEditingController().obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Rxn<User> user = Rxn<User>();
  Rxn<Kasbon> dataKas = Rxn<Kasbon>();

  RxDouble height = 140.0.obs;
  var showDetails = false.obs;
  var kasbonList = <Kasbon1>[].obs;

  void addKasbon(Kasbon1 kasbon) {
    kasbonList.add(kasbon);
  }

  void adjustHeader(double value) {
    height.value = value;
  }

  Future<void> refreshData() async {
    await Future.delayed(Duration(seconds: 1));

    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        "Berhasil",
        "Data telah direfresh",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color.fromARGB(255, 82, 33, 44),
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    }
  }

  Future getUserLogged() async {
    try {
      final auth = await Auth.user();
      final res = await api.user.getData(auth.id!);
      user.value = User.fromJson(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future getUserKasbon() async {
    try {
      final auth = await Auth.user();
      final res = await api.kasbon.getDataKasbon(auth.id!);
      logg('ini data kasbon userId $res');

      if (res.data != null && res.data is List && res.data.isNotEmpty) {
        dataKas.value = Kasbon.fromJson(res.data[0]); // Ambil elemen pertama
      } else {
        logg("Data kasbon kosong");
        dataKas.value = Kasbon();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future onPageInit() async {
    try {
      await getUserLogged();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    getUserKasbon();
    // getUser();
    // getCurrent();
    getUserLogged();
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate;
    }
  }

  void showAjukanForm(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          insetPadding: EdgeInsets.zero,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            padding: EdgeInsets.zero,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CA1AF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "Form Pengajuan Kasbon",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nomor Pengajuan',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextField(
                            controller: nominalController.value,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Tanggal Pengajuan",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          GestureDetector(
                            onTap: () => pickDate(context),
                            child: Obx(() => Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    selectedDate.value == null
                                        ? "Pilih Tanggal"
                                        : selectedDate.value!
                                            .format('dd MMM y'),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                )),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Nominal Kasbon",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            controller: nominalController.value,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Keterangan",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextField(
                            controller: keteranganController.value,
                            maxLines: 3,
                            style: TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: '808080'.hex,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "BATAL",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (selectedDate.value == null ||
                                nominalController.value.text.isEmpty) {
                              Get.snackbar("Gagal", "Harap isi semua data!",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                              return;
                            }
                            Get.snackbar("Berhasil", "Kasbon diajukan!",
                                backgroundColor: Colors.transparent,
                                colorText: Colors.white);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Color(0xFF4CA1AF),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "KIRIM",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
