import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20it/create_laporan/create_laporan.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class CreateLaporanKerjaLegalController extends GetxController with Apis {
  RxList<int> cards = <int>[].obs;
  RxList<FormManager> formRk = <FormManager>[].obs;
  List<int?> cardsid = [];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  void onInit() {
    super.onInit();
    addCard();
  }

  void addCard() {
    final form = LzForm.make(
      [
        'kategori',
        'sub_kategori',
        'prioritas',
        'status',
        'nama_pekerjaan',
        'keterangan'
      ],
    );

    formRk.insert(0, form);
    cardsid.insert(0, null);

    final newId = (cards.isEmpty ? 0 : (cards.first + 1));
    cards.insert(0, newId);

    priorities.insert(0, null);
    statuses.insert(0, null);
    rkIds.insert(0, null);
    listKey.currentState?.insertItem(0, duration: Duration(milliseconds: 300));
  }

  void removeCard(int index) {
    listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: LzCard(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Data ${cards.length - index}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
      duration: Duration(milliseconds: 300),
    );

    cards.removeAt(index);
    formRk.removeAt(index);
    cardsid.removeAt(index);
    priorities.removeAt(index);
    statuses.removeAt(index);
    rkIds.removeAt(index);
  }

  List<CreateLaporan> categories = [];
  Map<String, dynamic> query = {'auto': 1};

  final prioritas = [
    {'name': 'High', 'id': 1},
    {'name': 'Normal', 'id': 0},
  ];

  final status = [
    {'name': 'Selesai', 'id': 1},
    {'name': 'On Progress', 'id': 0},
  ];

  Future<List<Map>> getPrioritas() async {
    return prioritas;
  }

  Future<List<Map>> getStatus() async {
    return status;
  }

  Future<List<Map<String, dynamic>>> getCategoryOptions() async {
    try {
      if (categories.isEmpty) {
        final res = await api.rk.getLaporan(query).ui.loading();
        categories = CreateLaporan.fromJsonList(json.decode(res.body));
      }
      return categories
          .map((e) => {
                'label': e.keterangan,
                'value': e.keterangan,
              })
          .toList();
    } catch (e, s) {
      Errors.check(e, s);
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getSubCategoryOptions(String value) async {
    try {
      final data = categories.firstWhere(
        (e) => e.keterangan == value,
        orElse: () => CreateLaporan(),
      );

      if (data.keterangan == null) {
        Toast.error('Data tidak ditemukan');
        return [];
      }

      final subs = data.sub ?? [];
      return subs
          .map((e) => {
                'label': e.sub ?? '',
                'value': e.id ?? 0,
              })
          .toList();
    } catch (e, s) {
      Errors.check(e, s);
      return [];
    }
  }

  List priorities = [];
  List statuses = [];
  List rkIds = [];

  void onChange(int index, String type) {
    if (type == 'priority') {
      priorities[index] = formRk[index].extra('prioritas');
    } else if (type == 'status') {
      statuses[index] = formRk[index].extra('status');
    } else if (type == 'category') {
      rkIds[index] = formRk[index].extra('sub_kategori');
    }
  }

  Future<void> onSubmit() async {
    try {
      final auth = await Auth.user();

      List<bool> valids = [];

      for (var form in formRk) {
        final valid = form.validate(required: ['*', 'keterangan']);
        valids.add(valid.ok);
      }

      if (valids.contains(false)) {
        return Toast.warning('Lengkapi form!');
      }

      List jobs = [];
      List pics = [];
      List desc = [];

      for (var form in formRk) {
        jobs.add(form.get('nama_pekerjaan'));
        desc.add(form.get('keterangan'));
        pics.add(auth.id);
      }

      final payload = {
        'nama_pekerjaan': jobs,
        'prioritas': priorities,
        'status': statuses,
        'pic': pics,
        'kategori_rk_id': rkIds,
        'keterangan': desc
      };

      final res =
          await api.rk.createDataLegal(payload).ui.loading('Menyimpan...');

      if (res.status) {
        Toast.success('Data berhasil disimpan');
        Get.back(result: true);
      } else {
        Toast.error(res.message ?? 'Gagal menyimpan data');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
