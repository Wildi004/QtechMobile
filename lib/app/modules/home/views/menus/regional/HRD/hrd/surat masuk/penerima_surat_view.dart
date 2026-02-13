import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/surat_menyurat_controller/surat%20menyurat%20hrd/send_surat_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class PenerimaSuratView extends GetView<SendSuratController> {
  const PenerimaSuratView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Penerima',
        actions: [
          IconButton(
              onPressed: () => controller.addMember(), icon: Icon(Hi.plusSign)),
        ],
      ).appBar,
      body: Obx(() {
        final members = controller.members;

        return LzListView(
          children: members.generate((data, i) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: LzForm.select(
                        hint: 'Pilih Penerima',
                        style: OptionPickerStyle(withSearch: true),
                        model: data.key('penerima'),
                        onTap: () => controller.openUser(i),
                        onChange: (val) {
                          final id = int.tryParse(val);
                          if (id != null) {
                            if (!controller.selectedDepIds.contains(id)) {
                              controller.selectedDepIds.add(id);
                            }
                          }
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () => controller.removeMember(i),
                      icon: Icon(Hi.cancel02, color: Colors.red),
                    ),
                  ],
                ),
              ],
            );
          }),
        );
      }),
    );
  }
}
