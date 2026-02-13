import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/inv_del_pemb_ppn/inv_del_pemb_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/validasi%20logistik%20bali/validasi%20inv%20del%20pemb%20ppn/form_validasi_inv_del_pemb_ppn_controller.dart';

class FormValidasiInvDelPembPpnView
    extends GetView<FormValidasiInvDelPembPpnController> {
  final InvDelPembPpn? data;
  const FormValidasiInvDelPembPpnView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormValidasiInvDelPembPpnController());

    if (data != null) {
      controller.data = data;
    }

    return AlertDialog(
      backgroundColor: Color(0xFFF1F1F1),
      contentPadding: const EdgeInsets.all(20),
      title: const Text(
        'Validasi Invoice Delivery Pembelian PPN',
        style: TextStyle(fontWeight: Fw.bold),
      ),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LzForm.select(
                label: 'Kesimpulan Validasi',
                style: OptionPickerStyle(withSearch: true),
                hint: 'Pilih Kesimpulan Validasi',
                model: controller.forms.key('kesimpulan_status_validasi'),
                onTap: () async {
                  final data = await controller.getFinal().overlay();
                  controller.forms
                      .set('kesimpulan_status_validasi')
                      .options(data.labelValue('name', 'id'));
                },
              ),
              SizedBox(height: 20),
              LzButton(
                text: data == null ? 'Submit' : 'Update',
                onTap: () {
                  controller.onSubmit(data?.noHide);
                },
              ).margin(all: 20),
            ],
          );
        },
      ),
    );
  }
}
