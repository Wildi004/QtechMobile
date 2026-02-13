import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/proyek_item/proyek_item.dart';

class MonitoringProyekController extends GetxController with Apis {
  var dataBonus = [
    {
      "isExpanded": false.obs,
      "text1": "Info Proyek",
      "text2": "Info Pekerjaan"
    },
    {
      "isExpanded": false.obs,
    },
    {
      "isExpanded": false.obs,
    },
    {
      "isExpanded": false.obs,
    },
    {
      "isExpanded": false.obs,
    },
    {
      "isExpanded": false.obs,
    },
    {
      "isExpanded": false.obs,
    },
    {
      "isExpanded": false.obs,
    },
  ].obs;
  RxBool isLoading = true.obs;
  int page = 1;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  RxInt tab = 0.obs;
  RxInt showProfile = 0.obs;
  List<ProyekItems> dataProyek = [];

  final forms = LzForm.make(['kode_proyek']);
  Future getDataProyek() async {
    try {
      isLoading.value = true;
      final res = await api.dataProyek.getDataProyek(query);
      dataProyek = ProyekItems.fromJsonList(res.data);
      forms.fill({});
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    getDataProyek();
    super.onInit();
  }
}
