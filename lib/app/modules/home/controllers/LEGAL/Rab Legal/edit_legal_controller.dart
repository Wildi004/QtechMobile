import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20legal/rab_legal/rab_detail.dart';
import 'package:qrm_dev/app/data/models/model%20legal/rab_legal/rab_legal.dart';

class EditLegalController extends GetxController with Apis {
  RabLegal? data;
  final isFilled = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'periode',
    'nama_item',
    'kategori_rab',
    'jumlah',
    'kategori_rab_name',
    'minggu_ke',
    'satuan',
    'total',
    'sub_total',
    'overheat',
    'catatan',
  ]);

  final id = Get.parameters['id'];

  RabLegal details = RabLegal();
  RxList<RabDetailLegal> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();
  Future getDetails(RabLegal data) async {
    try {
      int? id = data.id;
      final res = await api.rabGlobal.getLegalId(id!);
      details = RabLegal.fromJson(res.data ?? {});
      cards.value = details.rabDetail ?? [];

      formRabs.value = cards.map((e) {
        final form = LzForm.make([
          'nama_item',
          'catatan',
          'kategori_rab',
          'overheat',
          'minggu_ke',
          'total',
          'item_id',
          'sub_total',
          'jumlah',
        ]);

        final totalHargaVal = _parseToNum(e.subTotal);
        rabIds.add(e.kategoriRab);

        form.fill({
          'nama_item': e.namaItem ?? '-',
          'catatan': e.catatan ?? '-',
          'kategori_rab': e.kategoriRab?.toString() ?? '',
          'item_id': e.id,
          'overheat': e.overheat ?? '',
          'total': e.total ?? '',
          'sub_total': totalHargaVal,
        });

        // fill data options
        form.set('minggu_ke', e.mingguKe.toString());
        form.set('kategori_rab', e.kategoriRabName.toString());
        // form.set('kategori_rab', Option(e.kategoriRabName.toString(), value: e.kategoriRab));
        return form;
      }).toList();

      grandTotal.value = formRabs
          .map((e) => (e.get('sub_total') ?? 0).toString().numeric)
          .fold(0, (a, b) => a + b);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  num _parseToNum(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value;
    if (value is String) {
      return num.tryParse(value.replaceAll(',', '').replaceAll(' ', '')) ?? 0;
    }
    return 0;
  }

  @override
  void onInit() {
    super.onInit();
    if (data != null) {
      forms.fill(data!.toJson());
      getDetails(data!);
      kategoriRab.add(LzForm.make(['kategori_rab']));
    }
  }

  //update mode
  RxList<FormManager> formRabs = RxList([]);
  RxList<String> types = RxList([]);
  RxInt tab = 0.obs;
  RxInt grandTotal = 0.obs;

  RxList<FormManager> kategoriRab = RxList<FormManager>();
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

  Future getKategori(int? id) async {
    final res = await api.kategoriRab.getData();
    kategori = List<Map<String, dynamic>>.from(res.data ?? []);

    if (kategori.isNotEmpty) {
      kategoriRab[0].set('kategori_rab', '').options(
            kategori
                .where((e) => e['kategori'] != null && e['id'] != null)
                .map((e) => {
                      'label': e['kategori'].toString(),
                      'value': e['id'].toString(),
                    })
                .toList(),
          );
    } else {
      kategoriRab[0].set('kategori_rab', '').options([]);
    }

    // get data kategori
    final result = kategori.firstWhere((e) => e['id'] == id, orElse: () => {});

    if (result['id'] != null) {
      forms.set(
          'kategori_rab', Option(result['kategori'], value: result['id']));
    }
  }

  Future openKategori(int index) async {
    try {
      if (kategori.isEmpty) {
        final res = await api.kategoriRab.getData().ui.loading();
        kategori = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      final raw = kategori
          .where((e) => e['kategori'] != null && e['id'] != null)
          .map((e) => {
                'label': e['kategori'].toString(),
                'value': e['id'].toString(),
              })
          .toList();

      formRabs[index].set('kategori_rab').options(
            raw.labelValue('label', 'value'),
          );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void removeRab(int index) {
    formRabs.removeAt(index);
    rabIds.removeAt(index);
    if (formRabs.isEmpty) {
      grandTotal.value = 0;
    } else {
      grandTotal.value = formRabs
          .map((e) => (e.get('sub_total') ?? '0').toString().numeric)
          .fold(0, (a, b) => a + b);
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

  List<int?> rabIds = [];

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
      'item_id',
    ]);

    formRabs.insert(0, form);
    rabIds.insert(0, null);
  }

  void onChangeRab(String label, int index) {
    int? id = kategori.firstWhere((e) => e['kategori'] == label,
        orElse: () => {})['id'];
    rabIds[index] = id;
  }

  Future<void> onSubmit() async {
    try {
      // final form = forms.validate(required: ['*']);
      final itemIds = formRabs
          .map((form) {
            final id = form.get('item_id');
            return id is int ? id : int.tryParse('$id');
          })
          .whereType<int>()
          .toList();
      final namaItems = formRabs.map((e) => e.get('nama_item') ?? '').toList();

      if (rabIds.contains(null)) {
        return Toast.show('Lengkapi kategori RAB!');
      }

      final overheats =
          formRabs.map((e) => (e.get('overheat') ?? '0').numeric).toList();
      final totals = formRabs
          .map((e) => (e.get('total') ?? '0').toString().numeric.toString())
          .toList();
      final catatans = formRabs.map((e) => e.get('catatan') ?? '').toList();

      final mingguKes =
          formRabs.map((e) => (e.get('minggu_ke') ?? '0').numeric).toList();

      final payload = {
        'periode': forms.get('periode'),
        'minggu_ke': mingguKes,
        'nama_item': namaItems,
        'total': totals,
        'overheat': overheats,
        'catatan': catatans,
        'kategori_rab': rabIds,
        'item_id': itemIds,
      };

      final res = await api.rabGlobal
          .updateLegal(payload, data!.id!)
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
}
