import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';

import '../controllers/form_notulen_controller.dart';

class ListMembersView extends GetView<FormNotulenController> {
  const ListMembersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Peserta'),
        actions: [
          IconButton(
              onPressed: () => controller.addMember(), icon: Icon(Hi.plusSign)),
        ],
      ),
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
