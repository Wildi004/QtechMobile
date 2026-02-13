import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/absen_user.dart';
import 'package:qrm_dev/app/data/models/user.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class AbsenceController extends GetxController with Apis {
  final ScrollController scrollController = ScrollController();
  RxBool isLoading = true.obs;
  RxBool isLoadingUser = false.obs;
  RxBool isLoadingAbsensi = false.obs;
  RxList<Map<String, dynamic>> rawAbsensi = <Map<String, dynamic>>[].obs;
  Rxn<User> user = Rxn<User>();
  Rxn<AbsenUser> absen = Rxn<AbsenUser>();
  RxList<Map<String, dynamic>> absensiData = <Map<String, dynamic>>[].obs;
  Future<void> getUserLogged() async {
    try {
      isLoadingUser.value = true;
      final auth = await Auth.user();
      final res = await api.user.getData(auth.id!);
      user.value = User.fromJson(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoadingUser.value = false;
    }
  }

  Future<void> getUserAbsen() async {
    try {
      isLoadingAbsensi.value = true;
      final res = await api.absensi.getDataView();
      List<Map<String, dynamic>> data = [];
      if (res.data is List) {
        data = List<Map<String, dynamic>>.from(res.data);
      } else {
        data = [Map<String, dynamic>.from(res.data)];
      }
      rawAbsensi.assignAll(data);
      groupAbsensiByMonth(data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoadingAbsensi.value = false;
    }
  }

  int totalLateMinutesByMonth(String bulan) {
    int totalMinutes = 0;
    for (final group in absensiData) {
      if (group['bulan'] != bulan) continue;
      final List list = group['data'];
      for (final item in list) {
        if (item['isLate'] == true && item['time_in'] != '-') {
          final checkIn = DateTime.parse('1970-01-01 ${item['time_in']}:00');
          final limit = DateTime.parse('1970-01-01 09:00:00');
          final diff = checkIn.difference(limit).inMinutes;
          if (diff > 0) totalMinutes += diff;
        }
      }
    }
    return totalMinutes;
  }

  int countLate(List<Map<String, dynamic>> data) {
    int total = 0;
    for (final item in data) {
      final timeIn = item['time_in'];
      if (timeIn == null || timeIn == "00:00:00") continue;
      final checkIn = DateTime.parse("1970-01-01 $timeIn");
      final limit = DateTime.parse("1970-01-01 09:00:00");
      if (checkIn.isAfter(limit)) {
        total++;
      }
    }
    return total;
  }

  void groupAbsensiByMonth(List<Map<String, dynamic>> absensiList) {
    if (absensiList.isEmpty) {
      absensiData.clear();
      return;
    }
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    for (final item in absensiList) {
      final tanggal = item["presence_date"];
      final presentName = item["present_name"];
      final timeIn = item["time_in"];
      final timeOut = item["time_out"];
      if (tanggal == null || tanggal == "") continue;
      final date = DateTime.parse(tanggal);
      final bulan = DateFormat('MMMM yyyy', 'id_ID').format(date);
      bool isLate = false;
      if (timeIn != null && timeIn != "00:00:00") {
        final checkIn = DateTime.parse("1970-01-01 $timeIn");
        final limitTime = DateTime.parse("1970-01-01 09:00:00");
        isLate = checkIn.isAfter(limitTime);
      }
      grouped.putIfAbsent(bulan, () => []);
      grouped[bulan]!.add({
        "tanggal": DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(date),
        "status": presentName ?? '-',
        "isLate": isLate,
        "time_in": (timeIn == null || timeIn == "00:00:00")
            ? "-"
            : timeIn.substring(0, 5),
        "time_out": (timeOut == null || timeOut == "00:00:00")
            ? "-"
            : timeOut.substring(0, 5),
        "picture_in": item["picture_in"],
        "picture_out": item["picture_out"],
      });
    }
    absensiData.assignAll(
      grouped.entries.map((e) => {"bulan": e.key, "data": e.value}).toList(),
    );
  }

  bool alreadyLoaded = false;

  Future<void> onPageInit({bool refresh = false}) async {
    if (!refresh && alreadyLoaded) return;
    alreadyLoaded = true;
    isLoading.value = true;
    await Future.wait([
      getUserLogged(),
      getUserAbsen(),
    ]);

    isLoading.value = false;
  }

  void showDetailDialog(Map<String, dynamic> absen) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text('Detail Absensi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _item('Tanggal', absen['tanggal']),
            _item('Status', absen['status']),
            _item(
              'Keterangan',
              absen['isLate'] == true ? 'Terlambat' : 'Tepat Waktu',
            ),
            _item('Time In', absen['time_in']),
            _item('Time Out', absen['time_out']),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  // Widget _photoItem({
  //   required String label,
  //   String? fileName,
  // }) {
  //   return Column(
  //     children: [
  //       Text(
  //         label,
  //         style: const TextStyle(
  //           fontWeight: FontWeight.w600,
  //           fontSize: 12,
  //         ),
  //       ),
  //       const SizedBox(height: 6),
  //       fileName != null && fileName.isNotEmpty
  //           ? LzImage(
  //               '${AppConfig.baseUrl}/storage/absen/$fileName',
  //               size: 59,
  //               radius: 8,
  //               fit: BoxFit.cover,
  //             )
  //           : Container(
  //               width: 50,
  //               height: 50,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                 color: Colors.grey.shade300,
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               child: const Icon(Icons.image_not_supported, size: 18),
  //             ),
  //     ],
  //   );
  // }

  Widget _item(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(': $value')),
        ],
      ),
    );
  }
}
