import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Ptj%20Dev%20Bsd/create_ptj_dep_bsd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/icon_action_widget.dart';

class CreatePtjDepBsdView extends GetView<CreatePtjDepBsdController> {
  const CreatePtjDepBsdView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreatePtjDepBsdController());
    final forms = controller.forms;
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (!controller.isSubmitted.value && controller.created != null) {
          await controller.deletePtj(controller.created!.noHide!);
        }
      },
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Form PTJ BSD',
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
                  label: 'No. PTJ',
                  enabled: false,
                  model: forms.key('no_ptj_reg')),
              Intrinsic(
                gap: 10,
                children: [
                  LzForm.input(
                      label: 'Tgl PTJ',
                      enabled: false,
                      model: forms.key('tgl_ptj')),
                  LzForm.input(
                      label: 'Regional Name',
                      enabled: false,
                      model: forms.key('regional_name')),
                ],
              ),
              LzForm.input(
                label: 'Saldo',
                enabled: false,
                model: forms.key('saldo_akhir_bsd'),
              ),
              Divider(
                color: Colors.grey.shade700,
                thickness: 1,
              ),
              ...controller.formItems.generate((forms, i) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LzForm.select(
                      label: 'Pilih Departemen',
                      hint: 'Pilih Departemen',
                      model: forms.key('dep'),
                      onTap: () async {
                        final data = await controller.statusV().overlay();
                        forms.set('dep').options(data.labelValue('name'));
                      },
                      onChange: (value) {
                        forms.set('dep_field', value);
                        forms.set('no_ptj_dep', '');
                        forms.set('no_ptj_dep').options([]);
                      },
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Detail PTJ ${controller.formItems.length - i}",
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
                                label: "Departemen",
                                enabled: false,
                                model: forms.key('dep_field'),
                              ),
                              LzForm.select(
                                label: "No. PTJ Departemen",
                                hint: 'Pilih No PTJ',
                                model: forms.key('no_ptj_dep'),
                                style: OptionPickerStyle(withSearch: true),
                                onTap: () => controller.openPengajuan(forms),
                                onChange: (value) {
                                  logg("VALUE SELECT: $value");
                                  controller.setSelectedPengajuan(
                                    forms,
                                    value.toString(),
                                    i,
                                  );
                                },
                              ),
                              LzForm.input(
                                label: "Nilai Pengajuan",
                                enabled: false,
                                model: forms.key('total_harga'),
                              ),
                            ],
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: IconButton(
                              onPressed: () {
                                controller.openDetailPengajuan();
                              },
                              icon: Icon(Hi.eye),
                            ),
                          )
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
      ),
    );
  }
}
