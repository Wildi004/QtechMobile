import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/saldo_all_dep.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/saldo_dep_bsd.dart';
import 'package:qrm_dev/app/data/models/model%20keuangan/saldo_kas_awal_list.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/monitoring%20proyek%20timur/monitor_proyek_timur_view.dart';

class SaldoDistribusiController extends GetxController with Apis {
  final forms = LzForm.make([
    'keterangan',
    'tgl_terima',
    'kredit',
    'dep',
    'saldo_akhir_bsd',
    'saldo_akhir_it',
    // card 1
    'kode_akun_1',
    'nama_akun_1',
    'perkiraan_1',

    // card 2
    'kode_akun_2',
    'nama_akun_2',
    'perkiraan_2',
  ]);
  RxBool isLoading = true.obs;

  Rxn<SaldoDepBsd> saldo = Rxn<SaldoDepBsd>();

  final dep = [
    {'id': 1, 'name': 'Direksi'},
    {'id': 11, 'name': 'IT'},
    {'id': 12, 'name': 'R&D'},
  ];
  Future<List<Map>> getDep() async {
    return dep;
  }

  final type = [
    {'id': 1, 'name': 'Debit'},
    {'id': 2, 'name': 'Kredit'},
  ];
  Future<List<Map>> getType() async {
    return type;
  }

  Future<void> getSaldo() async {
    try {
      final res = await api.saldoAllDep.getData();

      final saldo = SaldoAllDep.fromJson(res.data);

      forms.set('saldo_akhir_bsd', formatRupiah(saldo.saldoAkhirBsd ?? 0));

      forms.set('saldo_akhir_it', formatRupiah(saldo.saldoAkhirIt ?? 0));
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  RxList<SaldoKasAwalList> kodeAkun = <SaldoKasAwalList>[].obs;
  RxList<FormManager> formKode = RxList([]);

  Future<void> getkodeAKun() async {
    if (kodeAkun.isEmpty) {
      final res = await api.saldoKasAwalList.getData().ui.loading();
      kodeAkun.assignAll(
        SaldoKasAwalList.fromJsonList(res.data),
      );
    }
  }

  void setNamaAkun(dynamic value, String namaKey) {
    final item = kodeAkun.firstWhere(
      (e) => e.kodeAkun.toString() == value.toString(),
      orElse: () => SaldoKasAwalList(),
    );

    if (item.namaAkun != null) {
      forms.set(namaKey, item.namaAkun);
    }
  }

  void setUnit(dynamic value) {
    logg('value dari select: $value');

    final item = kodeAkun.firstWhere(
      (e) => e.kodeAkun.toString() == value.toString(),
      orElse: () {
        logg('❌ TIDAK KETEMU DENGAN KODE AKUN');
        return SaldoKasAwalList();
      },
    );

    if (item.namaAkun != null) {
      logg('✅ SET NAMA AKUN: ${item.namaAkun}');
      forms.set('nama_akun', item.namaAkun);
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ();
      getSaldo();
      getkodeAKun();
    });
  }

  Future<void> onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*']);
      if (!form.ok) return;

      final value = form.value;

      // ambil kode akun (yang dipilih)
      final kode1 = value['kode_akun_1'];
      final kode2 = value['kode_akun_2'];

      // ambil ID dari extra
      final perkiraan1 = forms.extra('perkiraan_1'); // int
      final perkiraan2 = forms.extra('perkiraan_2'); // int
      final depId = forms.extra('dep'); // int

      // mapping kode akun → id akun
      final akun1 = kodeAkun.firstWhere(
        (e) => e.kodeAkun.toString() == kode1.toString(),
        orElse: () => SaldoKasAwalList(),
      );

      final akun2 = kodeAkun.firstWhere(
        (e) => e.kodeAkun.toString() == kode2.toString(),
        orElse: () => SaldoKasAwalList(),
      );

      final payload = {
        'keterangan': value['keterangan'],
        'tgl_terima': value['tgl_terima'],
        'kredit': parseCurrency(value['kredit']),
        'dep_id': depId,
        'id_akun': [akun1.id, akun2.id],
        'perkiraan': [perkiraan1, perkiraan2],
      };

      logg('===== PAYLOAD FINAL =====');
      payload.forEach((k, v) => logg('$k : $v'));

      // 🚀 KIRIM KE API
      final res = await api.saldoDepBsd
          .createData(payload)
          .ui
          .loading('Menambahkan...');

      if (res.status) {
        Get.back(result: res.data);
        Get.snackbar('Berhasil', res.message ?? '');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

int parseCurrency(dynamic value) {
  if (value == null) return 0;
  return int.tryParse(
        value.toString().replaceAll(RegExp(r'[^0-9]'), ''),
      ) ??
      0;
}
