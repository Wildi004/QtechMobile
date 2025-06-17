import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/pengajuan_hrd/detail_history.dart';
import 'package:qrm/app/data/models/rab_validasi/rab_validasi.dart';
import 'package:qrm/app/data/models/rabdetail.dart';

class FormPengajuanController extends GetxController with Apis {
  DetailHistory? created;
  RxBool isLoading = true.obs;

  final forms = LzForm.make(['no_pengajuan', 'tgl_pengajuan', 'dep_name']);

  RxList<FormManager> formRabs = RxList([]);
  RxList<String> types = RxList([]);

  RxInt grandTotal = 0.obs;

  List<RabValidasi> dataRab = [];
  List<Rabdetail1> dataRabDetails = [];
  List<DetailHistory> dataPengajuan = [];

  @override
  void onInit() {
    createPengajuan();
    super.onInit();
  }

  Future<void> createPengajuan() async {
    try {
      isLoading.value = true;
      final res = await api.pengajuanHrd.createPengajuan();
      forms.fill(res.data ?? {});
      created = DetailHistory.fromJson(res.data ?? {});
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void removeRab(int index) {
    formRabs.removeAt(index);
    types.removeAt(index);

    if (formRabs.isEmpty) {
      grandTotal.value = 0;
    } else {
      grandTotal.value = formRabs
          .map((e) => (e.get('total') ?? '0').numeric)
          .reduce((a, b) => a + b);
    }
  }

  void addRab() {
    String type = types.isEmpty ? 'None' : types[0];

    final form =
        LzForm.make(['type', 'nama_item', 'jumlah', 'satuan', 'total']);

    formRabs.insert(0, form);
    formRabs[0].fill({'type': type});

    types.insert(0, type);

    Utils.timer(() {
      // set all radio based on types
      for (int i = 0; i < types.length; i++) {
        formRabs[i].set('type', types[i]);
      }
    }, 100.ms);
  }

  Future<void> getRab(String value, int index) async {
    if (value == 'RAB' && dataRabDetails.isEmpty) {
      final res = await api.rabdetail.getData().ui.loading();
      dataRabDetails = Rabdetail1.fromJsonList(res.data);
    }

    types[index] = value;
  }

  void setUnit(String value, int index) {
    final item = dataRabDetails.firstWhere(
      (e) => e.namaItem == value,
      orElse: () => Rabdetail1(),
    );

    if (item.total != null) {
      formRabs[index]
          .set('satuan', item.total.currency(separator: ',', prefix: ''));
    }
  }

  void countTotal(int index) {
    int unit = (formRabs[index].get('satuan') ?? '').numeric;
    int qty = (formRabs[index].get('jumlah') ?? '').numeric;

    int total = unit * qty;
    formRabs[index].set('total', total.currency(separator: ',', prefix: ''));

    grandTotal.value = formRabs
        .map((e) => (e.get('total') ?? '0').numeric)
        .reduce((a, b) => a + b);
  }

  Future<void> onSubmit() async {
    try {
      if (created == null) {
        return Toast.show('Tidak dapat diproses.');
      }

      final jenisRabs = types.map((e) => e == 'None' ? 'NonRAB' : e).toList();

      final namaBarangs =
          formRabs.map((e) => e.get('nama_item') ?? '').toList();

      final qtys =
          formRabs.map((e) => (e.get('jumlah') ?? '0').numeric).toList();
      final hargas =
          formRabs.map((e) => (e.get('satuan') ?? '0').numeric).toList();

      final itemIds = formRabs
          .map((form) {
            final id = form.get('item_id');
            return id is int ? id : null;
          })
          .whereType<int>()
          .toList();

      final rabIds = formRabs.map((form) {
        final namaItem = form.get('nama_item');
        final matched = dataRabDetails.firstWhere(
          (d) => d.namaItem == namaItem,
          orElse: () => Rabdetail1(),
        );
        return matched.id ?? 0;
      }).toList();

      final payload = {
        'no_pengajuan': created!.noPengajuan,
        'item_id': itemIds,
        'rab_id': rabIds,
        'jenis_rab': jenisRabs,
        'nama_barang': namaBarangs,
        'qty': qtys,
        'harga': hargas,
      };

      final res = await api.pengajuanHrd
          .updateData(payload, created!.noHide!)
          .ui
          .loading('Memproses...');

      if (res.status) {
        Toast.success('Berhasil mengupdate');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

// class FormPengajuanController extends GetxController with Apis {
//   DetailHistory? created;
//   RxBool isLoading = true.obs;
//   final forms = LzForm.make(['no_pengajuan', 'tgl_pengajuan', 'dep_name']);

//   Future createPengajuan() async {
//     try {
//       isLoading.value = true;
//       final res = await api.pengajuanHrd.createPengajuan();

//       // fill the forms
//       forms.fill(res.data ?? {});
//       created = DetailHistory.fromJson(res.data ?? {});
//     } catch (e, s) {
//       Errors.check(e, s);
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   @override
//   void onInit() {
//     createPengajuan();
//     super.onInit();
//   }

//   // RAB
//   RxList<FormManager> formRabs = RxList([]);
//   RxList<String> types = RxList([]);
//   List<RabValidasi> dataRab = [];
//   List<RabDetail> dataRabDetails = [];

//   void addRab() {
//     final forms =
//         LzForm.make(['type', 'nama_item', 'jumlah', 'satuan', 'total']);
//     formRabs.insert(0, forms);
//     types.insert(0, 'None');
//   }

//   // onTap Rab Select Option
//   void getRab(String value, int index) async {
//     // get data rab from api request
//     if (value == 'RAB') {
//       if (dataRab.isEmpty) {
//         final res = await api.rabValidasi.getData().ui.loading();
//         dataRab = RabValidasi.fromJsonList(res.data);
//         dataRabDetails =
//             List<RabDetail>.from(dataRab.expand((e) => e.rabDetail ?? []));
//       }
//     }

//     // change type by index
//     types[index] = value;
//   }

//   // set unit when select option rab is selected
//   void setUnit(String value, int index) {
//     final unit = dataRabDetails.firstWhere((e) => e.namaItem == value,
//         orElse: () => RabDetail());

//     if (unit.total != null) {
//       formRabs[index]
//           .set('satuan', unit.total.currency(separator: ',', prefix: ''));
//     }
//   }

//   // count total & grand total
//   RxInt grandTotal = 0.obs;

//   void countTotal(int index) {
//     int unit = (formRabs[index].get('satuan') ?? '').numeric;
//     int qty = (formRabs[index].get('jumlah') ?? '').numeric;

//     formRabs[index]
//         .set('total', (unit * qty).currency(separator: ',', prefix: ''));

//     // calculate grand total
//     grandTotal.value = formRabs
//         .map((e) => (e.get('total') ?? '0').numeric)
//         .reduce((a, b) => a + b);
//   }

//   // submit data
//   Future onSubmit() async {
//     try {
//       if (created == null) {
//         return Toast.show('Tidak dapat diproses.');
//       }

//       final itemIds = dataRabDetails.map((e) => e.id).toList();
//       final itemNames = dataRabDetails.map((e) => e.namaItem ?? '').toList();
//       final rabIds = dataRab.map((e) => e.id).toList();
//       final types = this.types.map((e) => e == 'None' ? 'NonRAB' : e).toList();
//       final qtys =
//           formRabs.map((e) => (e.get('jumlah') ?? '0').numeric).toList();
//       final units =
//           formRabs.map((e) => (e.get('satuan') ?? '0').numeric).toList();

//       Map<String, dynamic> data = {
//         'no_pengajuan': created?.noPengajuan,
//         'item_id[]': itemIds, // harusnya yang benar, diget dari api apa?
//         'rab_id[]': rabIds,
//         'jenis_rab': types,
//         'nama_barang[]': itemNames,
//         'qty[]': qtys,
//         'harga[]': units
//       };

//       final res = await api.pengajuanHrd
//           .updateData(data, created!.noHide!)
//           .ui
//           .loading('Memproses...');

//       if (res.status) {
//         Toast.success('Berhasil...');
//       }
//     } catch (e, s) {
//       Errors.check(e, s);
//     }
//   }
// }
