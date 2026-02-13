import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';

class CreateRabHrdController extends GetxController with Apis {
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'periode',
    'nama_item',
    'kategori_rab',
    'jumlah',
    'minggu_ke',
    'satuan',
    'total',
    'sub_total',
    'overheat',
    'catatan',
  ]);

  RxList<FormManager> formRabs = RxList([]);

  RxInt grandTotal = 0.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      addRab();
    });

    isLoading.value = false;
  }

  void removeRab(int index) {
    formRabs.removeAt(index);
    kat.removeAt(index);

    if (formRabs.isEmpty) {
      grandTotal.value = 0;
    } else {
      grandTotal.value = formRabs
          .map((e) => (e.get('sub_total') ?? '0').toString().numeric)
          .fold(0, (a, b) => a + b);
    }
  }

  RxList<int> cards = <int>[].obs;

  void addRab() {
    final form = LzForm.make([
      'nama_item',
      'kategori_rab',
      'jumlah',
      'minggu_ke',
      'satuan',
      'total',
      'sub_total',
      'overheat',
      'catatan',
    ]);

    formRabs.insert(0, form);
    final newId = (cards.isEmpty ? 0 : (cards.first + 1));
    cards.insert(0, newId);
    kat.insert(0, null);
  }

  void onChange(int index, String type) {
    if (type == 'priority') {
      kat[index] = formRabs[index].extra('kategori_rab');
    }
  }

  void countSubTotal(int index) {
    final total = (formRabs[index].get('total') ?? '').toString().numeric;
    final overheat = (formRabs[index].get('overheat') ?? '').toString().numeric;

    final subTotal = (total + (total * (overheat / 100))).round();
    formRabs[index]
        .set('sub_total', subTotal.currency(separator: ',', prefix: ''));

    grandTotal.value = formRabs
        .map((e) => (e.get('sub_total') ?? 0).toString().numeric)
        .fold(0, (a, b) => a + b);
  }

  Future<void> onSubmit() async {
    try {
      for (var f in formRabs) {
        f.validate(required: [
          'nama_item',
          'kategori_rab',
          'total',
          'overheat',
          'catatan'
        ]);
      }

      final payload = {
        'kategori_rab': kat,
        'periode': forms.get('periode'),
        'minggu_ke':
            formRabs.map((e) => (e.get('minggu_ke') ?? '0').numeric).toList(),
        'nama_item': formRabs.map((e) => e.get('nama_item') ?? '').toList(),
        'total': formRabs
            .map((e) => (e.get('total') ?? '0').toString().numeric.toString())
            .toList(),
        'overheat':
            formRabs.map((e) => (e.get('overheat') ?? '0').numeric).toList(),
        'catatan': formRabs.map((e) => e.get('catatan') ?? '').toList(),
      };

      final res = await api.rabGlobal
          .createDataRabHrd(payload)
          .ui
          .loading('Memproses...');

      if (res.status) {
        Get.back(result: res.data);
        Get.snackbar('Berhasil', res.message ?? '');
      } else {
        Toast.show(res.message ?? 'Gagal mengirim data');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  List<Map<String, dynamic>> kategori = [];

  final minggu = [
    {'id': 1, 'minggu_ke': 'Minggu ke 1'},
    {'id': 2, 'minggu_ke': 'Minggu ke 2'},
    {'id': 3, 'minggu_ke': 'Minggu ke 3'},
    {'id': 4, 'minggu_ke': 'Minggu ke 4'},
    {'id': 5, 'minggu_ke': 'Minggu ke 5'},
  ];
  Future<List<Map>> getMinggu() async {
    return minggu;
  }

  Future openKategori(int index) async {
    try {
      if (kategori.isEmpty) {
        final res = await api.kategoriRab.getData().ui.loading();
        kategori = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      formRabs[index].set('kategori_rab', '').options(
            kategori
                .where((e) => e['kategori'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['kategori'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  List<String?> kat = [];

  void openSelecKat(int index) {
    try {
      kat[index] = formRabs[index].extra('kategori_rab');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
