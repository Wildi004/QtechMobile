import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

import '../controllers/form_notulen_controller.dart';

class ListMembersView extends GetView<FormNotulenController> {
  const ListMembersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Daftar Peserta',
        actions: [
          IconButton(
              onPressed: () => controller.addMember(), icon: Icon(Hi.plusSign)),
        ],
      ).appBar,
      body: Obx(() {
        final members = controller.members;

        return LzListView(
          gap: 30,
          children: members.generate((data, i) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: LzForm.select(
                        hint: 'Pilih peserta',
                        style: OptionPickerStyle(withSearch: true),
                        model: data.key('user_id'),
                        onTap: () => controller.openUser(i),
                      ),
                    ),
                    IconButton(
                      onPressed: () => controller.removeMember(i),
                      icon: Icon(Hi.cancel02, color: Colors.red),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: LzForm.select(
                        hint: 'Pilih role',
                        style: OptionPickerStyle(withSearch: true),
                        model: data.key('role'),
                        onTap: () => controller.openRoles(i),
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
