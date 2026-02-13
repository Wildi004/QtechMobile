import 'package:get/get.dart';
import 'package:qrm_dev/app/data/apis/api.dart';

class EventHomeViewVontroller extends GetxController with Apis {
  final data = <Map<String, String>>[
    {
      'title': 'Sabtu Belajar !',
      'date': 'Sabtu, 4 Januari 2025',
      'location': 'Ruang Rapat LT.3 - Kantor',
    },
    {
      'title': 'Rapat Direksi !',
      'date': 'Sabtu, 4 Januari 2025',
      'location': "Q'offee Shop - Diponegoro",
    },
    {
      'title': 'Sabtu Ceria !',
      'date': 'Sabtu, Januari 2025',
      'location': 'Kuala Lumpur - Malaysia',
    },
  ].obs;
}
