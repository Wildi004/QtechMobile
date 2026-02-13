import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/rab_logistik/rab_detail.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/rab_logistik/rab_logistik.dart';

class RabLogistikDetailController extends GetxController with Apis {
  RabLogistik? data;
  final isFilled = false.obs;
  RxBool isLoading = true.obs;
  RxList<WeekGroup> weekGroups = RxList<WeekGroup>([]);
  final RxMap<int, bool> expandedWeeks = <int, bool>{}.obs;

  final forms = LzForm.make([
    'id',
    'kode_rab',
    'nama_item',
    'periode',
    'total',
    'sub_total',
    'catatan',
    'created_at',
    'kategori_rab_name',
    'overheat',
    'minggu_ke',
    'total_harga',
    'departemen_name'
  ]);

  final id = Get.parameters['id'];

  RabLogistik details = RabLogistik();
  RxList<RabDetaillogistik> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();

  Future getDetails(RabLogistik data) async {
    try {
      isLoading.value = true;

      final res = await api.rabGlobal.getLogistkById(data.id!);
      details = RabLogistik.fromJson(res.data ?? {});
      cards.value = details.rabDetail ?? [];

      final formatRp =
          NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

      // 1) Kelompokkan by minggu_ke
      final Map<int, List<RabDetaillogistik>> grouped = {};
      for (final e in cards) {
        final key = e.mingguKe ?? 0;
        grouped.putIfAbsent(key, () => []).add(e);
      }

      // 2) Build WeekGroup + init expanded flags
      final List<WeekGroup> groups = [];
      expandedWeeks.clear();

      final sortedEntries = grouped.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key));

      for (final entry in sortedEntries) {
        final minggu = entry.key;
        final items = entry.value;

        final formsPerMinggu = items.map((e) {
          final form = LzForm.make([
            'nama_item',
            'catatan',
            'kategori_rab_name',
            'overheat',
            'minggu_ke',
            'total_harga',
          ]);

          final totalHargaVal =
              _parseToNum(e.subTotal); // gunakan sub_total dari API
          form.fill({
            'nama_item': e.namaItem ?? '-',
            'catatan': e.catatan ?? '-',
            'kategori_rab_name': e.kategoriRabName ?? '',
            'overheat': e.overheat ?? '',
            'minggu_ke': e.mingguKe ?? '',
            'total_harga': formatRp.format(totalHargaVal),
          });

          return form;
        }).toList();

        final num subtotal =
            items.fold<num>(0, (acc, it) => acc + _parseToNum(it.subTotal));

        groups.add(WeekGroup(
          mingguKe: minggu,
          forms: formsPerMinggu,
          totalPerMinggu: subtotal,
        ));

        // default tertutup (ubah ke true kalau mau default terbuka)
        expandedWeeks.putIfAbsent(minggu, () => false);
      }

      weekGroups.value = groups;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void toggleWeek(int mingguKe) {
    expandedWeeks[mingguKe] = !(expandedWeeks[mingguKe] ?? false);
  }

  num _parseToNum(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value;
    if (value is String) {
      return num.tryParse(value.replaceAll(',', '').replaceAll(' ', '')) ?? 0;
    }
    return 0;
  }
}

class WeekGroup {
  final int mingguKe;
  final List<FormManager> forms;
  final num totalPerMinggu;
  WeekGroup({
    required this.mingguKe,
    required this.forms,
    required this.totalPerMinggu,
  });
}
