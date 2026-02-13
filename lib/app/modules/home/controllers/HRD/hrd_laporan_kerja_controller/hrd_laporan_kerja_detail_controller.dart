// import 'package:get/get.dart';
// import 'package:lazyui/lazyui.dart';
// import 'package:qrm_dev/app/data/apis/api.dart';
// import 'package:qrm_dev/app/data/models/models%20hrd/rk_detail.dart';

// class HrdLaporanKerjaDetailController extends GetxController with Apis {
//   RxBool isLoading = true.obs;
//   Rxn<RkDetail> pekerjaan = Rxn<RkDetail>();

//   Future getData(int id) async {
//     try {
//       isLoading.value = true;
//       final res = await api.rk.getRkPicDetail(id);

//       if (res.data is List && res.data.isNotEmpty) {
//         pekerjaan.value = RkDetail.fromJson(res.data[0]);
//       } else {
//         pekerjaan.value = null;
//       }
//     } catch (e, s) {
//       Errors.check(e, s);
//       pekerjaan.value = null;
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
