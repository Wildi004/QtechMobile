import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20it/laporan_it_tanggal.dart';

class LaporanItTanggalController extends GetxController with Apis {
  RxBool isLoading = true.obs;
  RxList<LaporanItTanggal> rkPicList = <LaporanItTanggal>[].obs;
  RxString searchQuery = "".obs;
  List<LaporanItTanggal> listRk = [];
  bool isLoaded = false;
  Future loadRkPic(String encryptedTglRencana, String encryptedPic) async {
    if (isLoaded) return;
    isLoaded = true;

    try {
      // StackItemAnimasi.animatedItems.clear();

      isLoading.value = true;
      final res = await api.rk.getTanggalIt(encryptedTglRencana, encryptedPic);
      final rawList = res.data as List<dynamic>;
      final parsedList = LaporanItTanggal.fromJsonList(rawList);

      listRk = parsedList;
      rkPicList.value = parsedList;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future sendToTelegram(String encryptedTglRencana, String encryptedPic) async {
    try {
      isLoading.value = true;

      final res =
          await api.rk.sendToTelegramIt(encryptedTglRencana, encryptedPic);

      Toast.success(res.data['message'] ?? 'Berhasil mengirim ke Telegram');
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();

    rkPicList.value = listRk
        .where((data) =>
            data.namaPekerjaan?.toLowerCase().contains(searchQuery.value) ??
            false)
        .toList();
  }
}
