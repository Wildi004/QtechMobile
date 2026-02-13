import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Kasbon%20Dev%20Bsd/create_kasbon_bsd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/icon_action_widget.dart';

class CreateKasbonBsdView extends GetView<CreateKasbonBsdController> {
  const CreateKasbonBsdView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateKasbonBsdController());
    final forms = controller.forms;
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Form Kasbon BSD',
        actions: [
          IconAction(Hi.add01, onTap: () {
            controller.addItem();
          }),
          IconAction(Hi.tick04, onTap: () {
            controller.onSubmit();
          }),
        ],
      ).appBar,
      body: Obx(() {
        bool loading = controller.isLoading.value;

        if (loading) {
          return CustomLoading();
        }
        return LzListView(
          gap: 10,
          children: [
            LzForm.input(
                label: 'No. Pengajuan',
                enabled: false,
                model: forms.key('no_pengajuan_reg')),
            Intrinsic(
              gap: 10,
              children: [
                LzForm.input(
                    label: 'Tgl Pengajuan',
                    enabled: false,
                    model: forms.key('tgl_pengajuan')),
                LzForm.input(
                    label: 'Departemen',
                    enabled: false,
                    model: forms.key('dep_name')),
              ],
            ),
            LzForm.input(
              label: 'Saldo',
              enabled: false,
              model: forms.key('saldo_akhir_bsd'),
            ),
            LzForm.input(
                label: 'Regional Name',
                enabled: false,
                model: forms.key('regional_name')),
            Divider(
              color: Colors.grey.shade700,
              thickness: 1,
            ),
            ...controller.formItems.generate((formItem, i) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Item ${controller.formItems.length - i}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.itemExpanded[i] =
                                  !controller.itemExpanded[i];
                            },
                            child: Icon(
                              controller.itemExpanded[i]
                                  ? Icons.remove
                                  : Icons.add,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              controller.removeItem(i);
                            },
                            child: const Icon(Icons.close,
                                size: 22, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (controller.itemExpanded[i])
                    Stack(
                      children: [
                        LzCard(
                          gap: 10,
                          children: [
                            LzForm.input(
                              label: "Jenis",
                              enabled: false,
                              model: formItem.key('nama_pengajuan'),
                            ),
                            LzForm.select(
                              label: "Keterangan",
                              hint: 'Pilih Kasbon Karyawan',
                              model: formItem.key('no_pengajuan_dep_label'),
                              options: controller.dataKasbon.map((e) {
                                final no = e.noPengajuan ?? '-';
                                final user = e.user ?? '-';
                                return '$no - $user';
                              }).toList(),
                              style: OptionPickerStyle(
                                withSearch: true,
                                maxLines: 2,
                              ),
                              onChange: (label) {
                                controller.onKasbonChanged(i, label);
                              },
                            ),
                            LzForm.input(
                              label: "Nilai Pengajuan",
                              enabled: false,
                              model: formItem.key('total_harga'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  Divider(
                    color: Colors.grey.shade700,
                    thickness: 1,
                  ),
                  const SizedBox(height: 20),
                ],
              );
            })
          ],
        );
      }),
    );
  }
}
