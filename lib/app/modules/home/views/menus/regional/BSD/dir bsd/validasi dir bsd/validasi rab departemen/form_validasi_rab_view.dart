import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/rab_it/rab_it.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/validasi%20rab%20departemen/form_validasi_rab_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class FormValidasiRabView extends GetView<FormValidasiRabsasController> {
  final RabIt? data;

  const FormValidasiRabView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormValidasiRabsasController()..data = data);
    final forms = controller.forms;
    String formatRupiah(num? value) {
      if (value == null) return '-';
      return NumberFormat.currency(
              locale: 'id', symbol: 'Rp ', decimalDigits: 0)
          .format(value);
    }

    final form = controller.forms;
    if (data != null) {
      form.fill(data!.toJson());
      controller.getDetails(data!);
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        appBar: CustomAppbar(
          title: 'Validasi RAB',
          actions: [
            IconButton(
              onPressed: () {
                controller.onSubmit(data?.id);
              },
              icon: const Icon(Hi.tick04),
            ),
          ],
        ).appBar,
        body: Obx(() {
          bool loading = controller.isLoading.value;

          if (loading) {
            return CustomLoading();
          }

          return Column(
            children: [
              Container(
                padding: Ei.all(20),
                decoration: BoxDecoration(border: Br.only(['b'])),
                child: Column(
                  spacing: 10,
                  children: [
                    LzForm.input(
                      label: 'Kode RAB',
                      enabled: false,
                      model: forms.key('kode_rab'),
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Tanggal Pengajuan',
                          enabled: false,
                          model: forms.key('periode'),
                        ),
                        LzForm.input(
                          label: 'Departemen',
                          enabled: false,
                          model: forms.key('departemen_name'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  final groups = controller.weekGroups;

                  if (controller.isLoading.value) {
                    return const CustomLoading();
                  }

                  return LzListView(
                    gap: 12,
                    autoCache: true,
                    children: [
                      ...List.generate(groups.length, (gi) {
                        final g = groups[gi];
                        final isOpen =
                            controller.expandedWeeks[g.mingguKe] ?? false;

                        final subtotalText = NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(g.totalPerMinggu);

                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: InkTouch(
                                onTap: () => controller.toggleWeek(g.mingguKe),
                                padding: Ei.sym(v: 10, h: 12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Minggu ke-${g.mingguKe}',
                                        style:
                                            Gfont.bold.copyWith(fontSize: 16),
                                      ),
                                    ),
                                    Text(subtotalText, style: Gfont.bold),
                                    8.width,
                                    Icon(isOpen
                                        ? Icons.expand_less
                                        : Icons.expand_more),
                                  ],
                                ),
                              ),
                            ),

                            // ISI — baru pakai LzCard, tapi tidak jadi tombol
                            if (isOpen)
                              ...List.generate(g.forms.length, (i) {
                                final form = g.forms[i];
                                return LzCard(
                                  color: Colors.white,
                                  gap: 10,
                                  children: [
                                    LzForm.input(
                                      label: 'Kategori RAB',
                                      enabled: false,
                                      model: form.key('kategori_rab_name'),
                                    ),
                                    LzForm.input(
                                      label: 'Nama Item',
                                      enabled: false,
                                      maxLines: 10,
                                      model: form.key('nama_item'),
                                    ),
                                    Intrinsic(
                                      gap: 10,
                                      children: [
                                        LzForm.input(
                                          label: 'Overheat',
                                          enabled: false,
                                          model: form.key('overheat'),
                                        ),
                                        LzForm.input(
                                          label: 'Minggu Ke',
                                          enabled: false,
                                          model: form.key('minggu_ke'),
                                        ),
                                      ],
                                    ),
                                    LzForm.input(
                                      label: 'Total Harga',
                                      enabled: false,
                                      model: form.key('total_harga'),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Catatan',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Html(
                                          data: form.get('catatan') ?? '-',
                                          style: {
                                            "body": Style(
                                              fontSize: FontSize(14),
                                              color: Colors.black87,
                                            ),
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                          ],
                        );
                      }),
                      LzForm.select(
                        label: 'Kesimpulan Validasi',
                        style: OptionPickerStyle(withSearch: true),
                        hint: 'Pilih Kesimpulan Validasi',
                        model:
                            controller.forms.key('kesimpulan_status_validasi'),
                        onTap: () async {
                          final data = await controller.getFinal().overlay();
                          controller.forms
                              .set('kesimpulan_status_validasi')
                              .options(data.labelValue('name', 'id'));
                        },
                      ),
                    ],
                  );
                }),
              ),
              Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Pengajuan dana :',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(formatRupiah(_parseToNum(data!.grandtotal)))
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
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
